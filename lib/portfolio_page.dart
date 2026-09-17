import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'scene/sunset_scene.dart';
import 'sections/about_section.dart';
import 'sections/education_section.dart';
import 'sections/experiences_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'widgets/nav_bar.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();
  final _progress = ValueNotifier<double>(0);
  final _active = ValueNotifier(PortfolioSection.inicio);
  final _scrolled = ValueNotifier(false);
  final _keys = {
    for (final section in PortfolioSection.values) section: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    _progress.dispose();
    _active.dispose();
    _scrolled.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scroll.position;
    final max = position.maxScrollExtent;
    _progress.value = max <= 0 ? 0 : (position.pixels / max).clamp(0.0, 1.0);
    _scrolled.value = position.pixels > 24;
    _active.value = _currentSection();
  }

  /// Última seção cujo topo já passou do primeiro terço da tela.
  PortfolioSection _currentSection() {
    final threshold = MediaQuery.sizeOf(context).height * 0.35;
    var current = PortfolioSection.inicio;
    for (final section in PortfolioSection.values) {
      final box =
          _keys[section]!.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) current = section;
    }
    return current;
  }

  void _goTo(PortfolioSection section) {
    final context = _keys[section]!.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Dusk.night,
      body: Stack(
        children: [
          Positioned.fill(child: SunsetScene(progress: _progress)),
          Positioned.fill(
            child: Scrollbar(
              controller: _scroll,
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  children: [
                    HeroSection(
                      key: _keys[PortfolioSection.inicio],
                      onNavigate: _goTo,
                    ),
                    AboutSection(key: _keys[PortfolioSection.sobre]),
                    ExperiencesSection(
                      key: _keys[PortfolioSection.experiencias],
                    ),
                    ProjectsSection(key: _keys[PortfolioSection.projetos]),
                    SkillsSection(key: _keys[PortfolioSection.habilidades]),
                    EducationSection(key: _keys[PortfolioSection.formacao]),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              active: _active,
              scrolled: _scrolled,
              onSelect: _goTo,
            ),
          ),
        ],
      ),
    );
  }
}
