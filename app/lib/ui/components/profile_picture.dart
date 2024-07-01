import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';

class ProfileImage extends StatefulWidget {
  final double size;
  final String profileImageUrl;
  final String firstLetter;
  final TextStyle? style;
  final Color? backgroundColor;

  const ProfileImage({
    super.key,
    this.size = 64,
    required this.profileImageUrl,
    required this.firstLetter,
    this.style,
    this.backgroundColor,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: widget.profileImageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: widget.profileImageUrl,
                placeholder: (context, url) => const AppProgressIndicator(
                    size: AppProgressIndicatorSize.small),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
            : Container(
                color: widget.backgroundColor ?? context.colorScheme.containerInverseHigh,
                child: Center(
                  child: Text(
                      widget.firstLetter,
                      style: widget.style ?? AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary)),
                ),
              ),
      ),
    );
  }
}
