import 'dart:async';

import 'package:data/api/auth/api_user_service.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/api_message_service.dart';
import 'package:data/api/space/space_models.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/space_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:data/service/message_service.dart';
import 'package:data/api/message/message_models.dart';
import 'package:style/extenstions/date_extenstions.dart';

part 'chat_view_model.freezed.dart';

const MAX_PAGE_LIMIT = 20;

final chatViewStateProvider =
    StateNotifierProvider.family<ChatViewNotifier, ChatViewState, String>(
        (ref, threadId) {
  return ChatViewNotifier(
    threadId,
    ref.read(messageServiceProvider),
    ref.read(apiMessageServiceProvider),
    ref.read(apiUserServiceProvider),
    ref.read(spaceServiceProvider),
    ref.read(currentUserPod),
  );
});

class ChatViewNotifier extends StateNotifier<ChatViewState> {
  final String threadId;
  final MessageService messageService;
  final ApiMessageService apiMessageService;
  final ApiUserService userService;
  final SpaceService spaceService;
  final ApiUser? currentUser;

  bool _hasMoreItems = true;
  bool loadingData = false;
  StreamSubscription<List<ApiThreadMessage>>? _messageSubscription;

  ChatViewNotifier(this.threadId, this.messageService, this.apiMessageService,
      this.userService, this.spaceService, this.currentUser)
      : super(ChatViewState(
            message: TextEditingController(),
            currentUserId: currentUser?.id ?? ''));

  void onChange(String text) {
    state = state.copyWith(allowSend: text.trim().isNotEmpty);
  }

  void setData({
    required String spaceId,
    required bool show,
    required String threadId,
    required List<ThreadInfo> threadInfoList,
  }) {
    _getSpaceInfo(spaceId);
    if (threadId.isNotEmpty) {
      _getThreadInfo(threadId);
    }
    state = state.copyWith(showMemberSelectionView: show, threadId: threadId, threadList: threadInfoList);
  }

