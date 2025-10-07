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
            title: 'Desenvolvedor de Aplicativos',
            subtitle:
                '''Responsável por desenvolver novas funcionalidades e realizar manutenções contínuas do aplicativo Mobato (Kotlin e Java), com foco em criar uma experiência de usuário nativa, robusta e de alta performance:
  I. Otimizando continuamente o código e a arquitetura da aplicação para garantir máxima performance e estabilidade, impactando diretamente na qualidade do produto final;
  II. Gerenciando todo o ciclo de vida das entregas com Git, controlando o versionamento e a implantação do código através dos ambientes de desenvolvimento, homologação e produção;
  III. Colaborando em um ambiente de desenvolvimento ágil, participando ativamente do planejamento e execução de sprints para manter um fluxo de trabalho dinâmico e alinhado aos objetivos estratégicos do negócio.''',
            inicio: 'Desde de Dezembro de 2023 | 1 Ano · 11 Meses',
            fim: '',
            develop:
                'Competências: Kotlin · Boa comunicação · Clean Code · Java · Resolução de problemas',
          ),
          SizedBox(height: 32),
          CompanyWidget(
            name:
                'Universidade do Sul e Sudeste do Pará [UNIFESSPA] - Laboratório de Contas Regionais da Amazônia [Lacam]',
            logo: '',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Lider Técnico',
            subtitle:
                '''I. Desenvolvimento Full-Stack do Sistema de Filtro de Notas Fiscais (NF-e) do Pará:
Liderei o desenvolvimento de uma aplicação robusta para filtrar e analisar um grande volume de dados, tratando bases com mais de 100 milhões de linhas em MongoDB. O sistema permite a geração de relatórios em CSV e visualizações gráficas, otimizando a análise de dados regionais.

Tecnologias: NestJS, Next.js, Mongoose, Tailwind CSS, Docker, WebSockets e JWT para autenticação.

II. Criação do Sistema "Presença":
Liderei o desenvolvimento de uma solução completa para gestão de presença em eventos e criação de formulários, com integração ao Google Auth, garantindo segurança e praticidade para os usuários.

Tecnologias: Next.js, Next.j API, Shadcn/ui, Firebase (NoSQL) e Docker.

III. Implantação do Sistema NADA (Open Source):
Implantação e manutenção do NADA, um sistema de código aberto responsável por administrar as bases de dados das pesquisas do laboratório.

Tecnologias: Docker, PHP, MySQL e Apache.

IV. Gerenciamento de Infraestrutura de Servidor:
Participei ativamente da montagem e configuração de um servidor do zero, desde a instalação física até a gestão do deploy contínuo (CI/CD) das aplicações. Assegurando a disponibilidade dos sistemas e a proteção dos dados com um sistema RAID.

Ferramentas: Docker e GitHub Actions.

V. Gestão de Projetos e Liderança Técnica:
Atuação na linha de frente do planejamento de projetos, colaborando na definição de escopo, prazos, arquitetura de software e ferramentas, e adotando as melhores práticas da engenharia de software para garantir entregas de qualidade e alinhamento constante com a equipe.''',
            inicio: 'Desde de Junho de 2022 | 3 Ano · 5 Meses',
            fim: '',
            develop:
                'Competências: Gestão de projetos · Next.js · Docker · Integração e entrega contínuas (CI/CD) · MongoDB · Big data · API REST · Node.js · Git',
          ),
          SizedBox(height: 32),
          CompanyWidget(
            name: 'Datalise Tecnologia da Informação LTDA',
            logo: 'assets/experiences/datalise.svg',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvimento Mobile',
            subtitle:
                '''Atuei no desenvolvimento de uma aplicação Flutter para análise de performance de concessionárias. A solução incluía dashboards de KPIs, monitoramento de estoque, acompanhamento de vendas e um sistema de controle de acesso baseado em perfis de usuário.
  I. Arquitetura e Qualidade: Apliquei conceitos de Clean Architecture, Server-Driven UI e princípios SOLID para construir uma solução escalável, de alta performance e de fácil manutenção;
  II. Processos e Boas Práticas: Adotei rigoroso controle de versionamento e as melhores práticas da engenharia de software para otimizar o ciclo de desenvolvimento e garantir a integridade do código;
  III. Cultura e Colaboração: Promovi um ambiente colaborativo e de comunicação aberta, resultando em maior produtividade da equipe e na entrega de soluções mais robustas.''',
            inicio: 'Setembro de 2021',
            fim: '- Novembro  de 2023 | 2 anos e 4 meses',
            develop:
                'Competências: Flutter · Next.js · Server-Drive UI · Liderança · Arquitetura de software · Python · TypeScript',
          ),
          SizedBox(height: 32),
          ExperienceWidget(
            title: 'Desenvolvedor Full Stack',
            subtitle:
                'Atuei no desenvolvimento Full Stack em um Sistema Web para gestão financeira de concessionárias. Tendo em vista, o mapeamento adequado de contas de entradas e saídas, exportação de relatórios para as montadoras, manutenção de contas lançadas de forma errônea.',
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
                '''Atuei como desenvolvedor Full Stack de sistemas Desktop em Java, PostgresQL e Python. Fazendo uso da gestão de projetos (SCRUM e XP).
  I. Desenvolvi um sistema de controle de venda e estoque: "GERÊNCIA AMAZÔNIA" em Java Desktop Full State;
  II. Desenvolvi um sistema capaz de monitorar o nível diurético de pacientes na UTI.''',
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
