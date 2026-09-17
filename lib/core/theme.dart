import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta de fim de tarde na orla: céu roxo, sol dourado e luz de poste.
abstract final class Dusk {
  static const night = Color(0xFF120B18);
  static const plum = Color(0xFF231530);
  static const card = Color(0xFF1B1222);
  static const cream = Color(0xFFFFF3E3);
  static const sand = Color(0xFFE6CDB6);
  static const muted = Color(0xFFB39C93);
  static const amber = Color(0xFFFFB35C);
  static const gold = Color(0xFFFFD68A);
  static const coral = Color(0xFFF2785C);
  static const rose = Color(0xFFE0567A);
  static const line = Color(0x26FFD6A0);
}

abstract final class DuskType {
  /// Desligado nos testes, que não têm acesso à rede para baixar as fontes.
  static bool useGoogleFonts = true;

  /// Fira Code e Share Tech Mono são monoespacadas: avanço fixo e mais largo
  /// por glifo, e x-height bem maior que o das proporcionais que ocupavam
  /// esses papéis antes (Fraunces e Caveat). No mesmo fontSize elas renderizam
  /// visivelmente maiores e mais largas, então cada papel encolhe o tamanho
  /// pedido pelo call site para preservar a mancha de texto para a qual o
  /// layout já estava calibrado.
  static const _headingScale = 0.88;
  static const _terminalScale = 0.78;

  /// Títulos, em Fira Code — a monoespacada de editor de código.
  ///
  /// Sem o `letterSpacing` negativo que a versão em Fraunces usava: apertar
  /// glifos de avanço fixo desmancha justamente o alinhamento em colunas que
  /// dá o ar de código.
  static TextStyle heading({
    double size = 32,
    FontWeight weight = FontWeight.w600,
    Color color = Dusk.cream,
    double height = 1.15,
    List<Shadow>? shadows,
  }) {
    final style = TextStyle(
      fontSize: size * _headingScale,
      fontWeight: weight,
      color: color,
      height: height,
      shadows: shadows,
    );
    return useGoogleFonts ? GoogleFonts.firaCode(textStyle: style) : style;
  }

  /// A voz do site, em Share Tech Mono — terminal de filme.
  ///
  /// A fonte só publica o peso 400, então ele vai fixo: sem isso um ancestral
  /// em negrito jogaria o texto no negrito sintético do engine.
  static TextStyle terminal({double size = 26, Color color = Dusk.gold}) {
    final scaled = size * _terminalScale;
    final style = TextStyle(
      fontSize: scaled,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.3,
      letterSpacing: scaled * 0.02,
    );
    return useGoogleFonts ? GoogleFonts.shareTechMono(textStyle: style) : style;
  }

  /// Corpo de texto, em Nunito: a proporcional que segura a leitura longa.
  static TextStyle body({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color color = Dusk.sand,
    double height = 1.6,
    FontStyle? fontStyle,
    double? letterSpacing,
    List<Shadow>? shadows,
  }) {
    final style = TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      shadows: shadows,
    );
    return useGoogleFonts ? GoogleFonts.nunito(textStyle: style) : style;
  }
}

ThemeData buildDuskTheme() {
  final scheme =
      ColorScheme.fromSeed(
        seedColor: Dusk.amber,
        brightness: Brightness.dark,
      ).copyWith(
        primary: Dusk.amber,
        onPrimary: Dusk.night,
        secondary: Dusk.coral,
        surface: Dusk.card,
        onSurface: Dusk.cream,
      );
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Dusk.night,
    splashFactory: InkSparkle.splashFactory,
  );
  final textTheme = DuskType.useGoogleFonts
      ? GoogleFonts.nunitoTextTheme(base.textTheme)
      : base.textTheme;
  final buttonText = DuskType.body(size: 15.5, weight: FontWeight.w700);

  return base.copyWith(
    textTheme: textTheme.apply(bodyColor: Dusk.cream, displayColor: Dusk.cream),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Dusk.amber,
        foregroundColor: Dusk.night,
        textStyle: buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Dusk.cream,
        textStyle: buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        side: BorderSide(color: Dusk.cream.withValues(alpha: 0.4)),
        shape: const StadiumBorder(),
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Dusk.plum,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Dusk.line),
      ),
      textStyle: DuskType.body(size: 13, color: Dusk.cream, height: 1.2),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(Dusk.amber.withValues(alpha: 0.35)),
      radius: const Radius.circular(8),
    ),
  );
}
