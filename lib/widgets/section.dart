import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';

const contentMaxWidth = 1120.0;

/// Centraliza o conteúdo de uma seção com largura máxima.
class SectionFrame extends StatelessWidget {
  const SectionFrame({
    super.key,
    required this.child,
    this.top = 120,
    this.bottom = 0,
  });

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final side = context.isCompact ? 16.0 : 32.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(side, top, side, bottom),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: contentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.kicker,
    required this.title,
    this.description,
  });

  final String kicker;
  final String title;
  final String? description;

  static const _shadow = [Shadow(color: Color(0xAA0D0812), blurRadius: 18)];

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.music_note_rounded, color: Dusk.gold, size: 22),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  kicker,
                  style: DuskType.terminal(size: compact ? 24 : 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: DuskType.heading(size: compact ? 36 : 48, shadows: _shadow),
          ),
          if (description case final description?) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                description,
                style: DuskType.body(
                  size: compact ? 16 : 17.5,
                  shadows: _shadow,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
