import 'package:flutter/material.dart';

import 'project_widget.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        ProjectWidget(
          title: 'Datalise App',
          subtitle:
              'App que conecta clientes com trabalhadores autônomos que prestam serviços com fretes e mudanças.',
          urlsIcons: [
            'icons/flutter.svg',
            'icons/firebase.svg',
            'icons/node-js.svg',
          ],
          develop:
              'Desenvolvido com Flutter,  micro-serviços do Firebase: Functions, Messaging, Cloud Firestore, Cloud Storage e Node.js. Utilizando Clean Architecture, Clean Code e as boas práticas de criação e manutenção do código.',
          urlsImages: [
            'projects/datalise_1.svg',
            'projects/datalise_2.svg',
            'projects/datalise_3.svg',
          ],
        ),
        SizedBox(height: 32),
        ProjectWidget(
          title: 'Leva Almondes',
          subtitle:
              'App que conecta clientes com trabalhadores autônomos que prestam serviços com fretes e mudanças.',
          urlsIcons: [
            'icons/flutter.svg',
            'icons/firebase.svg',
            'icons/node-js.svg',
          ],
          develop:
              'Desenvolvido com Flutter,  micro-serviços do Firebase: Functions, Messaging, Cloud Firestore, Cloud Storage e Node.js. Utilizando Clean Architecture, Clean Code e as boas práticas de criação e manutenção do código.',
          urlsImages: [
            'projects/leva_almondes_1.svg',
            'projects/leva_almondes_2.svg',
            'projects/leva_almondes_3.svg',
          ],
        ),
        SizedBox(height: 64),
      ],
    );
  }
}
