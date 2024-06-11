import 'package:data/api/auth/auth_models.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:data/service/message_service.dart';
import 'package:data/api/message/message_models.dart';

part 'chat_view_model.freezed.dart';

final chatViewStateProvider =
    StateNotifierProvider.autoDispose<ChatViewNotifier, ChatViewState>(
  (ref) => ChatViewNotifier(
    ref.read(messageServiceProvider),
    ref.read(currentUserPod),
  ),
);

class ChatViewNotifier extends StateNotifier<ChatViewState> {
  final MessageService messageService;
  final ApiUser? currentUser;
  final Set<String> selectedUsers = {};

  ChatViewNotifier(this.messageService, this.currentUser)
      : super(ChatViewState(message: TextEditingController()));

  void onChange(String text) {
    state = state.copyWith(allowSend: text.trim().isNotEmpty);
  }

  void setData(List<ApiUserInfo> users) {
    final userList = users.where(
          (user) => user.user.id != currentUser?.id,
    ).toList();
    state = state.copyWith(users: userList);
  }
}

@freezed
class ChatViewState with _$ChatViewState {
  const factory ChatViewState({
    @Default(false) bool loading,
    @Default(false) bool allowSend,
    @Default([]) List<ApiUserInfo> users,
    required TextEditingController message,
    @Default([]) List<ThreadInfo> threadInfo,
    Object? error,
  }) = _ChatViewState;
}
