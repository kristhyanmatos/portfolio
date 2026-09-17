import 'package:flutter/material.dart';

import '../core/links.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/models.dart';
import '../data/projects.dart';
import '../widgets/dusk_card.dart';
import '../widgets/expandable_text.dart';
import '../widgets/project_cover.dart';
import '../widgets/project_preview_dialog.dart';
import '../widgets/section.dart';
import '../widgets/social_links.dart';
import '../widgets/tag_chip.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final visible = [
      for (final (index, project) in projects.indexed)
        if (_filter == null || project.categories.contains(_filter))
          (index, project),
    ];

    return SectionFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            kicker: 'o repertório',
            title: 'Projetos',
            description: 'Um pouco do que já toquei por aí: plataformas, apps, dashboards de dados e até a infraestrutura onde tudo isso roda.',
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _FilterPill(
                label: 'Todos',
                count: projects.length,
                selected: _filter == null,
                onTap: () => setState(() => _filter = null),
              ),
              for (final category in ProjectCategory.values)
                _FilterPill(
                  label: category.label,
                  count: projects
                      .where((p) => p.categories.contains(category))
                      .length,
                  selected: _filter == category,
                  onTap: () => setState(() => _filter = category),
                ),
            ],
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 860 ? 2 : 1;
              const gap = 24.0;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var column = 0; column < columns; column++) ...[
                    if (column > 0) const SizedBox(width: gap),
                    Expanded(
                      child: Column(
                        children: [
                          for (final (i, (index, project)) in visible.indexed)
                            if (i % columns == column)
                              Padding(
                                padding: const EdgeInsets.only(bottom: gap),
                                child: _ProjectCard(
                                  key: ValueKey(project.name),
                                  project: project,
                                  index: index,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Dusk.night : Dusk.cream;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Dusk.amber : const Color(0xB3150E1B),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? Dusk.amber : Dusk.cream.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: DuskType.body(
                  size: 15,
                  weight: FontWeight.w700,
                  color: foreground,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$count',
                style: DuskType.body(
                  size: 13,
                  weight: FontWeight.w800,
                  color: foreground.withValues(alpha: 0.6),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({super.key, required this.project, required this.index});

  final Project project;
  final int index;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final compact = context.isCompact;
    final meta = [?project.year, ?project.context];
    final canPreview = project.images.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: DuskCard(
        highlight: _hovered,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              button: canPreview,
              label: canPreview ? 'Ampliar imagens de ${project.name}' : null,
              child: GestureDetector(
                onTap: canPreview
                    ? () => showProjectPreview(context, project)
                    : null,
                child: MouseRegion(
                  cursor: canPreview
                      ? SystemMouseCursors.zoomIn
                      : MouseCursor.defer,
                  child: ProjectCoverView(
                    project: project,
                    index: widget.index,
                    hovered: _hovered,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                compact ? 20 : 26,
                22,
                compact ? 20 : 26,
                26,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (meta.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        meta.join(' · ').toUpperCase(),
                        style: DuskType.body(
                          size: 12,
                          weight: FontWeight.w800,
                          color: Dusk.amber,
                          letterSpacing: 1.3,
                          height: 1.4,
                        ),
                      ),
                    ),
                  Text(
                    project.name,
                    style: DuskType.heading(
                      size: compact ? 24 : 27,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpandableText(
                    project.description,
                    style: DuskType.body(size: 15.5),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tech in project.stack)
                        TagChip(tech, accent: true),
                    ],
                  ),
                  if (project.links.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final link in project.links)
                          _LinkButton(link: link),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.link});

  final ProjectLink link;

  @override
  Widget build(BuildContext context) {
    final icon = switch (link.kind) {
      LinkKind.site => const Icon(Icons.open_in_new_rounded, size: 18),
      LinkKind.android => const Icon(Icons.android_rounded, size: 18),
      LinkKind.ios => const Icon(Icons.apple_rounded, size: 18),
      LinkKind.github => const BrandIcon('github', size: 17, color: Dusk.gold),
    };
    return TextButton.icon(
      onPressed: () => openLink(link.url),
      icon: icon,
      label: Text(
        link.label,
        style: DuskType.body(
          size: 14.5,
          weight: FontWeight.w700,
          color: Dusk.gold,
          height: 1.2,
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Dusk.gold,
        backgroundColor: Dusk.amber.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: StadiumBorder(
          side: BorderSide(color: Dusk.amber.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}
