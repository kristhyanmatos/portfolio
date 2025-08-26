import 'package:flutter/material.dart';

import 'company_widget.dart';
import 'experience_widget.dart';

class ExperiencesWidget extends StatelessWidget {
  const ExperiencesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompanyWidget(
            name: 'Mobato',
            logo: '',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvedor de Aplicativos Pleno',
            subtitle:
                'Liderança técnica especializada no uso da linguagem Dart e do framework Flutter para criar experiências excepcionais. Aplicação de Clean Architecture, Server-Driven UI, SOLID e Clean Code para assegurar qualidade e escalabilidade. Proficiência em versionamento de código e metodologia SCRUM. Foco na colaboração da equipe e na promoção de um ambiente saudável, resultando em soluções robustas e ambientes produtivo.',
            inicio: 'Desde de Dezembro de 2023',
            fim: '',
            develop:
                'Competências: Next.js · Server-Drive UI · Liderança · Arquitetura de software · Flutter · Python · TypeScript',
          ),
          SizedBox(height: 32),
          CompanyWidget(
            name: 'Datalise Tecnologia da Informação LTDA',
            logo: 'assets/experiences/datalise.svg',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Líder Ténico de Desenvolvimento Mobile',
            subtitle:
                'Desenvolvedor Mobile, atuando na criação de novas funções para o Mobato App, além de realizar manutenções. Aplicação de Clean Architecture, Server-Driven UI, SOLID e Clean Code para assegurar qualidade e escalabilidade. Proficiência em versionamento de código e metodologia SCRUM. Foco na colaboração da equipe e na promoção de um ambiente saudável, resultando em soluções robustas e ambientes produtivo.',
            inicio: 'Setembro de 2021',
            fim: '- Novembro de 2023 | 2 anos e 4 meses',
            develop:
                'Competências: Kotlin · Boa comunicação · Clean Code · Java · Resolução de problemas',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvedor Full Stack',
            subtitle:
                'Desenvolvedor Full Stack, realizando junto a equipe um Sistema Web para gestão financeira de concessionárias. Tendo em vista, o mapeamento adequado de contas de entradas e saídas, exportação de relatórios para as montadoras, manutenção de contas lançadas de forma errônea.',
            inicio: 'Agosto de 2020',
            fim: '- Agosto de 2021 | 1 ano e 1 mês',
            develop:
                'Competências: SOLID · Clean Code · PostgreSQL · Python · Vue · TypeScript',
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
                'Marcando o início de carreia, tive a oportunidade de desenvolver diversos sistemas e soluções de forma Full Stack. Iniciando a aplicação  dos conceitos e metodologias técnicas adquiridas em sala de aula, além de fazer o uso da gestão de projetos (SCRUM e XP) da Engenharia de Software. \n- Desenvolvi um sistema de controle de venda e estoque: "GERÊNCIA AMAZÔNIA" em Java Desktop Full State;\n- Desenvolvi um sistema capaz de monitorar o nível diurético de pacientes na UTI.',
            inicio: 'Março de 2019',
            fim: '- Julho de 2020 | 1 ano e 5 meses',
            develop:
                'Competências: Scrum · XP · Raspberry Pi · PostgreSQL · SQLite · Dashboards · Python · Java',
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
