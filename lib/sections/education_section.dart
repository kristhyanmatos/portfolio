import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/profile.dart';
import '../widgets/dusk_card.dart';
import '../widgets/section.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final logo = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Dusk.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset(Formacao.logo, height: compact ? 48 : 60),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${Formacao.grau} · concluído em ${Formacao.conclusao}'.toUpperCase(),
          style: DuskType.body(
            size: 12.5,
            weight: FontWeight.w800,
            color: Dusk.amber,
            letterSpacing: 1.3,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(Formacao.curso, style: DuskType.heading(size: compact ? 26 : 32)),
        const SizedBox(height: 8),
        Text(Formacao.instituicao, style: DuskType.body(size: 16.5)),
      ],
    );

    return SectionFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            kicker: 'onde aprendi os primeiros acordes',
            title: 'Formação',
          ),
          DuskCard(
            padding: EdgeInsets.all(compact ? 22 : 32),
            child: compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [logo, const SizedBox(height: 20), details],
                  )
                : Row(
                    children: [
                      logo,
                      const SizedBox(width: 32),
                      Expanded(child: details),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
