import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/message_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/icon_primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:style/text/app_text_field.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/date_formatter.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/components/error_snakebar.dart';
import 'package:yourspace_flutter/ui/components/profile_picture.dart';
import 'package:yourspace_flutter/ui/flow/message/chat/chat_view_model.dart';

import '../../../../domain/extenstions/widget_extensions.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String? spaceId;
  final String? spaceName;
  final String? threadId;
  final List<ApiThreadMessage>? threadMessages;
  final List<ThreadInfo>? threadInfoList;

  const ChatScreen({
    super.key,
    this.spaceId,
    this.spaceName,
    this.threadMessages,
    this.threadId,
    this.threadInfoList,
  });

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late ChatViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    runPostFrame(() {
      notifier.setData(
          spaceId: widget.spaceId ?? '',
          threadId: widget.threadId ?? '',
          show: widget.threadId == null,
          threadInfoList: widget.threadInfoList ?? [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(chatViewStateProvider(widget.threadId ?? '').notifier);
    final state = ref.watch(chatViewStateProvider(widget.threadId ?? ''));
    _observeError();

    if (widget.threadId != null) {
      notifier.markMessageAsSeen(widget.threadId ?? '', widget.threadMessages ??  state.messages);
    }

    return AppPage(
      title: state.threadInfo == null && widget.threadId == null ? context.l10n.chat_start_new_chat_title : state.title,
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, ChatViewState state) {
    if ((widget.threadId != null) && state.sender.isEmpty) {
      return const Center(child: AppProgressIndicator());
    }
    return Column(
      children: [
        if (state.showMemberSelectionView) _memberSelectionView(context, state),
        Expanded(
            child: _chatList(context, state.messages, state.sender,
                state.loadingMessages, state.threadId, state.currentUserId, state.threadInfo)),
        const SizedBox(height: 24),
        _textField(context, state),
      ],
    );
  }

  Widget _chatList(
      BuildContext context,
      List<ApiThreadMessage> messages,
      List<ApiUserInfo>? sender,
      bool loadingMessage,
      String threadId,
      String currentUserId,
      ThreadInfo? threadInfo
      ) {
    if (sender == null && sender!.isEmpty) {
      return const AppProgressIndicator();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (loadingMessage && index == messages.length - 1) {
          return const AppProgressIndicator(size: AppProgressIndicatorSize.small);
        }
        if (index == messages.length - 1) {
          runPostFrame(() => notifier.onLoadMore(widget.threadId == null ? threadId : widget.threadId ?? ''));
        }

        final message = messages[index];
        final showDateHeader = notifier.showDateHeader(index, message);
        final bool isDifferentSender = index < messages.length - 1 &&
            messages[index + 1].sender_id != message.sender_id;
        final senderInfo = sender.isNotEmpty && sender.length > 2
            ? sender.firstWhere((member) => member.user.id == message.sender_id).user
            : null;

        final seenBy = threadInfo?.members.where((member) =>
        message.seen_by.contains(member.user.id) &&
            member.user.id != currentUserId)
            .toList();

        final showSeenText = notifier.isSender(message) && (seenBy?.isNotEmpty ?? false) && message.id == messages.first.id
            ? true
            : false;

        if (messages.isEmpty) {
          return const AppProgressIndicator();
        }

        return Column(
          crossAxisAlignment: notifier.isSender(message)
              ? showSeenText ? CrossAxisAlignment.end : CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            if (showDateHeader)
              _dateHeader(message.created_at!
                  .format(context, DateFormatType.relativeDate)),
            _chatItem(
              context: context,
              message: message,
              sender: senderInfo,
              isSender: notifier.isSender(message),
              showTimeHeader: notifier.showTimeHeader(index, message),
              isFirstInGroup: notifier.isFirstInGroupAtIndex(index),
              isLastInGroup: notifier.isLastInGroupAtIndex(index),
              memberCount: sender.length,
              isDifferentSender: isDifferentSender,
            ),
            if (showSeenText) ...[
              const SizedBox(height: 4),
              Text(
                sender.length > 2
                    ? context.l10n.chat_seen_by_message_text(seenBy!.map((e) => e.user.first_name).join(', '))
                    : context.l10n.chat_seen_message_text,
                style: AppTextStyle.caption.copyWith(
                  color: context.colorScheme.textDisabled,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _chatItem({
    required BuildContext context,
    required ApiThreadMessage message,
    required ApiUser? sender,
    required bool isSender,
    required bool showTimeHeader,
    required bool isFirstInGroup,
    required bool isLastInGroup,
    required int memberCount,
    required bool isDifferentSender,
  }) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (showTimeHeader) ...[
          _timeHeader(message.created_at ?? DateTime.now(), isSender, memberCount)
        ],
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isSender && (isDifferentSender || showTimeHeader) && memberCount > 2) ...[
              ProfileImage(
                  profileImageUrl: sender?.profile_image ?? '',
                  firstLetter: sender!.firstChar,
                  size: 24,
                style: AppTextStyle.caption.copyWith(
                  color: context.colorScheme.textPrimaryDark,
                ),
                backgroundColor: context.colorScheme.primary,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                margin: EdgeInsets.only(
                    left: isSender
                        ? isLastInGroup
                            ? 0
                            : showTimeHeader
                                ? 0
                                : memberCount > 2
                                    ? 32
                                    : 0
                        : 46,
                    right: isSender ? 48 : 0),
                decoration: BoxDecoration(
                  color: isSender
                      ? context.colorScheme.containerLowOnSurface
                      : context.colorScheme.primary,
                  borderRadius: _radius(
                    isSender: isSender,
                    isLastInGroup: isLastInGroup,
                    isFirstInGroup: isFirstInGroup,
                    isDifferentSender: isDifferentSender,
                  ),
                ),
                child: _chatBubbleView(
                  context: context,
                  isSender: isSender,
                  sender: sender,
                  message: message.message,
                  memberCount: memberCount,
                  isDifferentSender: isDifferentSender || showTimeHeader,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chatBubbleView({
    required BuildContext context,
    required bool isSender,
    required ApiUser? sender,
    required String message,
    required int memberCount,
    required bool isDifferentSender,
  }) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isSender && memberCount > 2 && isDifferentSender) ...[
            Text(
              sender?.first_name ?? '',
              style: AppTextStyle.caption.copyWith(
                color: context.colorScheme.positive,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            message,
            style: AppTextStyle.subtitle3.copyWith(
              color: isSender ? context.colorScheme.textPrimary : context.colorScheme.textPrimaryDark,
            ),
            maxLines: null,
            textAlign: isSender ? TextAlign.start : TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _dateHeader(String date) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 24),
        child: Text(
          date,
          style: AppTextStyle.body1.copyWith(
            color: context.colorScheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _timeHeader(DateTime time, bool isSender, int memberCount) {
    return Padding(
      padding: EdgeInsets.only(
          left: isSender
              ? memberCount > 2
                  ? 32
                  : 0
              : 0,
          top: 24),
      child: Text(
        time.format(context, DateFormatType.time),
        style: AppTextStyle.caption.copyWith(
          color: context.colorScheme.textDisabled,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _memberSelectionView(BuildContext context, ChatViewState state) {
    return Container(
      height: 114,
      decoration:
          BoxDecoration(color: context.colorScheme.containerLowOnSurface),
      child: Row(
        children: [
          const SizedBox(width: 16),
          _allItem(context, state),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.users.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final member = state.users[index];
                final isSelected = state.selectedMember.contains(member.user.id);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      notifier.toggleMemberSelection(member.user.id);
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                    child: Column(
                      children: [
                        if (isSelected) ...[
                          _selectedView(context),
                        ] else ...[
                          _profileImageView(context, member.user),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          member.user.first_name ?? '',
                          style: AppTextStyle.caption
                              .copyWith(color: context.colorScheme.textPrimary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _allItem(BuildContext context, ChatViewState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SizedBox(
        width: 56,
        child: GestureDetector(
          onTap: () {
            setState(() {
              notifier.clearSelection();
            });
          },
          child: Column(
            children: [
              if (state.selectedMember.isEmpty) ...[
                _selectedView(context),
              ] else ...[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.l10n.common_all,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.primary),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  widget.spaceName ?? '',
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedView(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.colorScheme.positive,
      ),
      child: Icon(
        Icons.check_circle_rounded,
        color: context.colorScheme.textPrimaryDark,
      ),
    );
  }

  Widget _profileImageView(BuildContext context, ApiUser user) {
    final profileImageUrl = user.profile_image ?? '';
    final firstLetter = user.firstChar;

    return SizedBox(
      width: 40,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: profileImageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: profileImageUrl,
                placeholder: (context, url) => const AppProgressIndicator(
                    size: AppProgressIndicatorSize.small),
                fit: BoxFit.cover,
              )
            : Container(
                color: context.colorScheme.primary,
                child: Center(
                  child: Text(firstLetter,
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textPrimaryDark)),
                ),
              ),
      ),
    );
  }

  Widget _textField(BuildContext context, ChatViewState state) {
    return BottomStickyOverlay(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.containerLowOnSurface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: AppTextField(
                controller: state.message,
                onChanged: (value) {
                  notifier.onChange(value);
                },
                maxLines: 6,
                minLines: 1,
                style: AppTextStyle.body2.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
                borderType: AppTextFieldBorderType.none,
                borderRadius: 24,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: context.l10n.chat_type_message_hint_text,
                hintStyle: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconPrimaryButton(
            onTap: () {
              if (state.message.text.trim().isNotEmpty) {
                if (state.threadInfo != null || widget.threadId != null) {
                  notifier.sendMessage(
                      state.threadId.isEmpty
                          ? widget.threadId ?? ''
                          : state.threadId,
                      state.message.text);
                } else {
                  notifier.createNewThread(state.message.text);
                }
              }
            },
            icon: Icon(Icons.arrow_forward_rounded,
                color: state.allowSend && state.message.text.isNotEmpty
                    ? context.colorScheme.textPrimaryDark
                    : context.colorScheme.textDisabled),
            enabled: state.allowSend,
            radius: 23,
            size: 46,
            bgColor: state.allowSend && state.message.text.isNotEmpty
                ? context.colorScheme.primary
                : context.colorScheme.containerLowOnSurface,
          )
        ],
      ),
    );
  }

  BorderRadius _radius({
    required bool isSender,
    required bool isLastInGroup,
    required bool isFirstInGroup,
    required bool isDifferentSender,
  }) {
    if (isDifferentSender && !isLastInGroup) {
      return BorderRadius.circular(16);
    }

    return BorderRadius.only(
      topLeft: isSender && isLastInGroup
          ? const Radius.circular(16)
          : isSender
              ? Radius.zero
              : const Radius.circular(16),
      bottomLeft: isSender && isFirstInGroup
          ? const Radius.circular(16)
          : isSender
              ? Radius.zero
              : const Radius.circular(16),
      topRight: !isSender && isLastInGroup
          ? const Radius.circular(16)
          : isSender
              ? const Radius.circular(16)
              : Radius.zero,
      bottomRight: !isSender && isFirstInGroup
          ? const Radius.circular(16)
          : isSender
              ? const Radius.circular(16)
              : Radius.zero,
    );
  }

  void _observeError() {
    ref.listen(chatViewStateProvider(widget.threadId ?? '').select((state) => state.error), (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }
}
