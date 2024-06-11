import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/message_models.dart';
import 'package:data/api/space/space_models.dart';
import 'package:data/log/logger.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:data/service/space_service.dart';
import 'package:data/service/message_service.dart';

part 'thread_list_view_model.freezed.dart';

final threadListViewStateProvider = StateNotifierProvider.autoDispose<
    ThreadListViewNotifier, ThreadListViewState>(
      (ref) => ThreadListViewNotifier(
        ref.read(spaceServiceProvider),
        ref.read(messageServiceProvider),
        ref.read(currentUserPod),
  ),
);

class ThreadListViewNotifier extends StateNotifier<ThreadListViewState> {
  final SpaceService spaceService;
  final MessageService messageService;
  final ApiUser? currentUser;

  ThreadListViewNotifier(this.spaceService, this.messageService, this.currentUser) : super(const ThreadListViewState());

  void setSpace(SpaceInfo space) {
    state = state.copyWith(space: space);
    listenThreads(space.space.id);
  }

  void listenThreads(String spaceId) async {
    try {
      state = state.copyWith(loading: state.threadInfo.isEmpty);
      messageService.getThreadsWithLatestMessage(spaceId, currentUser!.id).listen((thread) {
        state = state.copyWith(threadInfo: thread, loading: false);
      });
    } catch (error, stack) {
      logger.e(
        'ChatViewNotifier: error while listing message thread',
        error: error,
        stackTrace: stack,
      );
      state = state.copyWith(error: error, loading: false);
    }
  }

  void onAddNewMemberTap() async {
    try {
      state = state.copyWith(fetchingInviteCode: true);
      final code = await spaceService.getInviteCode(state.space?.space.id ?? '');
      state = state.copyWith(spaceInvitationCode: code ?? '', fetchingInviteCode: false);
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        'MessageViewNotifier: Error while getting invitation code',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void deleteThread(ApiThread thread) async {
    try {
      await messageService.deleteThread(thread, currentUser?.id ?? '');
      listenThreads(state.space?.space.id ?? '');
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        'MessageViewNotifier: Error while delete thread',
        error: error,
        stackTrace: stack,
      );
    }
  }
}

@freezed
class ThreadListViewState with _$ThreadListViewState {
  const factory ThreadListViewState({
    @Default(false) bool allowSave,
    @Default(false) bool isCreating,
    @Default(false) bool loading,
    @Default(false) bool fetchingInviteCode,
    SpaceInfo? space,
    @Default('') String spaceInvitationCode,
    @Default('') String message,
    @Default([]) List<SpaceInfo> spaceList,
    @Default([]) List<ThreadInfo> threadInfo,
    Object? error,
  }) = _ThreadListViewState;
}
