import 'package:data/api/auth/api_user_service.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/api_message_service.dart';
import 'package:data/api/space/space_models.dart';
import 'package:data/log/logger.dart';
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

final chatViewStateProvider = StateNotifierProvider.family<
    ChatViewNotifier, ChatViewState, String>((ref, threadId) {
  return ChatViewNotifier(
    threadId,
    ref.read(messageServiceProvider),
    ref.read(apiMessageServiceProvider),
    ref.read(apiUserServiceProvider),
    ref.read(currentUserPod),
  );
});

class ChatViewNotifier extends StateNotifier<ChatViewState> {
  final String threadId;
  final MessageService messageService;
  final ApiMessageService apiMessageService;
  final ApiUserService userService;
  final ApiUser? currentUser;

  bool _hasMoreItems = true;
  bool loadingData = false;

  ChatViewNotifier(this.threadId, this.messageService, this.apiMessageService, this.userService, this.currentUser)
      : super(ChatViewState(message: TextEditingController(), currentUserId: currentUser?.id ?? ''));

  void onChange(String text) {
    state = state.copyWith(allowSend: text.trim().isNotEmpty);
  }

  void setData(SpaceInfo spaceInfo, bool show, ThreadInfo? threadInfo, List<ThreadInfo> threadInfoList) {
    final userList = spaceInfo.members.where(
          (user) => user.user.id != currentUser?.id,
    ).toList();
    state = state.copyWith(
        users: userList,
        spaceInfo: spaceInfo,
        showMemberSelectionView: show,
        threadInfo: threadInfo,
        threadList: threadInfoList,
        threadId: threadInfo?.thread.id ?? ''
    );
  }

