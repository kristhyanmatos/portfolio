import 'package:flutter/material.dart';

import 'skill_widget.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
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
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 16),
        SkillWidget(
          title: 'Ferramentas',
          list: [
            'Flutter / Dart',
            'Clean Architecture',
            'Clean Code',
            'SOLID',
            'Typescript',
            'Next.js',
            'Nest.js',
            'Python',
            'Versionamento de código',
          ],
        ),
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 16),
        SkillWidget(
          title: 'Idiomas',
          list: ['Português / Avançado', 'Inglês / Intermediário'],
        ),
      ],
    );
  }
}
