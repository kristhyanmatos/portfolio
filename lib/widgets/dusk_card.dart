import 'package:flutter/material.dart';

import '../core/theme.dart';

/// Painel translúcido que deixa o entardecer aparecer por trás.
class DuskCard extends StatelessWidget {
  const DuskCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.highlight = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool highlight;

  static const radius = 22.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xE6271A30), Color(0xE0150E1A)],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: highlight ? Dusk.amber.withValues(alpha: 0.45) : Dusk.line,
        ),
        boxShadow: [
          BoxShadow(
            color: highlight
                ? Dusk.amber.withValues(alpha: 0.12)
                : const Color(0x59000000),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      padding: padding,
      child: child,
    );
  }
}
