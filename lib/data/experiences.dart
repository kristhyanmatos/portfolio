import 'models.dart';

final companies = <Company>[
  Company(
    name: 'Mobato',
    shortName: 'Mobato',
    roles: [
      Role(
        title: 'Desenvolvedor de Aplicativos',
        start: DateTime(2023, 12),
        summary: 'Responsável por desenvolver novas funcionalidades e realizar manutenções contínuas do aplicativo Mobato (Kotlin e Java), com foco em criar uma experiência de usuário nativa, robusta e de alta performance.',
        highlights: const [
          Highlight(
            'Otimizando continuamente o código e a arquitetura da aplicação para garantir máxima performance e estabilidade, impactando diretamente na qualidade do produto final.',
          ),
          Highlight(
            'Gerenciando todo o ciclo de vida das entregas com Git, controlando o versionamento e a implantação do código através dos ambientes de desenvolvimento, homologação e produção.',
          ),
          Highlight(
            'Colaborando em um ambiente de desenvolvimento ágil, participando ativamente do planejamento e execução de sprints para manter um fluxo de trabalho dinâmico e alinhado aos objetivos estratégicos do negócio.',
          ),
        ],
        skills: const [
          'Kotlin',
          'Java',
          'Clean Code',
          'Boa comunicação',
          'Resolução de problemas',
        ],
      ),
    ],
  ),
  Company(
    name: 'Laboratório de Contas Regionais da Amazônia [Lacam]',
    shortName: 'Lacam',
    detail: 'Universidade Federal do Sul e Sudeste do Pará [UNIFESSPA]',
    roles: [
      Role(
        title: 'Líder Técnico',
        start: DateTime(2022, 6),
        highlights: const [
          Highlight(
            'Liderei o desenvolvimento de uma aplicação robusta para filtrar e analisar um grande volume de dados, tratando bases com mais de 100 milhões de linhas em MongoDB. O sistema permite a geração de relatórios em CSV e visualizações gráficas, otimizando a análise de dados regionais.',
            title: 'Desenvolvimento Full-Stack do Sistema de Filtro de Notas Fiscais (NF-e) do Pará',
            tech: 'NestJS, Next.js, Mongoose, Tailwind CSS, Docker, WebSockets e JWT para autenticação.',
          ),
          Highlight(
            'Liderei o desenvolvimento de uma solução completa para gestão de presença em eventos e criação de formulários, com integração ao Google Auth, garantindo segurança e praticidade para os usuários.',
            title: 'Criação do Sistema "Presença"',
            tech: 'Next.js, Next.js API, Shadcn/ui, Firebase (NoSQL) e Docker.',
          ),
          Highlight(
            'Implantação e manutenção do NADA, um sistema de código aberto responsável por administrar as bases de dados das pesquisas do laboratório.',
            title: 'Implantação do Sistema NADA (Open Source)',
            tech: 'Docker, PHP, MySQL e Apache.',
          ),
          Highlight(
            'Participei ativamente da montagem e configuração de um servidor do zero, desde a instalação física até a gestão do deploy contínuo (CI/CD) das aplicações. Assegurando a disponibilidade dos sistemas e a proteção dos dados com um sistema RAID.',
            title: 'Gerenciamento de Infraestrutura de Servidor',
            tech: 'Docker e GitHub Actions.',
          ),
          Highlight(
            'Atuação na linha de frente do planejamento de projetos, colaborando na definição de escopo, prazos, arquitetura de software e ferramentas, e adotando as melhores práticas da engenharia de software para garantir entregas de qualidade e alinhamento constante com a equipe.',
            title: 'Gestão de Projetos e Liderança Técnica',
          ),
        ],
        skills: const [
          'Gestão de projetos',
          'Next.js',
          'Docker',
          'Integração e entrega contínuas (CI/CD)',
          'MongoDB',
          'Big data',
          'API REST',
          'Node.js',
          'Git',
        ],
      ),
    ],
  ),
  Company(
    name: 'Datalise Tecnologia da Informação LTDA',
    shortName: 'Datalise',
    logo: 'assets/experiences/datalise.svg',
    roles: [
      Role(
        title: 'Desenvolvimento Mobile',
        start: DateTime(2021, 9),
        end: DateTime(2023, 11),
        summary: 'Atuei no desenvolvimento de uma aplicação Flutter para análise de performance de concessionárias. A solução incluía dashboards de KPIs, monitoramento de estoque, acompanhamento de vendas e um sistema de controle de acesso baseado em perfis de usuário.',
        highlights: const [
          Highlight(
            'Apliquei conceitos de Clean Architecture, Server-Driven UI e princípios SOLID para construir uma solução escalável, de alta performance e de fácil manutenção.',
            title: 'Arquitetura e Qualidade',
          ),
          Highlight(
            'Adotei rigoroso controle de versionamento e as melhores práticas da engenharia de software para otimizar o ciclo de desenvolvimento e garantir a integridade do código.',
            title: 'Processos e Boas Práticas',
          ),
          Highlight(
            'Promovi um ambiente colaborativo e de comunicação aberta, resultando em maior produtividade da equipe e na entrega de soluções mais robustas.',
            title: 'Cultura e Colaboração',
          ),
        ],
        skills: const [
          'Flutter',
          'Next.js',
          'Server-Driven UI',
          'Liderança',
          'Arquitetura de software',
          'Python',
          'TypeScript',
        ],
      ),
      Role(
        title: 'Desenvolvedor Full Stack',
        start: DateTime(2020, 8),
        end: DateTime(2021, 8),
        summary: 'Atuei no desenvolvimento Full Stack de um sistema web para gestão financeira de concessionárias, visando o mapeamento adequado de contas de entradas e saídas, a exportação de relatórios para as montadoras e a manutenção de contas lançadas de forma errônea.',
        skills: const [
          'SOLID',
          'Clean Code',
          'PostgreSQL',
          'Python',
          'Vue',
          'TypeScript',
        ],
      ),
    ],
  ),
  Company(
    name: 'Bits Jr - Soluções em TI',
    shortName: 'Bits Jr',
    logo: 'assets/experiences/logo-bitsjr.svg',
    logoHeight: 34,
    roles: [
      Role(
        title: 'Desenvolvedor de Softwares Full Stack',
        start: DateTime(2019, 3),
        end: DateTime(2020, 7),
        summary: 'Atuei como desenvolvedor Full Stack de sistemas Desktop em Java, PostgreSQL e Python, fazendo uso da gestão de projetos (SCRUM e XP).',
        highlights: const [
          Highlight(
            'Desenvolvi um sistema de controle de venda e estoque: "GERÊNCIA AMAZÔNIA" em Java Desktop Full State.',
          ),
          Highlight(
            'Desenvolvi um sistema capaz de monitorar o nível diurético de pacientes na UTI.',
          ),
        ],
        skills: const [
          'Scrum',
          'XP',
          'Raspberry Pi',
          'PostgreSQL',
          'SQLite',
          'Dashboards',
          'Python',
          'Java',
        ],
      ),
    ],
  ),
];

/// Início da primeira experiência profissional.
DateTime get careerStart => companies
    .expand((company) => company.roles)
    .map((role) => role.start)
    .reduce((a, b) => a.isBefore(b) ? a : b);

List<Company> get currentCompanies => companies
    .where((company) => company.roles.any((role) => role.isCurrent))
    .toList();
