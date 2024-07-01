import 'package:flutter/material.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final String subTitle1;
  final String? subTitle2;
  final String? dismissBtn;
  final String? confirmBtn;
  final VoidCallback onDismiss;
  final VoidCallback goToSettings;

  const PermissionDialog({
    super.key,
    required this.title,
    required this.subTitle1,
    this.subTitle2,
    this.dismissBtn,
    this.confirmBtn,
    required this.onDismiss,
    required this.goToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.header3,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subTitle1,
            textAlign: TextAlign.center,
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textDisabled),
          ),
          if (subTitle2 != null) ...[
            const SizedBox(height: 24),
            Text(
              subTitle2!,
              textAlign: TextAlign.center,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textDisabled),
            ),
          ],
        ],
      ),
      actions: [
        PrimaryButton(confirmBtn ?? context.l10n.common_go_to_setting,
            onPressed: goToSettings),
        if (dismissBtn != null) ...[
          const SizedBox(height: 16),
          OutlinedPrimaryButton(
            dismissBtn!,
            onPressed: onDismiss,
            foreground: context.colorScheme.primary,
          ),
        ],
      ],
    );
  }
}
