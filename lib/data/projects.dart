import 'package:flutter/material.dart';

import 'models.dart';

const _lacam = 'Lacam · Unifesspa';

const projects = <Project>[
  Project(
    name: 'TacTov',
    year: '2026',
    description: 'A plataforma definitiva para quem joga e organiza Airsoft no Brasil. Organize qualquer tipo de evento de Airsoft ou participe deles, com ranking por agente, equipes e organizadores, criação de equipes com patentes e descrição, pagamentos automatizados, gerenciamento de múltiplos eventos, campeonatos, mensagens, grupos de mensagens, perfil de conquistas e muito mais. Disponível na web e no mobile, para Android e iOS.',
    stack: ['Flutter', 'Next.js', 'Golang', 'PostgreSQL'],
    categories: {ProjectCategory.web, ProjectCategory.mobile},
    cover: ScreenshotCover('assets/projects/tactov.jpeg', domain: 'tactov.com'),
    links: [ProjectLink('Acessar', 'https://www.tactov.com/')],
  ),
  Project(
    name: 'Plataforma SEP',
    year: '2026',
    description: 'Plataforma de gerenciamento da Sociedade Brasileira de Economia Política: página institucional, atas, anuidades e pagamentos automatizados, além de tudo que é preciso para organizar eventos acadêmicos — minicursos, chamadas, submissões, anais, presenças e geração de certificados.',
    stack: ['Next.js', 'Golang', 'PostgreSQL'],
    categories: {ProjectCategory.web},
    cover: PosterCover(
      icon: Icons.account_balance_outlined,
      caption: 'da chamada ao certificado',
      logo: 'assets/projects/sep_logo.png',
    ),
    links: [ProjectLink('Acessar', 'https://www.sep.org.br/')],
  ),
  Project(
    name: 'Presença',
    year: '2023',
    context: _lacam,
    description: 'Sistema que auxilia na gestão de pessoas e eventos: presença por QR Code, justificativa de ausência, relatórios periódicos, indicadores do seu perfil, escala de ocupação e cadastro de colaboradores.',
    stack: ['Next.js', 'Golang', 'PostgreSQL'],
    categories: {ProjectCategory.web},
    cover: ScreenshotCover(
      'assets/projects/presenca.jpeg',
      domain: 'apps-lacam.unifesspa.edu.br/presenca',
    ),
    links: [
      ProjectLink('Acessar', 'https://apps-lacam.unifesspa.edu.br/presenca'),
    ],
  ),
  Project(
    name: 'Dashboard de Notas Fiscais e Bioeconomia',
    year: '2025',
    context: _lacam,
    description: 'Reunindo dados fiscais agregados da SEFA/PA, esta base apresenta estimativas sobre o abastecimento e as vendas nos municípios paraenses, incluindo os produtos da bioeconomia. O conteúdo apoia gestores, empresas e pesquisadores na compreensão do cenário econômico do estado, oferecendo uma leitura mais clara sobre a dinâmica comercial regional.',
    stack: ['Next.js', 'Golang', 'Recharts'],
    categories: {ProjectCategory.web, ProjectCategory.dados},
    cover: ScreenshotCover(
      'assets/projects/nf_dashboard.jpeg',
      domain: 'apps-lacam.unifesspa.edu.br/nf-dashboard',
    ),
    links: [
      ProjectLink(
        'Acessar',
        'https://apps-lacam.unifesspa.edu.br/nf-dashboard/inicio/',
      ),
    ],
  ),
  Project(
    name: 'FNF — Filtro de Notas Fiscais TRU',
    year: '2023',
    context: _lacam,
    description: 'Filtro de Notas Fiscais da TRU (Tabela de Recursos e Usos): plataforma de consulta aos dados de notas fiscais do estado do Pará tratados por economistas, com bases de mais de 100 milhões de linhas.',
    stack: ['Next.js', 'NestJS', 'MongoDB'],
    categories: {ProjectCategory.web, ProjectCategory.dados},
    cover: ScreenshotCover(
      'assets/projects/fnf.jpeg',
      domain: 'apps-lacam.unifesspa.edu.br/fnf',
    ),
    links: [ProjectLink('Acessar', 'https://apps-lacam.unifesspa.edu.br/fnf')],
  ),
  Project(
    name: 'VIII SEDRES',
    year: '2026',
    description: 'Site do Seminário de Desenvolvimento Regional, Estado e Sociedade, com cronograma, programação, sessões temáticas, notícias, inscrições, resultados de trabalhos, exposição fotográfica, turismo e hospedagem, transportes e mapas.',
    stack: ['Vite', 'React', 'TypeScript'],
    categories: {ProjectCategory.web},
    cover: ScreenshotCover(
      'assets/projects/sedres.jpeg',
      domain: 'viiisedres.org',
    ),
    links: [ProjectLink('Acessar', 'https://www.viiisedres.org/')],
  ),
  Project(
    name: 'Servidor do Lacam',
    context: _lacam,
    description: 'Instalação de um servidor físico, configuração de softwares, manutenção e controle dos serviços que rodam nele. O servidor estava desligado e completamente zerado: sem cabos, nobreak, rack, acesso à internet ou software. Foi configurado do zero e hoje mantém no ar os sistemas do laboratório.',
    stack: ['Docker', 'GitHub Actions', 'RAID'],
    categories: {ProjectCategory.infra},
    cover: ScreenshotCover(
      'assets/projects/servidor_lacam.jpeg',
      domain: 'apps-lacam.unifesspa.edu.br',
    ),
    links: [ProjectLink('Acessar', 'https://apps-lacam.unifesspa.edu.br')],
  ),
  Project(
    name: 'N.A.D.A — National Data Archive',
    context: _lacam,
    description: 'Instalação, no servidor do Lacam, do National Data Archive, um catálogo de dados de código aberto. Com ele é possível publicar, pesquisar e divulgar dados de pesquisa com metadados estruturados — solução usada por institutos de estatística, organizações internacionais e arquivos de pesquisa.',
    stack: ['Docker', 'PHP', 'MySQL', 'Apache'],
    categories: {ProjectCategory.infra, ProjectCategory.dados},
    cover: PosterCover(
      icon: Icons.inventory_2_outlined,
      caption: 'catálogo de dados de pesquisa',
    ),
    links: [
      ProjectLink(
        'Acessar',
        'https://apps-lacam.unifesspa.edu.br/nada/index.php',
      ),
      ProjectLink('Sobre o NADA', 'https://nada.ihsn.org/'),
    ],
  ),
  Project(
    name: 'Meu casamento',
    year: '2026',
    description: 'Site convite do meu casamento, feito com muito amor e dedicação juntamente com a minha esposa.',
    stack: ['Vite', 'TypeScript'],
    categories: {ProjectCategory.web},
    cover: ScreenshotCover(
      'assets/projects/casamento.jpeg',
      domain: 'nathalya.kristhyan.com',
    ),
    links: [ProjectLink('Acessar', 'https://nathalya.kristhyan.com/')],
  ),
  Project(
    name: 'Datalise App',
    context: 'Datalise',
    description: 'App mobile para a centralização e exibição de dados do estado atual nos grupos de concessionárias de forma mais legível e organizada, em formato de dashboard. Permite exportar relatórios em PDF, receber notificações sobre metas e métricas, acompanhar o ranking geral e específico dos funcionários cadastrados e conta com um sistema de indicadores. Desenvolvido com Dart/Flutter e Python, através das boas práticas de gestão de código e de processos.',
    stack: ['Flutter', 'Firebase', 'Node.js', 'Python', 'PostgreSQL', 'AWS'],
    categories: {ProjectCategory.mobile},
    cover: PhonesCover([
      'assets/projects/datalise_1.svg',
      'assets/projects/datalise_2.svg',
      'assets/projects/datalise_3.svg',
    ]),
    links: [
      ProjectLink(
        'Android',
        'https://play.google.com/store/apps/details?id=com.sisifo.pandora_dash',
        kind: LinkKind.android,
      ),
      ProjectLink(
        'iOS',
        'https://apps.apple.com/br/app/datalise-app/id1607909858',
        kind: LinkKind.ios,
      ),
    ],
  ),
  Project(
    name: 'Leva Almondes',
    description: 'App que conecta clientes com trabalhadores autônomos que prestam serviços com fretes e mudanças. Desenvolvido com Flutter e os microsserviços do Firebase (Functions, Messaging, Cloud Firestore e Cloud Storage), utilizando Clean Architecture, Clean Code e as boas práticas de criação e manutenção do código.',
    stack: ['Flutter', 'Firebase', 'Node.js'],
    categories: {ProjectCategory.mobile},
    cover: PhonesCover([
      'assets/projects/leva_almondes_1.svg',
      'assets/projects/leva_almondes_2.svg',
      'assets/projects/leva_almondes_3.svg',
    ]),
    links: [
      ProjectLink(
        'Android',
        'https://play.google.com/store/apps/details?id=br.kris.leva_almondes',
        kind: LinkKind.android,
      ),
    ],
  ),
  Project(
    name: 'Namoral',
    description: 'Um protótipo unindo IA com Flutter. Namoral é o app que vai te ajudar nas indecisões da sua vida.',
    stack: ['Flutter', 'OpenAI'],
    categories: {ProjectCategory.mobile},
    cover: PhonesCover([
      'assets/projects/namoral_1.svg',
      'assets/projects/namoral_2.svg',
      'assets/projects/namoral_3.svg',
    ]),
    links: [
      ProjectLink(
        'GitHub',
        'https://github.com/kristhyanmatos/namoral',
        kind: LinkKind.github,
      ),
    ],
  ),
];
