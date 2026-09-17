abstract final class Profile {
  static const name = 'Kristhyan de Matos Maia';
  static const headline =
      'Engenheiro da Computação · Full Stack, Mobile e Infraestrutura';
  static const tagline =
      'Do servidor físico ao app na mão do usuário: construo, lidero e mantenho software que as pessoas usam de verdade.';
  static const avatar = 'assets/avatar.webp';
  static const site = 'https://www.kristhyan.com';
  static const about =
      'Formado em Engenharia da Computação pela Universidade Federal do Sul e Sudeste do Pará [UNIFESSPA], tenho me dedicado a produzir softwares de alto desempenho, mantendo um ambiente de trabalho saudável e valorizando a manutenção do código. Busco constantemente implementar metodologias, conceitos, estruturas e arquiteturas que contribuam para o sucesso dos projetos. Além disso, acredito que estabelecer responsabilidades, respeito e metas claras é fundamental para o crescimento profissional e empresarial.';

  static const github = 'https://github.com/kristhyanmatos';
  static const linkedin =
      'https://www.linkedin.com/in/kristhyan-de-matos-maia/';
  static const whatsapp = 'https://api.whatsapp.com/send?phone=5591985398664';
  static const repository = 'https://github.com/kristhyanmatos/portfolio';
}

const competencias = [
  'Liderança',
  'Flexibilidade',
  'Colaboração',
  'Gestão de projetos',
  'Resolução de problemas',
];

const ferramentas = [
  'Flutter / Dart',
  'Golang',
  'TypeScript',
  'Next.js',
  'NestJS',
  'Kotlin',
  'Python',
  'PostgreSQL',
  'MongoDB',
  'Docker',
  'Clean Architecture',
  'Clean Code',
  'SOLID',
  'Versionamento de código',
];

const idiomas = [
  (idioma: 'Português', nivel: 'Avançado'),
  (idioma: 'Inglês', nivel: 'Intermediário'),
];

abstract final class Formacao {
  static const curso = 'Engenharia da Computação';
  static const grau = 'Bacharelado';
  static const conclusao = 2022;
  static const instituicao =
      'Universidade Federal do Sul e Sudeste do Pará — UNIFESSPA';
  static const logo = 'assets/unifesspa.webp';
}
