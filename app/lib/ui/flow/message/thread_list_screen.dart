import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/message_models.dart';
import 'package:data/api/space/space_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/button/large_icon_button.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/date_formatter.dart';
import 'package:yourspace_flutter/domain/extenstions/widget_extensions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/components/error_snakebar.dart';
import 'package:yourspace_flutter/ui/flow/message/thread_list_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../gen/assets.gen.dart';
import '../../components/alert.dart';

class ThreadListScreen extends ConsumerStatefulWidget {
  final SpaceInfo spaceInfo;

  const ThreadListScreen({
    super.key,
    required this.spaceInfo,
  });

  @override
  ConsumerState createState() => _ThreadListScreenState();
}

class _ThreadListScreenState extends ConsumerState<ThreadListScreen> {
  late ThreadListViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    runPostFrame(() {
      notifier.setSpace(widget.spaceInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(threadListViewStateProvider(widget.spaceInfo.space.id).notifier);
    final state = ref.watch(threadListViewStateProvider(widget.spaceInfo.space.id));
    _observeInviteScreenNavigation();
    _observeError();

    return AppPage(
      title: widget.spaceInfo.space.name,
      body: _body(context, state),
      floatingActionButton: widget.spaceInfo.members.length >= 2
      ? LargeIconButton(
        onTap: () {
          AppRoute.chat(spaceId: widget.spaceInfo.space.id, spaceName: widget.spaceInfo.space.name, threadInfoList: state.threadInfo).push(context);
        },
        icon: Icon(
          Icons.add_rounded,
          color: context.colorScheme.onPrimary,
        ),
      )
      : null
    );
  }

  Widget _body(BuildContext context, ThreadListViewState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: state.threadInfo.isEmpty
          ? _emptyView(context, state)
          : _threadList(context, state.threadInfo, state.threadMessages),
    );
  }

  Widget _threadList(BuildContext context, List<ThreadInfo> threads, List<List<ApiThreadMessage>> threadMessages) {
    List<ThreadInfo> mutableThreads = List.from(threads);

    return ListView.builder(
      itemCount: mutableThreads.length,
      itemBuilder: (context, index) {
        final thread = mutableThreads[index];
        final members = thread.members.where((member) => member.user.id != notifier.currentUser?.id).toList();
        final filteredMessages = index < threadMessages.length ? threadMessages[index] : [];
        final hasUnreadMessage = filteredMessages
            .any((message) => !message.seen_by.contains(notifier.currentUser?.id));

        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              _deleteSlideButton(context, thread.thread),
            ],
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AppRoute.chat(spaceId: widget.spaceInfo.space.id, threadId: thread.thread.id, threadMessage: threadMessages[index]).push(context);
            },
            child: Column(
              children: [
                _threadItem(
                  context: context,
                  members: members,
                  displayedMembers: members.take(2).toList(),
                  message: filteredMessages.isNotEmpty ? filteredMessages.first.message : '',
                  date: filteredMessages.isNotEmpty ? filteredMessages.first.created_at : DateTime.now(),
                  hasUnreadMessage: hasUnreadMessage,
                ),
                if (!(index == mutableThreads.length - 1)) ...[
                  _divider(context),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _deleteSlideButton(BuildContext context, ApiThread thread) {
    return SlidableAction(
      onPressed: (context) {
        _showDeleteConfirmation(() {
          notifier.deleteThread(thread);
        });
      },
      backgroundColor: context.colorScheme.alert,
      foregroundColor: context.colorScheme.textPrimaryDark,
      icon: Icons.delete_outline_rounded,
      label: context.l10n.common_delete,
    );
  }

  Widget _threadItem({
    required BuildContext context,
    required List<ApiUserInfo> members,
    required List<ApiUserInfo> displayedMembers,
    required String message,
    required DateTime date,
    required bool hasUnreadMessage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _threadProfile(context, members),
          const SizedBox(width: 16),
          Expanded(child: _threadNamesAndMessage(context: context, members: members, displayedMembers: displayedMembers, message: message)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.format(context, DateFormatType.pastTime),
                style: AppTextStyle.caption.copyWith(
                  color: context.colorScheme.textDisabled,
                ),
              ),
              SizedBox(height: hasUnreadMessage ? 12 : 0),
              Visibility(
                visible: hasUnreadMessage,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: context.colorScheme.positive,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: context.colorScheme.outline,
      ),
    );
  }

  Widget _threadNamesAndMessage({
    required BuildContext context,
    required List<ApiUserInfo> members,
    required List<ApiUserInfo> displayedMembers,
    required String message,
  }) {
    final remainingCount = members.length - displayedMembers.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < displayedMembers.length; i++)
              Row(
                children: [
                  Text(
                    displayedMembers[i].user.first_name ?? '',
                    style: AppTextStyle.subtitle2.copyWith(
                      color: context.colorScheme.textPrimary,
                    ),
                  ),
                  if (i != displayedMembers.length - 1)
                    Text(', ', style: AppTextStyle.subtitle2.copyWith(color: context.colorScheme.textPrimary)),
                ],
              ),
            if (remainingCount > 0)
              Text(
                context.l10n.message_member_count_text(remainingCount),
                style: AppTextStyle.subtitle2.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
          ],
        ),
        Text(
          message,
          style: AppTextStyle.caption.copyWith(
            color: context.colorScheme.textDisabled,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget _threadProfile(BuildContext context, List<ApiUserInfo> members) {
    if (members.length == 1) {
      return _profileImageView(context, members[0], size: 50);
    } else {
      return SizedBox(
        width: 56,
        height: 40,
        child: Stack(
          children: [
            for (var i = 0; i < (members.length > 2 ? 2 : members.length); i++)
              Positioned(
                left: i * 16.0,
                child: _profileImageView(
                    context,
                    members[i],
                    size: 40,
                    isMoreMember: members.length > 2 && i == 1,
                    count: members.length - 1),
              ),
          ],
        ),
      );
    }
  }

  Widget _profileImageView(BuildContext context, ApiUserInfo member,
      {required double size, bool isMoreMember = false, int count = 0}) {
    final profileImageUrl = member.user.profile_image ?? '';
    final firstLetter = member.user.firstChar;

    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: isMoreMember
            ? Container(
                color: context.colorScheme.primary,
                child: Center(
                  child: Text(count > 0 ? context.l10n.message_member_count_text(count) : '',
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimaryDark)),
                ),
              )
            : profileImageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: profileImageUrl,
                    placeholder: (context, url) => ClipRRect(
                      borderRadius: BorderRadius.circular(size / 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.containerLowOnSurface,
                          borderRadius: BorderRadius.circular(size / 2),
                        ),
                          child: Icon(Icons.perm_identity_rounded, color: context.colorScheme.textPrimaryDark)),
                    ),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: context.colorScheme.primary,
                    child: Center(
                      child: Text(firstLetter,
                          style: AppTextStyle.subtitle2.copyWith(
                              color: context.colorScheme.textPrimaryDark)),
                    ),
                  ),
      ),
    );
  }

  Widget _emptyView(BuildContext context, ThreadListViewState state) {
    if (widget.spaceInfo.members.length >= 2) {
      return _emptyMessageView(context);
    } else {
      return _emptyMessageViewWith0Member(context, state);
    }
  }

  Widget _emptyMessageView(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.message_tap_to_send_new_message_text,
        style: AppTextStyle.subtitle1.copyWith(
          color: context.colorScheme.textPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emptyMessageViewWith0Member(BuildContext context, ThreadListViewState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.icSendMessage,
            colorFilter: ColorFilter.mode(
              context.colorScheme.textPrimary,
              BlendMode.srcATop,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            context.l10n.message_add_member_to_send_message_title,
            style: AppTextStyle.header3.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.message_add_member_to_send_message_subtitle,
            style: AppTextStyle.subtitle1.copyWith(
              color: context.colorScheme.textDisabled,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            context.l10n.message_add_new_member_title,
            progress: state.fetchingInviteCode,
            onPressed: () => notifier.onAddNewMemberTap(),
          ),
        ],
      ),
    );
  }

  void _observeInviteScreenNavigation() {
    ref.listen(threadListViewStateProvider(widget.spaceInfo.space.id).select((state) => state.spaceInvitationCode), (previous, next) {
      if (next.isNotEmpty) {
        AppRoute.inviteCode(code: next, spaceName: widget.spaceInfo.space.name).push(context);
      }
    });
  }

  void _observeError() {
    ref.listen(threadListViewStateProvider(widget.spaceInfo.space.id).select((state) => state.error), (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }

  void _showDeleteConfirmation(Function() onConfirm) {
    showConfirmation(
        context,
        confirmBtnText: context.l10n.common_delete,
        title: context.l10n.message_delete_thread_title,
        message: context.l10n.message_delete_thread_subtitle,
        onConfirm: () => onConfirm(),
    );
  }
}
