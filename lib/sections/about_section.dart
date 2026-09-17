import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/experiences.dart';
import '../data/period.dart';
import '../data/profile.dart';
import '../widgets/dusk_card.dart';
import '../widgets/section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final about = DuskCard(
      padding: EdgeInsets.all(compact ? 22 : 32),
      child: Text(
        Profile.about,
        style: DuskType.body(
          size: compact ? 16.5 : 18.5,
          color: Dusk.cream,
          height: 1.75,
        ),
      ),
    );

    return SectionFrame(
      top: compact ? 40 : 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            kicker: 'puxa uma cadeira e senta aí',
            title: 'Sobre mim',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 860) {
                return Column(
                  children: [
                    about,
                    const SizedBox(height: 20),
                    const _FactsCard(),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: about),
                  const SizedBox(width: 24),
                  const Expanded(flex: 5, child: _FactsCard()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FactsCard extends StatelessWidget {
  const _FactsCard();

  @override
  Widget build(BuildContext context) {
    final start = careerStart;
    final years = monthsInclusive(start, DateTime.now()) ~/ 12;
    final facts = [
      (
        Icons.school_outlined,
        'Formação',
        '${Formacao.curso} · UNIFESSPA · ${Formacao.conclusao}',
      ),
      (
        Icons.work_outline_rounded,
        'Hoje',
        currentCompanies.map((company) => company.shortName).join(' e '),
      ),
      (
        Icons.route_outlined,
        'Na estrada desde',
        '${start.year} · $years anos escrevendo software',
      ),
      (
        Icons.translate_rounded,
        'Idiomas',
        idiomas
            .map((i) => '${i.idioma} (${i.nivel.toLowerCase()})')
            .join(' · '),
      ),
    ];

    return DuskCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('De relance', style: DuskType.heading(size: 24)),
          const SizedBox(height: 18),
          for (final (icon, label, value) in facts)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Dusk.amber.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Dusk.amber, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label.toUpperCase(),
                          style: DuskType.body(
                            size: 11.5,
                            weight: FontWeight.w800,
                            color: Dusk.muted,
                            letterSpacing: 1.2,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          value,
                          style: DuskType.body(
                            size: 15.5,
                            weight: FontWeight.w600,
                            color: Dusk.cream,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
