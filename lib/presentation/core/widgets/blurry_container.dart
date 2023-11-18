import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class BlurryContainer extends StatelessWidget {
  /// The [child] will be shown over blurry container.
  final Widget child;

  /// [height] of blurry container.
  final double? height;

  /// [width] of blurry container.
  final double? width;

  /// The [blur] will control the amount of [sigmaX] and [sigmaY].
  ///
  /// Defaults to `5`.
  final double blur;

  /// [padding] adds the [EdgeInsetsGeometry] to given [child].
  ///
  /// Defaults to `const EdgeInsets.all(8)`.
  final EdgeInsetsGeometry padding;

  /// Background color of container.
  ///
  /// Defaults to `Colors.transparent`.
  ///
  /// The [color] you define will be shown at `0.5` opacity.
  final Color color;

  /// [borderRadius] of blurry container.
  final BorderRadius borderRadius;

  const BlurryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.blur = 20,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          color: color,
          child: child,
        ),
      ),
    );
  }
}
