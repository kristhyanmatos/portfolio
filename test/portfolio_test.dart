import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app_widget.dart';
import 'package:portfolio/data/experiences.dart';
import 'package:portfolio/data/profile.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/widgets/section.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('todos os arquivos referenciados existem', () {
    final assets = {
      Formacao.logo,
      for (final company in companies) ?company.logo,
      for (final project in projects) ...project.images,
    };
    for (final asset in assets) {
      expect(File(asset).existsSync(), isTrue, reason: asset);
    }
  });

  test('nomes de projetos são únicos', () {
    final names = projects.map((project) => project.name).toSet();
    expect(names, hasLength(projects.length));
  });

  for (final (label, size) in [
    ('desktop', const Size(1440, 900)),
    ('celular', const Size(390, 844)),
  ]) {
    testWidgets('renderiza a página inteira no $label', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AppWidget());
      await tester.pump(const Duration(seconds: 2));

      expect(find.text(Profile.name), findsOneWidget);
      expect(find.text('Experiências'), findsWidgets);

      final scrollable = find.byType(Scrollable).first;
      for (final title in ['Projetos', 'Habilidades', 'Formação']) {
        await tester.scrollUntilVisible(
          find.descendant(
            of: find.byType(SectionHeader),
            matching: find.text(title),
          ),
          400,
          scrollable: scrollable,
        );
        await tester.pump(const Duration(milliseconds: 300));
      }
      await tester.scrollUntilVisible(
        find.text('Código deste portfólio'),
        400,
        scrollable: scrollable,
      );
      expect(find.text('TacTov'), findsOneWidget);
    });
  }
}
