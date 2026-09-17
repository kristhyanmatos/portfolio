import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/models.dart';
import 'asset_picture.dart';

const _palettes = [
  [Color(0xFF5B2A5E), Color(0xFFE0735F)],
  [Color(0xFF2E2352), Color(0xFFB8527A)],
  [Color(0xFF6A2F3F), Color(0xFFF2A15A)],
  [Color(0xFF1F2A4A), Color(0xFF8F4C79)],
];

class ProjectCoverView extends StatelessWidget {
  const ProjectCoverView({
    super.key,
    required this.project,
    required this.index,
    this.hovered = false,
  });

  final Project project;
  final int index;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _palettes[index % _palettes.length],
          ),
        ),
        child: AnimatedScale(
          scale: hovered ? 1.035 : 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          child: switch (project.cover) {
            ScreenshotCover(:final asset, :final domain) => _BrowserWindow(
              asset: asset,
              domain: domain,
            ),
            PhonesCover(:final screens) => _Phones(screens: screens),
            PosterCover(:final icon, :final caption, :final logo) => _Poster(
              icon: icon,
              caption: caption,
              logo: logo,
            ),
          },
        ),
      ),
    );
  }
}

class _BrowserWindow extends StatelessWidget {
  const _BrowserWindow({required this.asset, required this.domain});

  final String asset;
  final String domain;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inset = constraints.maxWidth * 0.07;
        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: inset,
              right: inset,
              top: inset * 0.8,
              bottom: -inset,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x80000000),
                      blurRadius: 24,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 24,
                        color: const Color(0xFF231A28),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            for (final color in const [
                              Color(0xFFFF6B5A),
                              Color(0xFFFFC05A),
                              Color(0xFF6BD68A),
                            ])
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 14,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: const Color(0x14FFFFFF),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  domain,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: DuskType.body(
                                    size: 9.5,
                                    color: Dusk.muted,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          asset,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Phones extends StatelessWidget {
  const _Phones({required this.screens});

  final List<String> screens;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight * 0.84;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (final (i, screen) in screens.indexed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Transform.translate(
                  offset: Offset(0, i == 1 ? -6 : 10),
                  child: SizedBox(
                    height: height * (i == 1 ? 1 : 0.9),
                    width: height * 0.5 * (i == 1 ? 1 : 0.9),
                    child: AssetPicture(screen, fit: BoxFit.contain),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.icon, required this.caption, this.logo});

  final IconData icon;
  final String caption;
  final String? logo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          right: -30,
          bottom: -50,
          child: Icon(
            icon,
            size: 240,
            color: Colors.white.withValues(alpha: 0.07),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (logo case final logo?)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Dusk.cream,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x66000000),
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        logo,
                        width: 200,
                        filterQuality: FilterQuality.medium,
                      ),
                    )
                  else
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Dusk.night.withValues(alpha: 0.35),
                        border: Border.all(
                          color: Dusk.gold.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(icon, size: 42, color: Dusk.gold),
                    ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Text(
                      caption,
                      textAlign: TextAlign.center,
                      style: DuskType.terminal(size: 27, color: Dusk.cream),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
