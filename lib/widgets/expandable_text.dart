import 'package:flutter/material.dart';

import '../core/theme.dart';

/// Texto que mostra [trimLines] linhas e um "Ler mais" quando não cabe.
class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    super.key,
    required this.style,
    this.trimLines = 4,
  });

  final String text;
  final TextStyle style;
  final int trimLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.trimLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;
        painter.dispose();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                style: widget.style,
                maxLines: _expanded ? null : widget.trimLines,
                overflow: _expanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
            ),
            if (overflows)
              TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(
                  foregroundColor: Dusk.amber,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  _expanded ? 'Ler menos' : 'Ler mais',
                  style: DuskType.body(
                    size: 14.5,
                    weight: FontWeight.w700,
                    color: Dusk.amber,
                    height: 1.2,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
