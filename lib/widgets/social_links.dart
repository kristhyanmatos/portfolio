import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/links.dart';
import '../core/theme.dart';
import '../data/profile.dart';

class BrandIcon extends StatelessWidget {
  const BrandIcon(
    this.name, {
    super.key,
    this.size = 20,
    this.color = Dusk.cream,
  });

  /// Nome do arquivo em `assets/icons/`, sem extensão.
  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  static const _links = [
    ('github', 'GitHub', Profile.github),
    ('linkedin', 'LinkedIn', Profile.linkedin),
    ('whatsapp', 'WhatsApp', Profile.whatsapp),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (icon, label, url) in _links)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: label,
              onPressed: () => openLink(url),
              style: IconButton.styleFrom(
                backgroundColor: Dusk.cream.withValues(alpha: 0.08),
                side: BorderSide(color: Dusk.cream.withValues(alpha: 0.16)),
                fixedSize: const Size(48, 48),
              ),
              icon: BrandIcon(icon),
            ),
          ),
      ],
    );
  }
}
