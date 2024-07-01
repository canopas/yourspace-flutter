import 'package:flutter/cupertino.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';

class ImageAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final String initials;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ImageAvatar({
    super.key,
    this.imageUrl,
    this.size = 48,
    this.initials = '',
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final image = imageUrl ?? '';
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.primary,
        borderRadius: BorderRadius.circular(size),
      ),
      child: image.isEmpty
          ? Center(
              child: Text(
                initials,
                style: AppTextStyle.header2.copyWith(
                  fontSize: size * 0.4,
                  color: foregroundColor ?? context.colorScheme.onPrimary,
                ),
              ),
            )
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
    );
  }
}