  void _getSpaceInfo(String spaceId) async {
    try {
      if (spaceId.isEmpty) return;
      state = state.copyWith(loading: true);
      final space = await spaceService.getSpaceInfo(spaceId);
      final userList = space?.members
          .where((user) => user.user.id != currentUser?.id,)
          .toList();
      state = state.copyWith(spaceInfo: space, users: userList ?? [], loading: false, error: null);
      _selectExistingThread();
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        "ChatViewNotifier: error while get space info",
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _getThreadInfo(String threadId) async {
    try {
      state = state.copyWith(loading: true);
      final threadInfo = await messageService.getThreadInfo(threadId);
      _getThreadMembers(threadInfo!.thread);
      final userList = threadInfo.members
          .where((user) => user.user.id != currentUser?.id,)
          .toList();
      _formatMemberNames(threadId.isEmpty ? [] : userList);
      state = state.copyWith(threadInfo: threadInfo, threadId: threadId, error: null);
      _listenThread(threadId);
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        "ChatViewNotifier: error while get thread info",
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _listenThread(String threadId) async {
    try {
      if (threadId.isEmpty) return;
      if (state.creating) return;
      _cancelMessageSubscription();
      state = state.copyWith(loading: state.messages.isEmpty);
      _messageSubscription = messageService.getLatestMessages(threadId, limit: 20).listen((messages) {
        state = state.copyWith(messages: messages, loading: false, error: null);
        _hasMoreItems = messages.length == MAX_PAGE_LIMIT;
      });
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while get thread',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void markMessageAsSeen(
      String threadId, List<ApiThreadMessage> message) async {
    try {
      final unReadMessage = message
          .where((message) => !message.seen_by.contains(currentUser?.id ?? ''))
          .map((message) => message.id)
          .toSet()
          .toList();

      if (unReadMessage.isNotEmpty) {
        await messageService.markMessageAsSeen(
            threadId, unReadMessage, currentUser?.id ?? '');
        state = state.copyWith(error: null);
      }
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while message mark as read',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _getThreadMembers(ApiThread thread) async {
    try {
      if (thread.id.isEmpty) return;
      state = state.copyWith(loading: true);
      final users = await messageService.getLatestMessageMember(thread);
      state = state.copyWith(sender: users, loading: false, error: null);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while get thread',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void sendMessage(String threadId, String message) async {
    try {
      if (message.isEmpty) return;
      state = state.copyWith(messageSending: true);
      final newMessage = await messageService.generateMessage(
          threadId: threadId,
          senderId: currentUser?.id ?? '',
          message: message);
      final newMessages = [newMessage, ...state.messages];
      state = state.copyWith(messages: newMessages);
      await messageService.sendMessage(newMessage);
      state = state.copyWith(
          messageSending: false,
          message: TextEditingController(text: ''),
          showMemberSelectionView: false,
          error: null);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while sending message',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void createNewThread(String message) async {
    try {
      state = state.copyWith(creating: true);
      _cancelMessageSubscription();
      List<String> selectedMembers = [];
      if (!selectedMembers.contains(currentUser?.id) &&
          state.selectedMember.isNotEmpty) {
        selectedMembers.addAll(state.selectedMember);
        selectedMembers.add(currentUser?.id ?? '');
      }
      List<String>? threadMembersIds = state.selectedMember.isNotEmpty
          ? selectedMembers
          : state.spaceInfo?.members.map((members) => members.user.id).toList();

      final threadId = await messageService.createThread(state.spaceInfo!.space.id, currentUser?.id ?? '', threadMembersIds ?? []);
      state = state.copyWith(showMemberSelectionView: false, threadId: threadId, isNewThread: true);
      if (threadId.isNotEmpty) {
        sendMessage(threadId, message);
        _getCreatedThread(threadId);
      }
      state = state.copyWith(
          showMemberSelectionView: false,
          threadId: threadId,
          isNewThread: true,
          error: null);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while create new thread',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _cancelMessageSubscription() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }

  void _getCreatedThread(String threadId) async {
    try {
      final thread = await messageService.getThreadInfo(threadId);
      _getThreadMembers(thread!.thread);
      state = state.copyWith(threadInfo: thread, sender: thread.members, error: null);
      final filteredMembers = thread.members
          .where((member) => member.user.id != state.currentUserId)
          .toList();
      _formatMemberNames(filteredMembers);
    } catch (error, stack) {
      logger.e('ChatViewNotifier: error while get threads',
          error: error, stackTrace: stack);
    }
  }

  void _selectExistingThread() {
    final userList = state.users.map((e) => e.user.id).toList();
    final List<String> selectedMembers = List.from(
        state.selectedMember.isEmpty ? userList : state.selectedMember);
    selectedMembers.add(currentUser?.id ?? '');

    final List<List<String>> threadMembers = state.threadList
        .map((threads) =>
            threads.members.map((e) => e.user.id.toString()).toList())
        .toList();

    bool hasMatchingThread = threadMembers.any((threadMember) =>
        _listsContainSameMembers(selectedMembers, threadMember));
    if (hasMatchingThread) {
      final matchingThreads = state.threadList.where((thread) {
        final List<String> threadMemberIds =
            thread.members.map((member) => member.user.id.toString()).toList();
        return _listsContainSameMembers(selectedMembers, threadMemberIds);
      }).toList();
      if (matchingThreads.isNotEmpty) {
        ThreadInfo matchedThread = matchingThreads.first;
        _listenThread(matchedThread.thread.id);
        _getThreadMembers(matchedThread.thread);
        _formatMemberNames(matchedThread.members);
        state = state.copyWith(
            threadId: matchedThread.thread.id,
            threadInfo: matchedThread,
            sender: matchedThread.members);
      }
    } else {
      state = state.copyWith(sender: [], messages: [], isNewThread: true, threadId: '', threadInfo: null);
    }
  }

  bool _listsContainSameMembers(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    final set1 = Set<String>.from(list1);
    final set2 = Set<String>.from(list2);
    return set1.containsAll(set2) && set2.containsAll(set1);
  }

  void _loadMoreMessages(String threadId, bool append) async {
    try {
      if ((loadingData) && threadId.isEmpty) return;
      state = state.copyWith(loadingMessages: state.messages.isEmpty);
      loadingData = true;
      final minMessage = state.messages
          .reduce((a, b) => a.createdAtMs < b.createdAtMs ? a : b);
      final newMessages = await messageService
          .getMessages(threadId, minMessage.created_at, limit: MAX_PAGE_LIMIT);
      _hasMoreItems = newMessages.length == MAX_PAGE_LIMIT;
      final allMessages = state.messages;
      final messages = append ? [...allMessages, ...newMessages] : allMessages;
      state = state.copyWith(
          messages: messages, loadingMessages: false, error: null);
      loadingData = false;
    } catch (error, stack) {
      logger.e(
        'ChatViewNotifier: error while load more chats',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void onLoadMore(String threadId) {
    if (!_hasMoreItems || loadingData) return;
    _loadMoreMessages(threadId, true);
  }

  bool isSender(ApiThreadMessage message) {
    return message.sender_id != currentUser?.id;
  }

  void _formatMemberNames(List<ApiUserInfo>? members) {
    final filteredMembers = members ?? state.threadInfo!.members
        .where((member) => member.user.id != state.currentUserId)
        .toList();
    state = state.copyWith(title: '');
    if (filteredMembers.length > 2) {
      state = state.copyWith(
          title:
              '${filteredMembers[0].user.first_name}, ${filteredMembers[1].user.first_name} +${filteredMembers.length - 2}');
    } else if (filteredMembers.length == 2) {
      state = state.copyWith(
          title:
              '${filteredMembers[0].user.first_name}, ${filteredMembers[1].user.first_name}');
    } else if (filteredMembers.length == 1) {
      state = state.copyWith(title: filteredMembers[0].user.first_name ?? '');
    } else {
      state = state.copyWith(title: 'Start a new chat');
    }
  }

  bool isFirstInGroupAtIndex(int index) {
    if (index == 0) {
      return true;
    } else {
      final message = state.messages[index];
      final previousMessage = state.messages[index - 1];
      return previousMessage.created_at!.hour != message.created_at!.hour ||
          previousMessage.created_at!.minute != message.created_at!.minute ||
          previousMessage.sender_id != message.sender_id;
    }
  }

  bool isLastInGroupAtIndex(int index) {
    if (index == state.messages.length - 1) {
      return true;
    } else {
      final message = state.messages[index];
      final nextMessage = state.messages[index + 1];
      return nextMessage.created_at!.hour != message.created_at!.hour ||
          nextMessage.created_at!.minute != message.created_at!.minute ||
          nextMessage.sender_id != message.sender_id;
    }
  }

  bool showDateHeader(int index, ApiThreadMessage message) {
    final DateTime? nextDate = index < state.messages.length - 1
        ? extractDate(state.messages[index + 1].created_at!.toLocal())
        : null;
    final showDateHeader =
        nextDate == null || nextDate != extractDate(message.created_at!);
    return showDateHeader;
  }

  bool showTimeHeader(int index, ApiThreadMessage message) {
    final bool isLastMessage = index >= state.messages.length - 1;

    if (isLastMessage) {
      return true;
    }

    final nextMessage = state.messages[index + 1];
    final bool isDifferentTime =
        message.created_at!.hour != nextMessage.created_at!.hour ||
            message.created_at!.minute != nextMessage.created_at!.minute;
    final bool isDifferentSender = message.sender_id != nextMessage.sender_id;

    return isDifferentTime || isDifferentSender;
  }

  void toggleMemberSelection(String memberId) {
    final List<String> selectedMembers = [...state.selectedMember];

    if (selectedMembers.contains(memberId)) {
      selectedMembers.remove(memberId);
    } else {
      selectedMembers.add(memberId);
    }

    state = state.copyWith(selectedMember: selectedMembers);
    _selectExistingThread();
  }

  void clearSelection() {
    state = state.copyWith(selectedMember: []);
    _selectExistingThread();
  }
}

@freezed
class ChatViewState with _$ChatViewState {
  const factory ChatViewState({
    @Default(false) bool loading,
    @Default(false) bool creating,
    @Default(false) bool loadingMessages,
    @Default(false) bool messageSending,
    @Default(false) bool allowSend,
    @Default(false) bool showMemberSelectionView,
    @Default(false) bool isNewThread,
    @Default([]) List<ApiUserInfo> users,
    @Default('') String threadId,
    @Default('') String title,
    required TextEditingController message,
    @Default([]) List<ApiThreadMessage> messages,
    @Default([]) List<ApiUserInfo> sender,
    @Default([]) List<String> selectedMember,
    Object? error,
    SpaceInfo? spaceInfo,
    ThreadInfo? threadInfo,
    required String currentUserId,
    @Default([]) List<ThreadInfo> threadList,
  }) = _ChatViewState;
}
