import 'package:flutter/material.dart';

import '../core/theme.dart';

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.accent = false});

  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: accent
            ? Dusk.amber.withValues(alpha: 0.14)
            : Dusk.cream.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: accent
              ? Dusk.amber.withValues(alpha: 0.35)
              : Dusk.cream.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: DuskType.body(
          size: 13.5,
          weight: FontWeight.w600,
          color: accent ? Dusk.gold : Dusk.sand,
          height: 1.3,
        ),
      ),
    );
  }
}
