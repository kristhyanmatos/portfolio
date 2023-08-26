import 'package:flutter/material.dart';

import 'company_widget.dart';
import 'experience_widget.dart';

class ExperiencesWidget extends StatelessWidget {
  const ExperiencesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
      child: ListView(
        shrinkWrap: true,
        children: const [
          CompanyWidget(
            name: 'Datalise Tecnologia da Informação LTDA',
            logo: 'assets/experiences/datalise.svg',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Líder Ténico de Desenvolvimento Mobile',
            subtitle:
                'Liderança técnica especializada no uso da linguagem Dart e do framework Flutter para criar experiências excepcionais. Aplicação de Clean Architecture, Server-Driven UI, SOLID e Clean Code para assegurar qualidade e escalabilidade. Proficiência em versionamento de código e metodologia SCRUM. Foco na colaboração da equipe e na promoção de um ambiente saudável, resultando em soluções robustas e ambientes produtivo.',
            inicio: 'Desde setembro de 2021',
            fim: '',
            develop:
                'Competências: Next.js · Server-Drive UI · Liderança · Arquitetura de software · Flutter · Python · TypeScript',
            urlLogoEmpresa: 'assets/experiences/datalise.svg',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvedor Full Stack',
            subtitle:
                'Desenvolvedor Full Stack, realizando junto a equipe um Sistema Web para gestão financeira de concessionárias. Tendo em vista, o mapeamento adequado de contas de entradas e saídas, exportação de relatórios para as montadoras, manutenção de contas lançadas de forma errônea.',
            inicio: 'Agosto de 2020',
            fim: 'Agosto de 2021 | 1 ano e 1 mês',
            develop:
                'Competências: SOLID · Clean Code · PostgreSQL · Python · Vue · TypeScript',
            urlLogoEmpresa: 'assets/experiences/logo-bitsjr.svg',
          ),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          CompanyWidget(
            name: 'Bits Jr - Soluções em TI',
            logo: 'assets/experiences/logo-bitsjr.svg',
            height: 40,
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvedor de Softwares Full Stack',
            subtitle:
                'Desenvolvedor Full Stack de sistemas Desktop em formato dashboard. Fazendo uso da gestão de projetos (SCRUM e XP). \n- Desenvolvi um sistema de controle de venda e estoque: "GERÊNCIA AMAZÔNIA" em Java Desktop Full State;\n- Desenvolvi um sistema capaz de monitorar o nível diurético de pacientes na UTI.',
            inicio: 'Março de 2019',
            fim: 'Julho de 2020 | 1 ano e 5 meses',
            develop:
                'Competências: Scrum · XP · Raspberry Pi · PostgreSQL · SQLite · Dashboards · Python · Java',
            urlLogoEmpresa: 'assets/experiences/datalise.svg',
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
