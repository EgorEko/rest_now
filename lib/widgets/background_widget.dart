import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    required this.child,
    this.borderRadius,
    this.opacity = 1.0,
    super.key,
    this.gradient,
  });

  final Widget child;
  final Gradient? gradient;
  final double opacity;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: gradient,
      ),
      child: child,
    );
  }
}
