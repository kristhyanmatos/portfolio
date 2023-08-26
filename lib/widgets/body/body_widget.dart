import 'package:flutter/material.dart';

import 'education/education_widget.dart';
import 'experiences/experiences_widget.dart';
import 'projects/projects_widget.dart';
import 'skills/skills_widget.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 48, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              ChoiceChip(
                label: const Text('Projetos'),
                selected: index == 0,
                onSelected: (value) => setState(() {
                  index = 0;
                }),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Experiências'),
                selected: index == 1,
                onSelected: (value) => setState(() {
                  index = 1;
                }),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Habilidades / Competencias'),
                selected: index == 2,
                onSelected: (value) => setState(() {
                  index = 2;
                }),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Formação'),
                selected: index == 3,
                onSelected: (value) => setState(() {
                  index = 3;
                }),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: ListView(
              shrinkWrap: true,
              children: [
                if (index == 0) const ProjectsWidget(),
                if (index == 1) const ExperiencesWidget(),
                if (index == 2) const SkillsWidget(),
                if (index == 3) const EducationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
