import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme.dart';
import '../data/models.dart';

Future<void> showProjectPreview(BuildContext context, Project project) {
  return showDialog<void>(
    context: context,
    barrierColor: const Color(0xE00A060D),
    builder: (context) => _ProjectPreviewDialog(project: project),
  );
}

class _ProjectPreviewDialog extends StatefulWidget {
  const _ProjectPreviewDialog({required this.project});

  final Project project;

  @override
  State<_ProjectPreviewDialog> createState() => _ProjectPreviewDialogState();
}

class _ProjectPreviewDialogState extends State<_ProjectPreviewDialog> {
  final _pages = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _go(int page) => _pages.animateToPage(
    page,
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final images = widget.project.images;
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: math.min(1100, size.width),
        height: size.height * 0.88,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.project.name,
                    style: DuskType.heading(size: 24),
                  ),
                ),
                IconButton(
                  tooltip: 'Fechar',
                  color: Dusk.cream,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: PageView(
                controller: _pages,
                onPageChanged: (page) => setState(() => _page = page),
                children: [
                  for (final image in images)
                    InteractiveViewer(
                      maxScale: 4,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: image.endsWith('.svg')
                              ? SvgPicture.asset(image, fit: BoxFit.contain)
                              : Image.asset(image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (images.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Anterior',
                      color: Dusk.cream,
                      onPressed: _page > 0 ? () => _go(_page - 1) : null,
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
                    for (var i = 0; i < images.length; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _page ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _page
                              ? Dusk.amber
                              : Dusk.cream.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    IconButton(
                      tooltip: 'Próxima',
                      color: Dusk.cream,
                      onPressed: _page < images.length - 1
                          ? () => _go(_page + 1)
                          : null,
                      icon: const Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
