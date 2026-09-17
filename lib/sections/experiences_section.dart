import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/experiences.dart';
import '../data/models.dart';
import '../data/period.dart';
import '../widgets/asset_picture.dart';
import '../widgets/dusk_card.dart';
import '../widgets/section.dart';
import '../widgets/tag_chip.dart';

class ExperiencesSection extends StatelessWidget {
  const ExperiencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final indent = compact ? 34.0 : 52.0;
    final years = monthsInclusive(careerStart, DateTime.now()) ~/ 12;

    return SectionFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            kicker: 'histórias contadas na roda',
            title: 'Experiências',
            description:
                'Mais de $years anos construindo produtos, liderando times e cuidando de sistemas em produção.',
          ),
          Stack(
            children: [
              Positioned(
                left: 11,
                top: 14,
                bottom: 40,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Dusk.amber.withValues(alpha: 0.8),
                        Dusk.rose.withValues(alpha: 0.35),
                        Dusk.rose.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: indent),
                child: Column(
                  children: [
                    for (final company in companies)
                      _CompanyBlock(company: company, indent: indent),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompanyBlock extends StatelessWidget {
  const _CompanyBlock({required this.company, required this.indent});

  final Company company;
  final double indent;

  @override
  Widget build(BuildContext context) {
    final lit = company.roles.any((role) => role.isCurrent);
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -indent,
            top: 8,
            child: _LampDot(lit: lit),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CompanyHeader(company: company),
              const SizedBox(height: 18),
              for (final role in company.roles)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _RoleCard(role: role),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Marcador da linha do tempo: aceso enquanto a experiência continua.
class _LampDot extends StatelessWidget {
  const _LampDot({required this.lit});

  final bool lit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lit ? Dusk.gold : const Color(0xFF3A2638),
        border: Border.all(
          color: Dusk.amber.withValues(alpha: lit ? 1 : 0.5),
          width: 2,
        ),
        boxShadow: [
          if (lit)
            BoxShadow(
              color: Dusk.amber.withValues(alpha: 0.75),
              blurRadius: 18,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lit ? Colors.white : Dusk.amber.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

class _CompanyHeader extends StatelessWidget {
  const _CompanyHeader({required this.company});

  final Company company;

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    return Row(
      children: [
        if (company.logo case final logo?) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Dusk.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AssetPicture(
              logo,
              height: company.logoHeight,
              semanticLabel: company.name,
            ),
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company.name,
                style: DuskType.heading(size: compact ? 21 : 25, height: 1.2),
              ),
              if (company.detail case final detail?)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    detail,
                    style: DuskType.body(
                      size: 14.5,
                      color: Dusk.muted,
                      height: 1.4,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleCard extends StatefulWidget {
  const _RoleCard({required this.role});

  final Role role;

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard> {
  static const _collapsedHighlights = 2;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    final compact = context.isCompact;
    final collapsible = role.highlights.length > 3;
    final visible = collapsible && !_expanded
        ? role.highlights.take(_collapsedHighlights)
        : role.highlights;

    return DuskCard(
      highlight: role.isCurrent,
      padding: EdgeInsets.all(compact ? 20 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                role.title,
                style: DuskType.body(
                  size: 19,
                  weight: FontWeight.w800,
                  color: Dusk.cream,
                  height: 1.3,
                ),
              ),
              if (role.isCurrent) const _NowBadge(),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 16, color: Dusk.amber),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  formatPeriod(role.start, role.end),
                  style: DuskType.body(
                    size: 14.5,
                    weight: FontWeight.w700,
                    color: Dusk.amber,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          if (role.summary case final summary?) ...[
            const SizedBox(height: 14),
            Text(summary, style: DuskType.body(size: 16, height: 1.65)),
          ],
          if (role.highlights.isNotEmpty) ...[
            const SizedBox(height: 16),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final highlight in visible)
                    _HighlightTile(highlight: highlight),
                ],
              ),
            ),
            if (collapsible)
              TextButton.icon(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(foregroundColor: Dusk.amber),
                icon: Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                ),
                label: Text(
                  _expanded
                      ? 'Ver menos'
                      : 'Ver mais ${role.highlights.length - _collapsedHighlights} destaques',
                  style: DuskType.body(
                    size: 14.5,
                    weight: FontWeight.w700,
                    color: Dusk.amber,
                    height: 1.2,
                  ),
                ),
              ),
          ],
          if (role.skills.isNotEmpty) ...[
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final skill in role.skills) TagChip(skill)],
            ),
          ],
        ],
      ),
    );
  }
}

class _NowBadge extends StatelessWidget {
  const _NowBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: Dusk.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Dusk.amber.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Dusk.gold,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Dusk.amber.withValues(alpha: 0.9),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'atual',
            style: DuskType.body(
              size: 12.5,
              weight: FontWeight.w800,
              color: Dusk.gold,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightTile extends StatelessWidget {
  const _HighlightTile({required this.highlight});

  final Highlight highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Transform.rotate(
              angle: 0.785,
              child: Container(width: 7, height: 7, color: Dusk.amber),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (highlight.title case final title?)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      title,
                      style: DuskType.body(
                        size: 16,
                        weight: FontWeight.w800,
                        color: Dusk.cream,
                        height: 1.45,
                      ),
                    ),
                  ),
                Text(highlight.text, style: DuskType.body(size: 15.5)),
                if (highlight.tech case final tech?)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Tecnologias: $tech',
                      style: DuskType.body(
                        size: 14,
                        color: Dusk.muted,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
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
