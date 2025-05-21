import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({super.key, this.padding = const EdgeInsets.all(16), this.borderRadius = 16, required this.child});

  final EdgeInsets padding;
  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      elevation: 1,
      child: Padding(padding: padding, child: child),
    );
  }
}
