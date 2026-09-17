import 'package:flutter/material.dart';

import '../core/links.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/experiences.dart';
import '../data/period.dart';
import '../data/profile.dart';
import '../data/projects.dart';
import '../widgets/nav_bar.dart';
import '../widgets/section.dart';
import '../widgets/social_links.dart';

const _shadow = [Shadow(color: Color(0xB3140A18), blurRadius: 20)];

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onNavigate});

  final ValueChanged<PortfolioSection> onNavigate;

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Stack(
        children: [
          SectionFrame(
            top: compact ? 100 : (screenHeight * 0.13).clamp(92.0, 120.0),
            bottom: compact ? 48 : 96,
            child: Align(
              alignment: Alignment.topLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 880),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 24),
                      child: child,
                    ),
                  ),
                  child: _HeroContent(onNavigate: onNavigate),
                ),
              ),
            ),
          ),
          // No celular o conteúdo já ocupa a tela toda.
          if (!compact)
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: SectionFrame(
                top: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _ScrollHint(
                    onTap: () => onNavigate(PortfolioSection.sobre),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.onNavigate});

  final ValueChanged<PortfolioSection> onNavigate;

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final greeting = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'boa tarde! chega mais, a roda já começou',
          style: DuskType.terminal(size: compact ? 24 : 30),
        ),
        const SizedBox(height: 4),
        Text(
          Profile.name,
          style: DuskType.heading(
            size: compact ? 40 : 58,
            height: 1.04,
            shadows: _shadow,
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact) ...[
          const _ProfilePhoto(size: 88),
          const SizedBox(height: 20),
          greeting,
        ] else
          Row(
            children: [
              const _ProfilePhoto(size: 112),
              const SizedBox(width: 24),
              Flexible(child: greeting),
            ],
          ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 660),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Profile.headline,
                style: DuskType.body(
                  size: compact ? 17 : 20,
                  weight: FontWeight.w700,
                  color: Dusk.gold,
                  height: 1.4,
                  shadows: _shadow,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                Profile.tagline,
                style: DuskType.body(
                  size: compact ? 16.5 : 18,
                  color: Dusk.cream,
                  shadows: _shadow,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () => onNavigate(PortfolioSection.projetos),
              icon: const Icon(Icons.auto_awesome_mosaic_outlined, size: 20),
              label: const Text('Ver projetos'),
            ),
            OutlinedButton.icon(
              onPressed: () => openLink(Profile.whatsapp),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0x4D150E1B),
              ),
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
              label: const Text('Bora conversar'),
            ),
            const SocialLinks(),
          ],
        ),
        const SizedBox(height: 24),
        const _Stats(),
      ],
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Dusk.gold, Dusk.coral, Dusk.rose],
        ),
        boxShadow: [
          BoxShadow(color: Dusk.amber.withValues(alpha: 0.45), blurRadius: 40),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          Profile.avatar,
          fit: BoxFit.cover,
          semanticLabel: 'Foto de ${Profile.name}',
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: Dusk.plum,
            child: Center(
              child: Text('KM', style: DuskType.heading(size: size * 0.32)),
            ),
          ),
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final years = monthsInclusive(careerStart, DateTime.now()) ~/ 12;
    final stats = [
      ('$years+', 'anos de estrada'),
      ('${projects.length}', 'projetos no repertório'),
      ('${companies.length}', 'empresas e laboratórios'),
    ];

    if (context.isCompact) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (value, label) in stats)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: DuskType.heading(
                      size: 30,
                      color: Dusk.gold,
                      shadows: _shadow,
                    ),
                  ),
                  Text(
                    label,
                    style: DuskType.body(
                      size: 13,
                      weight: FontWeight.w600,
                      height: 1.25,
                      shadows: _shadow,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Wrap(
      spacing: 32,
      runSpacing: 16,
      children: [
        for (final (value, label) in stats)
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: DuskType.heading(
                  size: 34,
                  color: Dusk.gold,
                  shadows: _shadow,
                ),
              ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Text(
                  label,
                  style: DuskType.body(
                    size: 14,
                    weight: FontWeight.w600,
                    color: Dusk.sand,
                    height: 1.25,
                    shadows: _shadow,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ScrollHint extends StatefulWidget {
  const _ScrollHint({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint>
    with SingleTickerProviderStateMixin {
  late final _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _bounce.stop();
    } else if (!_bounce.isAnimating) {
      _bounce.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 6, 16, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _bounce,
              builder: (context, child) => Transform.translate(
                offset: Offset(
                  0,
                  Curves.easeInOut.transform(_bounce.value) * 6,
                ),
                child: child,
              ),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Dusk.gold,
                size: 30,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'role a página e veja o sol se pôr',
              style: DuskType.terminal(size: 24, color: Dusk.cream),
            ),
          ],
        ),
      ),
    );
  }
}
