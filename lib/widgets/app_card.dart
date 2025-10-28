import 'package:car_dashboard/theme.dart';
import 'package:flutter/material.dart';

/// A small wrapper that applies the project's card look (rounded corners,
/// subtle gradient, inner padding and glow). Use instead of ad-hoc Containers.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 16.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extras = appExtras(context);

    // Slightly stronger border and multi-layered shadow to create the
    // soft neon outline visible in the design sample.
    final decoration = BoxDecoration(
      gradient: extras.cardGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: extras.accentColor.withOpacity(0.18),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: extras.glowColor.withOpacity(0.18),
          blurRadius: 24,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );

    final content = Container(
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }
}
