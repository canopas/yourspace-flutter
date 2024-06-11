import 'package:flutter/material.dart';
import 'package:style/extenstions/context_extenstions.dart';

import 'app_text_dart.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final bool expands;
  final bool enabled;
  final double? borderRadius;
  final AppTextFieldBorderType borderType;
  final double borderWidth;
  final TextInputAction? textInputAction;
  final String? hintText;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isCollapsed;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final Function(PointerDownEvent)? onTapOutside;

  const AppTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.style,
    this.expands = false,
    this.enabled = true,
    this.onChanged,
    this.borderType = AppTextFieldBorderType.underline,
    this.borderWidth = 1,
    this.textInputAction,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.isDense,
    this.isCollapsed,
    this.autoFocus = false,
    this.keyboardType,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return _textField(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: labelStyle ??
              AppTextStyle.body2.copyWith(
                color: context.colorScheme.textDisabled,
              ),
        ),
        if (borderType == AppTextFieldBorderType.outline)
          const SizedBox(height: 12),
        _textField(context),
      ],
    );
  }

  Widget _textField(BuildContext context) => Material(
    color: Colors.transparent,
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textAlign: textAlign,
      style: style ??
          AppTextStyle.subtitle2.copyWith(
            color: context.colorScheme.textPrimary,
          ),
      onTapOutside: onTapOutside ??
              (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
      decoration: InputDecoration(
        isDense: isDense,
        isCollapsed: isCollapsed,
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: _border(context, true, borderRadius ?? 8),
        enabledBorder: _border(context, false, borderRadius ?? 8),
        contentPadding: contentPadding ??
            (borderType == AppTextFieldBorderType.outline
                ? const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            )
                : null),
      ),
    ),
  );

  InputBorder _border(BuildContext context, bool focused, double borderRadius) {
    switch (borderType) {
      case AppTextFieldBorderType.none:
        return const UnderlineInputBorder(
          borderSide: BorderSide.none,
        );
      case AppTextFieldBorderType.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focused
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            width: borderWidth,
          ),
        );
      case AppTextFieldBorderType.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: focused
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            width: borderWidth,
          ),
        );
    }
  }
}

enum AppTextFieldBorderType {
  none,
  outline,
  underline,
}
