import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/profile.dart';

enum PortfolioSection {
  inicio('Início', Icons.wb_twilight_rounded),
  sobre('Sobre', Icons.person_outline_rounded),
  experiencias('Experiências', Icons.work_outline_rounded),
  projetos('Projetos', Icons.auto_awesome_mosaic_outlined),
  habilidades('Habilidades', Icons.bolt_rounded),
  formacao('Formação', Icons.school_outlined);

  const PortfolioSection(this.label, this.icon);
  final String label;
  final IconData icon;
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.active,
    required this.scrolled,
    required this.onSelect,
  });

  final ValueListenable<PortfolioSection> active;
  final ValueListenable<bool> scrolled;
  final ValueChanged<PortfolioSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          compact ? 12 : 24,
          12,
          compact ? 12 : 24,
          0,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ValueListenableBuilder<bool>(
            valueListenable: scrolled,
            builder: (context, isScrolled, _) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isScrolled
                    ? const Color(0xE6150E1B)
                    : const Color(0x33150E1B),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isScrolled
                      ? Dusk.line
                      : Dusk.cream.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  if (isScrolled)
                    const BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                ],
              ),
              child: compact
                  ? _CompactNav(scrolled: isScrolled, onSelect: onSelect)
                  : _WideNav(
                      active: active,
                      scrolled: isScrolled,
                      onSelect: onSelect,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavAvatar extends StatelessWidget {
  const _NavAvatar({required this.visible, required this.onTap});

  final bool visible;
  final VoidCallback onTap;

  static const _size = 40.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      alignment: Alignment.centerLeft,
      child: !visible
          ? const SizedBox(height: _size)
          : Tooltip(
              message: 'Voltar ao início',
              child: InkWell(
                onTap: onTap,
                customBorder: const CircleBorder(),
                child: Container(
                  width: _size,
                  height: _size,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Dusk.gold, Dusk.coral, Dusk.rose],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Dusk.amber.withValues(alpha: 0.4),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      Profile.avatar,
                      fit: BoxFit.cover,
                      semanticLabel: 'Foto de ${Profile.name}',
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _WideNav extends StatelessWidget {
  const _WideNav({
    required this.active,
    required this.scrolled,
    required this.onSelect,
  });

  final ValueListenable<PortfolioSection> active;
  final bool scrolled;
  final ValueChanged<PortfolioSection> onSelect;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PortfolioSection>(
      valueListenable: active,
      builder: (context, current, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavAvatar(
            visible: scrolled,
            onTap: () => onSelect(PortfolioSection.inicio),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: scrolled ? 8 : 0,
          ),
          for (final section in PortfolioSection.values.skip(1))
            _NavItem(
              section: section,
              selected: section == current,
              onTap: () => onSelect(section),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  final PortfolioSection section;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: DuskType.body(
                size: 15,
                weight: selected ? FontWeight.w800 : FontWeight.w600,
                color: selected ? Dusk.gold : Dusk.sand,
                height: 1.3,
              ),
              child: Text(section.label),
            ),
            const SizedBox(height: 4),
            // A luz de poste acende embaixo da seção atual.
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: selected ? 6 : 0,
              height: 6,
              decoration: BoxDecoration(
                color: Dusk.gold,
                shape: BoxShape.circle,
                boxShadow: [
                  if (selected)
                    BoxShadow(
                      color: Dusk.amber.withValues(alpha: 0.9),
                      blurRadius: 8,
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

class _CompactNav extends StatelessWidget {
  const _CompactNav({required this.scrolled, required this.onSelect});

  final bool scrolled;
  final ValueChanged<PortfolioSection> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavAvatar(
          visible: scrolled,
          onTap: () => onSelect(PortfolioSection.inicio),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: scrolled ? 12 : 4,
        ),
        Expanded(
          child: Text(
            'Kristhyan Maia',
            style: DuskType.terminal(size: 24, color: Dusk.cream),
          ),
        ),
        IconButton(
          tooltip: 'Menu',
          color: Dusk.cream,
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => _openMenu(context),
        ),
      ],
    );
  }

  Future<void> _openMenu(BuildContext context) async {
    final section = await showModalBottomSheet<PortfolioSection>(
      context: context,
      backgroundColor: const Color(0xFF1A1120),
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final section in PortfolioSection.values)
              ListTile(
                leading: Icon(section.icon, color: Dusk.amber),
                title: Text(
                  section.label,
                  style: DuskType.body(
                    size: 17,
                    weight: FontWeight.w700,
                    color: Dusk.cream,
                  ),
                ),
                onTap: () => Navigator.of(context).pop(section),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (section != null) onSelect(section);
  }
}
