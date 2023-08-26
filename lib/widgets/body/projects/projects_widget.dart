import 'package:flutter/material.dart';

import 'project_widget.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProjectWidget(
          title: 'Datalise App',
          subtitle:
              'App mobile para a centralização e exibição de dados do estado atual nos grupos de concessionárias de forma mais legível e organizada, em formato de Dashboard. Podendo fazer exportações de relatórios, notificações sobre metas e métricas, além de ranking geral e específico dos funcionários cadastrados, geração de relatórios em pdf e um sistema de indicadores, metas e notificações.',
          urlsIcons: [
            'assets/icons/flutter.svg',
            'assets/icons/firebase.svg',
            'assets/icons/node-js.svg',
            'assets/icons/python.svg',
            'assets/icons/postgresql.svg',
            'assets/icons/amazon-web-services.svg',
          ],
          develop:
              'O sistema foi desenvolvido usando as tecnologias Dart/Flutter e Python, através das boas práticas de gestão de código e de processos.',
          urlsImages: [
            'assets/projects/datalise_1.svg',
            'assets/projects/datalise_2.svg',
            'assets/projects/datalise_3.svg',
          ],
        ),
        SizedBox(height: 24),
        Divider(),
        SizedBox(height: 24),
        ProjectWidget(
          title: 'Leva Almondes',
          subtitle:
              'App que conecta clientes com trabalhadores autônomos que prestam serviços com fretes e mudanças.',
          urlsIcons: [
            'assets/icons/flutter.svg',
            'assets/icons/firebase.svg',
            'assets/icons/node-js.svg',
          ],
          develop:
              'Desenvolvido com Flutter,  micro-serviços do Firebase: Functions, Messaging, Cloud Firestore, Cloud Storage e Node.js. Utilizando Clean Architecture, Clean Code e as boas práticas de criação e manutenção do código.',
          urlsImages: [
            'assets/projects/leva_almondes_1.svg',
            'assets/projects/leva_almondes_2.svg',
            'assets/projects/leva_almondes_3.svg',
          ],
        ),
        SizedBox(height: 64),
      ],
    );
  }
}
