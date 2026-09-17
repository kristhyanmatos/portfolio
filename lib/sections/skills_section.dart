import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/profile.dart';
import '../widgets/dusk_card.dart';
import '../widgets/section.dart';
import '../widgets/tag_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const soft = _ChipsCard(
      icon: Icons.groups_2_outlined,
      title: 'Competências',
      items: competencias,
    );
    const tools = _ChipsCard(
      icon: Icons.construction_rounded,
      title: 'Ferramentas',
      items: ferramentas,
      accent: true,
    );
    const languages = _LanguagesCard();

    return SectionFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            kicker: 'os acordes que eu sei tocar',
            title: 'Habilidades',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 860) {
                return const Column(
                  children: [
                    tools,
                    SizedBox(height: 20),
                    soft,
                    SizedBox(height: 20),
                    languages,
                  ],
                );
              }
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [soft, SizedBox(height: 24), languages],
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(flex: 7, child: tools),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(icon, color: Dusk.amber, size: 24),
          const SizedBox(width: 10),
          Flexible(child: Text(title, style: DuskType.heading(size: 24))),
        ],
      ),
    );
  }
}

class _ChipsCard extends StatelessWidget {
  const _ChipsCard({
    required this.icon,
    required this.title,
    required this.items,
    this.accent = false,
  });

  final IconData icon;
  final String title;
  final List<String> items;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DuskCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardTitle(icon: icon, title: title),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final item in items) TagChip(item, accent: accent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguagesCard extends StatelessWidget {
  const _LanguagesCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DuskCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CardTitle(icon: Icons.translate_rounded, title: 'Idiomas'),
            for (final (index, item) in idiomas.indexed) ...[
              if (index > 0)
                Divider(color: Dusk.cream.withValues(alpha: 0.08), height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.idioma,
                      style: DuskType.body(
                        size: 16.5,
                        weight: FontWeight.w700,
                        color: Dusk.cream,
                      ),
                    ),
                  ),
                  Text(
                    item.nivel,
                    style: DuskType.body(size: 15, color: Dusk.gold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
