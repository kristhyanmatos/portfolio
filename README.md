# portfolio

Meu portfólio, em Flutter Web: **[www.kristhyan.com](https://www.kristhyan.com)**

A página inteira é um fim de tarde na orla. O sol se põe conforme você rola, as estrelas aparecem, os postes acendem — e a roda de violão continua tocando no canto.

## Stack

Flutter 3.47 / Dart 3.13, sem backend. Três dependências:

| pacote | por quê |
|---|---|
| `google_fonts` | carrega as fontes; aqui só resolve os arquivos que já estão em `assets/fonts/` |
| `flutter_svg` | os poucos logos que são vetor de verdade |
| `url_launcher` | abrir links externos em nova aba |

Sem gerenciador de estado: a página toda é `ValueNotifier` + `ValueListenableBuilder`. Para um site de uma tela só, qualquer coisa além disso seria cerimônia.

## Estrutura

```text
lib/
  data/       conteúdo: perfil, experiências, projetos + formatação de datas
  core/       tema, paleta, tipografia, breakpoint
  scene/      o pôr do sol — um CustomPainter de ~1100 linhas
  sections/   hero, sobre, experiências, projetos, habilidades, formação, rodapé
  widgets/    navbar, cards, carrossel, diálogo de preview
```

Conteúdo mora em `lib/data/` como constantes Dart. Sem CMS, sem JSON, sem fetch: o compilador me avisa se eu quebrar algo, e não existe estado de carregamento para desenhar.

## Decisões

**O cenário é desenhado, não é imagem.** `sunset_scene_painter.dart` pinta céu, rio, praça, postes, árvore, pássaros, vaga-lumes e a roda de amigos com `Canvas`. Anima a 30 fps e recebe o progresso da rolagem, que move o sol e acende as luzes. Como é código e não bitmap, ele se adapta a qualquer proporção de tela sem esticar nada. Respeita `prefers-reduced-motion`: com movimento reduzido, congela num instante fixo.

**Um breakpoint só, em 720px.** `context.isCompact` decide entre a navbar com menu e a navbar com seções, e entre colunas ou empilhado. Dois layouts cobrem tudo; três seriam três para manter.

**Nada é buscado de terceiros.** As fontes (Fira Code nos títulos, Share Tech Mono na "voz" do site, Nunito no corpo) ficam em `assets/fonts/`, reduzidas ao alfabeto latino — 706 KB viram 285 KB. `allowRuntimeFetching` é `false`, então uma variante usada em código sem o arquivo correspondente quebra o teste em vez de virar um download silencioso em produção. O build também serve o renderer e a foto do próprio domínio.

**Screenshots em WebP.** As capas de projeto eram SVGs de ~1 MB cada — na verdade PNGs enormes em base64 dentro de um wrapper XML. Em WebP redimensionado, `assets/` caiu de 7,4 MB para menos de 1 MB, e o `flutter_svg` deixou de ter que parsear megabytes de XML em runtime.

**SEO num canvas.** Flutter Web desenha tudo em canvas, então nenhum texto existe no DOM e um crawler não tem o que ler. `web/index.html` carrega os metadados (Open Graph, Twitter card, JSON-LD `Person`) e um bloco com o conteúdo real — invisível na tela, presente no DOM, e que vira uma página legível quando o JavaScript está desligado.

## Rodando

```sh
flutter pub get
flutter run -d chrome
flutter test
```

Os testes cobrem a aritmética de datas das experiências e renderizam a página inteira em desktop e celular, conferindo que todo asset referenciado existe de fato.

## Build e deploy

```sh
flutter build web --release --wasm --no-web-resources-cdn
```

- `--wasm` compila para WasmGC, bem mais rápido que o JavaScript equivalente. O build também gera `main.dart.js`, usado automaticamente em navegadores sem suporte.
- `--no-web-resources-cdn` serve o renderer (~1,5 MB) e a fonte de fallback do próprio domínio, em vez de buscá-los em `gstatic.com`.

Hospedado na Vercel, publicando `build/web`.
