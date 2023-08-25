import 'package:flutter/material.dart';

import 'skill_widget.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 32,
      runSpacing: 32,
      children: [
        SkillWidget(
          title: 'Competências',
          list: [
            'Liderança',
            'Flexibilidade',
            'Colaboração',
            'Gestão de projetos',
            'Resolução de problemas',
          ],
        ),
        SkillWidget(
          title: 'Ferramentas',
          list: [
            'Flutter / Dart',
            'Python',
            'Typescript',
            'Next.js',
            'Clean Architecture',
            'Clean Code',
            'SOLID',
            'Versionamento de código',
            'Figma',
          ],
        ),
        SkillWidget(
          title: 'Idiomas',
          list: ['Português / Avançado', 'Inglês / Intermediário'],
        ),
      ],
    );
  }
}