  void listenThread(String threadId) async {
    try {
      if (threadId.isEmpty) return;
      state = state.copyWith(loading: state.messages.isEmpty);
      messageService.getLatestMessages(threadId, limit: 20).listen((messages) {
        state = state.copyWith(messages: messages, loading: false);
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

  void markMessageAsSeen(String threadId, List<ApiThreadMessage> message) async {
    try {
      final unReadMessage = message
          .where((message) => !message.seen_by.contains(currentUser?.id ?? ''))
          .map((message) => message.id)
          .toSet()
          .toList();

      if (unReadMessage.isNotEmpty) {
        await messageService.markMessageAsSeen(threadId, unReadMessage, currentUser?.id ?? '');
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

  void getThreadMembers(ApiThread thread) async {
    try {
      if (thread.id.isEmpty) return;
      state = state.copyWith(loading: true);
      messageService.getLatestMessageMember(thread).listen((users) {
        state = state.copyWith(sender: users, loading: false);
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

  void sendMessage(String threadId, String message) async {
    try {
      if (message.isEmpty) return;
      state = state.copyWith(messageSending: true);
      final newMessage = await messageService.generateMessage(threadId: threadId, senderId: currentUser?.id ?? '', message: message);
      final newMessages = [newMessage, ...state.messages];
      state = state.copyWith(messages: newMessages);
      await messageService.sendMessage(newMessage);
      state = state.copyWith(messageSending: false, message: TextEditingController(text: ''), showMemberSelectionView: false);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while sending message',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void createNewThread(String spaceId, String message) async {
    try {
      List<String> selectedMembers = [];
      if (!selectedMembers.contains(currentUser?.id) && state.selectedMember.isNotEmpty) {
        selectedMembers.addAll(state.selectedMember);
        selectedMembers.add(currentUser?.id ?? '');
      }
      List<String>? threadMembersIds = state.selectedMember.isNotEmpty
          ? selectedMembers
          : state.spaceInfo?.members.map((members) => members.user.id).toList();

      final threadId = await messageService.createThread(spaceId, currentUser?.id ?? '', threadMembersIds ?? []);

      if (threadId.isNotEmpty) {
        sendMessage(threadId, message);
        getCreatedThread(threadId);
      }
      state = state.copyWith(showMemberSelectionView: false, threadId: threadId, isNewThread: true);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'ChatViewNotifier: error while create new thread',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void getCreatedThread(String threadId) async {
    try {
      final thread = await messageService.getThread(threadId);
      getThreadMembers(thread!.thread);
      state = state.copyWith(threadInfo: thread);
      formatMemberNames(thread.members);
    } catch (error, stack) {
      logger.e(
        'ChatViewNotifier: error while get threads',
        error: error,
        stackTrace: stack
      );
    }
  }

  void selectExistingThread() {
    final userList = state.users.map((e) => e.user.id).toList();
    final List<String> selectedMembers = List.from(state.selectedMember.isEmpty ? userList : state.selectedMember);
    selectedMembers.add(currentUser?.id ?? '');

    final List<List<String>> threadMembers = state.threadList
        .map((threads) => threads.members.map((e) => e.user.id.toString()).toList())
        .toList();

    bool hasMatchingThread = threadMembers.any((threadMember) => _listsContainSameMembers(selectedMembers, threadMember));
    if (hasMatchingThread) {
      final matchingThreads = state.threadList.where((thread) {
        final List<String> threadMemberIds = thread.members.map((member) => member.user.id.toString()).toList();
        return _listsContainSameMembers(selectedMembers, threadMemberIds);
      }).toList();
      if (matchingThreads.isNotEmpty) {
        ThreadInfo matchedThread = matchingThreads.first;
        listenThread(matchedThread.thread.id);
        getThreadMembers(matchedThread.thread);
        formatMemberNames(matchedThread.members);
        state = state.copyWith(threadId: matchedThread.thread.id, threadInfo: matchedThread);
      }
    } else {
      state = state.copyWith(sender: [], messages: [], isNewThread: true);
    }
  }

  bool _listsContainSameMembers(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    final set1 = Set<String>.from(list1);
    final set2 = Set<String>.from(list2);
    return set1.containsAll(set2) && set2.containsAll(set1);
  }

  void loadMoreMessages(String threadId, bool append) async {
    try {
      if ((loadingData) && threadId.isEmpty) return;
      state = state.copyWith(loadingMessages: state.messages.isEmpty);
      loadingData = true;
      final minMessage = state.messages.reduce((a, b) => a.createdAtMs < b.createdAtMs ? a : b);
      final newMessages = await messageService.getMessages(threadId, minMessage.created_at, limit: MAX_PAGE_LIMIT);
      _hasMoreItems = newMessages.length == MAX_PAGE_LIMIT;
      final allMessages = state.messages;
      final messages = append ? [...allMessages, ...newMessages] : allMessages;
      state = state.copyWith(messages: messages, loadingMessages: false);
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
    loadMoreMessages(state.threadId, true);
  }

  bool isSender(ApiThreadMessage message) {
    return message.sender_id != currentUser?.id;
  }

  void formatMemberNames(List<ApiUserInfo> members) {
    final filteredMembers = members.where((member) => member.user.id != state.currentUserId).toList();
    state = state.copyWith(title: '');
    if (filteredMembers.length > 2) {
      state = state.copyWith(title: '${filteredMembers[0].user.first_name}, ${filteredMembers[1].user.first_name} +${filteredMembers.length - 2}');
    } else if (filteredMembers.length == 2) {
      state = state.copyWith(title: '${filteredMembers[0].user.first_name}, ${filteredMembers[1].user.first_name}');
    } else if (filteredMembers.length == 1) {
      state = state.copyWith(title: filteredMembers[0].user.first_name ?? '');
    } else {
      state = state.copyWith(title: '');
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
    final showDateHeader = nextDate == null || nextDate != extractDate(message.created_at!);
    return showDateHeader;
  }

  bool showTimeHeader(int index, ApiThreadMessage message) {
    final bool isLastMessage = index >= state.messages.length - 1;

    if (isLastMessage) {
      return true;
    }

    final nextMessage = state.messages[index + 1];
    final bool isDifferentTime = message.created_at!.hour != nextMessage.created_at!.hour ||
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
    selectExistingThread();
  }

  void clearSelection() {
    state = state.copyWith(selectedMember: []);
    selectExistingThread();
  }
}

@freezed
class ChatViewState with _$ChatViewState {
  const factory ChatViewState({
    @Default(false) bool loading,
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
    @Default([]) List<ThreadInfo>  threadList,
  }) = _ChatViewState;
}
