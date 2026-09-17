import 'package:flutter/widgets.dart';

class Highlight {
  const Highlight(this.text, {this.title, this.tech});

  final String? title;
  final String text;
  final String? tech;
}

class Role {
  const Role({
    required this.title,
    required this.start,
    this.end,
    this.summary,
    this.highlights = const [],
    this.skills = const [],
  });

  final String title;
  final DateTime start;

  /// `null` enquanto o cargo estiver em andamento.
  final DateTime? end;
  final String? summary;
  final List<Highlight> highlights;
  final List<String> skills;

  bool get isCurrent => end == null;
}

class Company {
  const Company({
    required this.name,
    required this.shortName,
    required this.roles,
    this.detail,
    this.logo,
    this.logoHeight = 28,
  });

  final String name;
  final String shortName;
  final String? detail;
  final String? logo;
  final double logoHeight;
  final List<Role> roles;
}

enum ProjectCategory {
  web('Web'),
  mobile('Mobile'),
  dados('Dados'),
  infra('Infra');

  const ProjectCategory(this.label);
  final String label;
}

enum LinkKind { site, android, ios, github }

class ProjectLink {
  const ProjectLink(this.label, this.url, {this.kind = LinkKind.site});

  final String label;
  final String url;
  final LinkKind kind;
}

sealed class ProjectCover {
  const ProjectCover();
}

/// Captura de tela exibida dentro de uma janela de navegador.
class ScreenshotCover extends ProjectCover {
  const ScreenshotCover(this.asset, {required this.domain});

  final String asset;
  final String domain;
}

/// Telas de app lado a lado.
class PhonesCover extends ProjectCover {
  const PhonesCover(this.screens);

  final List<String> screens;
}

/// Para projetos sem uma tela pública que os represente bem.
class PosterCover extends ProjectCover {
  const PosterCover({required this.icon, required this.caption, this.logo});

  final IconData icon;
  final String caption;
  final String? logo;
}

class Project {
  const Project({
    required this.name,
    required this.description,
    required this.stack,
    required this.categories,
    required this.cover,
    this.year,
    this.context,
    this.links = const [],
  });

  final String name;
  final String? year;
  final String? context;
  final String description;
  final List<String> stack;
  final Set<ProjectCategory> categories;
  final ProjectCover cover;
  final List<ProjectLink> links;

  List<String> get images => switch (cover) {
    ScreenshotCover(:final asset) => [asset],
    PhonesCover(:final screens) => screens,
    PosterCover() => const [],
  };
}
