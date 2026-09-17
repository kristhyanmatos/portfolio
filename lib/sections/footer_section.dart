import 'package:flutter/material.dart';

import '../core/links.dart';
import '../core/theme.dart';
import '../data/profile.dart';
import '../widgets/section.dart';
import '../widgets/social_links.dart';

/// Rodapé com espaço sobrando para a roda de violão aparecer à noite.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  static const _shadow = [Shadow(color: Color(0xCC0D0812), blurRadius: 18)];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return SectionFrame(
      top: height * 0.22,
      bottom: height * 0.42,
      child: Column(
        children: [
          Text(
            'a roda continua amanhã, no mesmo lugar',
            textAlign: TextAlign.center,
            style: DuskType.terminal(size: 34, color: Dusk.gold),
          ),
          const SizedBox(height: 18),
          const SocialLinks(),
          const SizedBox(height: 18),
          Text(
            '© ${DateTime.now().year} ${Profile.name} · feito com Flutter ao pôr do sol',
            textAlign: TextAlign.center,
            style: DuskType.body(size: 14, color: Dusk.sand, shadows: _shadow),
          ),
          TextButton.icon(
            onPressed: () => openLink(Profile.repository),
            style: TextButton.styleFrom(foregroundColor: Dusk.amber),
            icon: const BrandIcon('github', size: 16, color: Dusk.amber),
            label: Text(
              'Código deste portfólio',
              style: DuskType.body(
                size: 14,
                weight: FontWeight.w700,
                color: Dusk.amber,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
