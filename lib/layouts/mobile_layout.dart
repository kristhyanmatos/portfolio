import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/education/education_widget.dart';

import '../widgets/about/about_widget.dart';
import '../widgets/backgound_widget.dart';
import '../widgets/body/experiences/experiences_widget.dart';
import '../widgets/body/projects/projects_widget.dart';
import '../widgets/body/skills/skills_widget.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgoundWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                title: Text(
                  'Portfólio',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 115,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (index == 0) const AboutWidget(),
                    if (index == 1) const ExperiencesWidget(),
                    if (index == 2) const ProjectsWidget(),
                    if (index == 3) const SkillsWidget(),
                    if (index == 4) const EducationWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        elevation: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: Theme.of(context).colorScheme.primary),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.work, color: Theme.of(context).colorScheme.primary),
            label: 'Experiências',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.build, color: Theme.of(context).colorScheme.primary),
            label: 'Projetos',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.power, color: Theme.of(context).colorScheme.primary),
            label: 'Habilidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city,
                color: Theme.of(context).colorScheme.primary),
            label: 'Formação',
          ),
        ],
      ),
    );
  }
}
