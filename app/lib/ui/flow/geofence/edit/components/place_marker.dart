import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/extenstions/context_extenstions.dart';

import '../../../../../gen/assets.gen.dart';

class PlaceMarker extends StatefulWidget {
  final double radius;

  const PlaceMarker({super.key, required this.radius});

  @override
  State<PlaceMarker> createState() => _PlaceMarkerState();
}

class _PlaceMarkerState extends State<PlaceMarker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRect(
          child: OverflowBox(
            maxHeight: widget.radius,
            maxWidth: widget.radius,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: widget.radius,
              height: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: context.colorScheme.primary.withOpacity(0.5),
              ),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: context.colorScheme.onPrimary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              Assets.images.icLocationFeedIcon,
              colorFilter: ColorFilter.mode(
                context.colorScheme.primary,
                BlendMode.srcATop,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
