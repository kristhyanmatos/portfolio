import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Fim de tarde na orla: céu, sol se pondo no rio, praça com postes e uma
/// roda de amigos tocando violão.
///
/// [progress] vem da rolagem da página (0 = topo, 1 = fim) e faz o sol se
/// pôr, as estrelas aparecerem e os postes acenderem.
class SunsetScenePainter extends CustomPainter {
  SunsetScenePainter({required this.time, required this.progress})
    : super(repaint: Listenable.merge([time, progress]));

  final ValueListenable<double> time;
  final ValueListenable<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final p = progress.value.clamp(0.0, 1.0);
    final s = _Stage(size, time.value, _smoothstep(0, 0.85, p));

    _paintSky(canvas, s);
    _paintStars(canvas, s);
    _paintSun(canvas, s);
    _paintClouds(canvas, s);
    _paintBirds(canvas, s);
    _paintRiver(canvas, s);
    _paintFarShore(canvas, s);
    _paintBoat(canvas, s);
    _paintPlaza(canvas, s);
    for (final (i, x) in s.lamps.indexed) {
      _paintLamp(canvas, s, x, i);
    }
    _paintTree(canvas, s);
    _paintFriends(canvas, s);
    _paintFireflies(canvas, s);
    _paintVignette(canvas, s, p);
  }

  @override
  bool shouldRepaint(SunsetScenePainter oldDelegate) =>
      oldDelegate.time != time || oldDelegate.progress != progress;
}

class _Stage {
  _Stage(Size size, this.t, this.dusk)
    : w = size.width,
      h = size.height,
      compact = size.width < 720 {
    unit = (math.min(w, h * 1.5) / 1000).clamp(0.6, 1.3);
    horizon = h * (compact ? 0.66 : 0.64);
    shore = h * (compact ? 0.815 : 0.80);
    ground = h * 0.955;
    sunRadius = math.max(34.0, math.min(w, h) * 0.07);
    sun = Offset(
      w * (compact ? 0.66 : 0.72),
      horizon - sunRadius * 0.5 + dusk * sunRadius * 2.4,
    );
    silhouette = Color.lerp(
      const Color(0xFF24122A),
      const Color(0xFF09060C),
      dusk,
    )!;
    treeX = w * 0.02;
    // A roda fica na frente do reflexo do sol, para as silhuetas aparecerem.
    friendsX = w * (compact ? 0.72 : 0.80);
    lamps = compact ? [w * 0.44] : [w * 0.32, friendsX - 165 * unit, w * 0.97];
  }

  final double w;
  final double h;
  final double t;

  /// 0 = pôr do sol, 1 = começo da noite.
  final double dusk;
  final bool compact;
  late final double unit;
  late final double horizon;
  late final double shore;
  late final double ground;
  late final double sunRadius;
  late final Offset sun;
  late final Color silhouette;
  late final List<double> lamps;
  late final double treeX;
  late final double friendsX;
}

double _smoothstep(double edge0, double edge1, double x) {
  final t = ((x - edge0) / (edge1 - edge0)).clamp(0.0, 1.0);
  return t * t * (3 - 2 * t);
}

Color _mix(Color a, Color b, double t) => Color.lerp(a, b, t)!;

Paint _stroke(Color color, double width) => Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..strokeCap = StrokeCap.round
  ..strokeWidth = width;

// ---------------------------------------------------------------------------
// Céu
// ---------------------------------------------------------------------------

void _paintSky(Canvas canvas, _Stage s) {
  const sunset = [
    Color(0xFF2A1745),
    Color(0xFF6B3270),
    Color(0xFFD65F6B),
    Color(0xFFF49856),
    Color(0xFFFFD28A),
  ];
  const night = [
    Color(0xFF070716),
    Color(0xFF12122F),
    Color(0xFF2A1F4D),
    Color(0xFF55304F),
    Color(0xFF8A4550),
  ];
  final rect = Rect.fromLTWH(0, 0, s.w, s.horizon + 1);
  canvas.drawRect(
    rect,
    Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [for (var i = 0; i < 5; i++) _mix(sunset[i], night[i], s.dusk)],
        stops: const [0, 0.38, 0.66, 0.86, 1],
      ).createShader(rect),
  );
}

typedef _Star = ({double x, double y, double r, double phase, double speed});

final List<_Star> _stars = () {
  final rnd = math.Random(42);
  return List<_Star>.generate(
    120,
    (_) => (
      x: rnd.nextDouble(),
      y: math.pow(rnd.nextDouble(), 1.4).toDouble(),
      r: 0.5 + rnd.nextDouble() * 1.1,
      phase: rnd.nextDouble() * math.pi * 2,
      speed: 0.6 + rnd.nextDouble() * 1.8,
    ),
  );
}();

void _paintStars(Canvas canvas, _Stage s) {
  final paint = Paint();

  // A estrela d'alva aparece antes de todas.
  final venus = Offset(s.w * 0.56, s.horizon * 0.2);
  final venusAlpha = 0.45 + 0.55 * s.dusk;
  paint.color = const Color(0xFFFFF1D6).withValues(alpha: 0.12 * venusAlpha);
  canvas.drawCircle(venus, 6 * s.unit, paint);
  paint.color = const Color(0xFFFFF6E8).withValues(alpha: venusAlpha);
  canvas.drawCircle(venus, 1.9 * s.unit, paint);

  final visible = _smoothstep(0.12, 0.85, s.dusk);
  if (visible <= 0) return;
  for (final star in _stars) {
    final twinkle = 0.5 + 0.5 * math.sin(s.t * star.speed + star.phase);
    final alpha = visible * (0.4 + 0.6 * twinkle) * (1 - star.y * 0.65);
    paint.color = const Color(0xFFFFF6E8).withValues(alpha: alpha);
    canvas.drawCircle(
      Offset(star.x * s.w, star.y * s.horizon * 0.82),
      star.r,
      paint,
    );
  }
}

void _paintSun(Canvas canvas, _Stage s) {
  final sky = Rect.fromLTWH(0, 0, s.w, s.horizon);
  final fade = 1 - s.dusk;
  final glowCenter = Offset(s.sun.dx, math.min(s.sun.dy, s.horizon));
  final glowRadius = s.sunRadius * 7;
  canvas.drawRect(
    sky,
    Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFCB7A).withValues(alpha: 0.55 * fade),
          const Color(0xFFFF9A5A).withValues(alpha: 0.2 * fade),
          const Color(0x00FF9A5A),
        ],
        stops: const [0, 0.35, 1],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius)),
  );

  canvas.save();
  canvas.clipRect(sky);
  final disc = Rect.fromCircle(center: s.sun, radius: s.sunRadius);
  canvas.drawCircle(
    s.sun,
    s.sunRadius,
    Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFF6D6), Color(0xFFFFD88A), Color(0xFFFFA55A)],
        stops: [0, 0.55, 1],
      ).createShader(disc),
  );
  canvas.restore();
}

typedef _Puff = ({double dx, double dy, double rx, double ry});
typedef _Cloud = ({
  double x,
  double y,
  double width,
  double speed,
  List<_Puff> puffs,
});

final List<_Cloud> _clouds = () {
  final rnd = math.Random(7);
  const heights = [0.16, 0.3, 0.44, 0.56, 0.24];
  return [
    for (final y in heights)
      (
        x: rnd.nextDouble(),
        y: y,
        width: 180 + rnd.nextDouble() * 220,
        speed: 3 + rnd.nextDouble() * 6,
        puffs: [
          for (var i = 0; i < 5; i++)
            (
              dx: i / 4,
              dy: rnd.nextDouble() * 2 - 1,
              rx: 0.35 + rnd.nextDouble() * 0.35,
              ry: 0.6 + rnd.nextDouble() * 0.5,
            ),
        ],
      ),
  ];
}();

void _paintClouds(Canvas canvas, _Stage s) {
  for (final cloud in _clouds) {
    final cw = cloud.width * s.unit;
    final span = s.w + cw * 2;
    final x = (cloud.x * span + s.t * cloud.speed) % span - cw;
    final y = cloud.y * s.horizon;
    final path = Path();
    for (final puff in cloud.puffs) {
      path.addOval(
        Rect.fromCenter(
          center: Offset(x + puff.dx * cw, y + puff.dy * cw * 0.05),
          width: puff.rx * cw,
          height: puff.ry * cw * 0.2,
        ),
      );
    }
    final bounds = path.getBounds();
    canvas.drawPath(
      path,
      Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 7 * s.unit)
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _mix(const Color(0x66B0607A), const Color(0x40302545), s.dusk),
            _mix(const Color(0xA6FFC48F), const Color(0x4D6A3D5C), s.dusk),
          ],
        ).createShader(bounds),
    );
  }
}

void _paintBirds(Canvas canvas, _Stage s) {
  const period = 46.0;
  const flock = [(0.0, 0.0), (-26.0, 12.0), (-44.0, -8.0), (-60.0, 20.0)];
  final progress = (s.t % period) / period;
  final baseX = -0.1 * s.w + progress * 1.3 * s.w;
  final baseY =
      s.horizon * 0.32 + math.sin(progress * math.pi * 2) * 18 * s.unit;
  final paint = _stroke(
    const Color(0xFF2A1733).withValues(alpha: 0.75 * (1 - s.dusk * 0.7)),
    1.7 * s.unit,
  );
  for (final (i, (dx, dy)) in flock.indexed) {
    final x = baseX + dx * s.unit;
    final y = baseY + dy * s.unit;
    final size = (8 - i * 0.8) * s.unit;
    final flap = 0.3 + 0.7 * math.sin(s.t * 7 + i * 1.3);
    final path = Path()
      ..moveTo(x - size, y - size * 0.35 * flap)
      ..quadraticBezierTo(x - size * 0.45, y - size * 0.6 * flap, x, y)
      ..quadraticBezierTo(
        x + size * 0.45,
        y - size * 0.6 * flap,
        x + size,
        y - size * 0.35 * flap,
      );
    canvas.drawPath(path, paint);
  }
}

// ---------------------------------------------------------------------------
// Rio
// ---------------------------------------------------------------------------

typedef _Glint = ({double row, double x, double len, double phase});

final List<_Glint> _glints = () {
  final rnd = math.Random(3);
  return List<_Glint>.generate(
    56,
    (_) => (
      row: math.pow(rnd.nextDouble(), 1.3).toDouble(),
      x: rnd.nextDouble(),
      len: rnd.nextDouble(),
      phase: rnd.nextDouble() * math.pi * 2,
    ),
  );
}();

void _paintRiver(Canvas canvas, _Stage s) {
  final river = Rect.fromLTRB(0, s.horizon, s.w, s.shore);
  canvas.drawRect(
    river,
    Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _mix(const Color(0xFFE88A63), const Color(0xFF5A2D4B), s.dusk),
          _mix(const Color(0xFFA04E66), const Color(0xFF24173A), s.dusk),
          _mix(const Color(0xFF43233F), const Color(0xFF0B0913), s.dusk),
        ],
        stops: const [0, 0.45, 1],
      ).createShader(river),
  );

  canvas.save();
  canvas.clipRect(river);
  final depth = s.shore - s.horizon;
  final strength = 1 - s.dusk * 0.8;

  // Reflexo do sol.
  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(s.sun.dx, s.horizon + depth * 0.2),
      width: s.sunRadius * 3.2,
      height: depth * 0.7,
    ),
    Paint()
      ..color = const Color(0xFFFFD28A).withValues(alpha: 0.2 * strength)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 22 * s.unit),
  );
  for (final glint in _glints) {
    final y = s.horizon + 3 + glint.row * (depth - 6);
    final spread = s.sunRadius * (0.35 + glint.row * 2.6);
    final x =
        s.sun.dx +
        (glint.x * 2 - 1) * spread +
        math.sin(s.t * 0.9 + glint.phase) * 5 * s.unit;
    final len = (8 + glint.len * 36) * s.unit * (0.5 + glint.row);
    final shimmer =
        0.5 + 0.5 * math.sin(s.t * (1.4 + glint.len) + glint.phase * 3);
    final alpha = strength * (0.2 + 0.8 * shimmer) * (1 - glint.row * 0.55);
    canvas.drawLine(
      Offset(x - len / 2, y),
      Offset(x + len / 2, y),
      _stroke(
        const Color(0xFFFFE2A6).withValues(alpha: alpha),
        (1 + glint.row * 2) * s.unit,
      ),
    );
  }

  // Ondinhas atravessando o rio.
  for (final (i, glint) in _glints.take(18).indexed) {
    final span = s.w + 240;
    final x = (glint.x * span + s.t * (6 + glint.len * 10)) % span - 120;
    final y = s.horizon + 6 + ((i * 0.37) % 1) * (depth - 10);
    final len = (30 + glint.len * 90) * s.unit;
    canvas.drawLine(
      Offset(x, y),
      Offset(x + len, y),
      _stroke(
        const Color(0xFFFFF3E3).withValues(alpha: 0.07 * (1 - s.dusk * 0.4)),
        1.1 * s.unit,
      ),
    );
  }
  canvas.restore();
}

void _paintFarShore(Canvas canvas, _Stage s) {
  final path = Path()..moveTo(0, s.horizon + 1);
  for (double x = 0; x <= s.w + 8; x += 8) {
    final bump =
        (math.sin(x * 0.011) + 1) * 3.5 +
        (math.sin(x * 0.037 + 1.7) + 1) * 2.2 +
        (math.sin(x * 0.093 + 0.4) + 1) * 1.1;
    path.lineTo(x, s.horizon - bump * s.unit - 2);
  }
  path
    ..lineTo(s.w + 8, s.horizon + 1)
    ..close();
  canvas.drawPath(
    path,
    Paint()
      ..color = _mix(const Color(0xFF6A3456), const Color(0xFF140E22), s.dusk),
  );

  // Casinhas na outra margem acendendo as luzes.
  final lights = _smoothstep(0.25, 0.9, s.dusk);
  if (lights <= 0) return;
  const spots = [0.04, 0.11, 0.19, 0.27, 0.41, 0.48, 0.77, 0.86, 0.93];
  for (final (i, spot) in spots.indexed) {
    final x = spot * s.w;
    final alpha = lights * (0.7 + 0.3 * math.sin(s.t * 1.3 + i));
    final color = const Color(0xFFFFD28A).withValues(alpha: alpha);
    canvas.drawCircle(
      Offset(x, s.horizon - 2.5 * s.unit),
      1.3 * s.unit,
      Paint()..color = color,
    );
    canvas.drawLine(
      Offset(x, s.horizon + 3 * s.unit),
      Offset(x, s.horizon + 14 * s.unit),
      _stroke(color.withValues(alpha: alpha * 0.35), 1.2 * s.unit),
    );
  }
}

void _paintBoat(Canvas canvas, _Stage s) {
  const period = 110.0;
  final u = s.unit * 0.8;
  final x = (-0.15 + (s.t % period) / period * 1.3) * s.w;
  final y =
      s.horizon + (s.shore - s.horizon) * 0.34 + math.sin(s.t * 1.4) * 1.5 * u;
  final color = _mix(const Color(0xFF2A1428), const Color(0xFF0B0710), s.dusk);
  final paint = Paint()..color = color;

  // Rastro na água.
  for (var i = 1; i <= 3; i++) {
    canvas.drawLine(
      Offset(x - (40 + i * 16) * u, y + (2 + i * 2) * u),
      Offset(x - (28 + i * 10) * u, y + (2 + i * 2) * u),
      _stroke(
        const Color(0xFFFFE2A6)
            .withValues(alpha: 0.18 * (1 - s.dusk * 0.6) / i),
        1.2 * u,
      ),
    );
  }

  final hull = Path()
    ..moveTo(x - 40 * u, y - 5 * u)
    ..lineTo(x + 44 * u, y - 7 * u)
    ..quadraticBezierTo(x + 30 * u, y + 5 * u, x, y + 5 * u)
    ..quadraticBezierTo(x - 30 * u, y + 5 * u, x - 40 * u, y - 5 * u)
    ..close();
  canvas.drawPath(hull, paint);

  // Pescador de chapéu de palha.
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(x + 13 * u, y - 23 * u, 10 * u, 18 * u),
      Radius.circular(4 * u),
    ),
    paint,
  );
  canvas.drawCircle(Offset(x + 18 * u, y - 28 * u), 4.6 * u, paint);
  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(x + 18 * u, y - 31 * u),
      width: 17 * u,
      height: 3.6 * u,
    ),
    paint,
  );
  canvas.drawLine(
    Offset(x + 8 * u, y - 26 * u),
    Offset(x - 14 * u, y + 9 * u),
    _stroke(color, 1.6 * u),
  );
}

// ---------------------------------------------------------------------------
// Praça
// ---------------------------------------------------------------------------

void _paintPlaza(Canvas canvas, _Stage s) {
  final u = s.unit;

  final ground = Rect.fromLTRB(0, s.shore + 5 * u, s.w, s.h);
  canvas.drawRect(
    ground,
    Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _mix(const Color(0xFF3A1E35), const Color(0xFF150C18), s.dusk),
          _mix(const Color(0xFF1A0E1D), const Color(0xFF070509), s.dusk),
        ],
      ).createShader(ground),
  );

  // Calçadão com ondas, como nas orlas do Pará.
  final wave = _stroke(
    const Color(0xFFFFF3E3).withValues(alpha: 0.045),
    1.3 * u,
  );
  final gap = (s.h - s.shore) / 5.2;
  for (var k = 0; k < 4; k++) {
    final baseY = s.shore + 5 * u + (k + 1) * gap;
    final path = Path()..moveTo(0, baseY);
    for (double x = 0; x <= s.w + 10; x += 10) {
      path.lineTo(x, baseY + math.sin(x * 0.018 + k * 1.3) * 4 * u);
    }
    canvas.drawPath(path, wave);
  }

  // Mureta e guarda-corpo.
  canvas.drawRect(
    Rect.fromLTRB(0, s.shore - 4 * u, s.w, s.shore + 5 * u),
    Paint()
      ..color = _mix(const Color(0xFF3B2034), const Color(0xFF110A14), s.dusk),
  );
  canvas.drawLine(
    Offset(0, s.shore - 4 * u),
    Offset(s.w, s.shore - 4 * u),
    Paint()
      ..color = const Color(0xFFFFD28A).withValues(alpha: 0.3 * (1 - s.dusk))
      ..strokeWidth = 1.2 * u,
  );
  final top = s.shore - 30 * u;
  final railing = Path()
    ..addRect(Rect.fromLTWH(0, top - 2 * u, s.w, 3.5 * u))
    ..addRect(Rect.fromLTWH(0, top + 12 * u, s.w, 1.6 * u));
  for (double x = 6; x < s.w; x += 20 * u) {
    railing.addRect(Rect.fromLTWH(x, top, 2.2 * u, s.shore - 4 * u - top));
  }
  canvas.drawPath(
    railing,
    Paint()
      ..color = _mix(const Color(0xFF2E1830), const Color(0xFF0B070E), s.dusk),
  );
}

void _paintLamp(Canvas canvas, _Stage s, double x, int i) {
  final u = s.unit;
  final base = s.ground + 6 * u;
  final top = base - 200 * u;
  final on =
      (0.35 + 0.65 * _smoothstep(0.08, 0.55, s.dusk)) *
      (0.95 + 0.05 * math.sin(s.t * 7.3 + i * 2.1));

  final pool = Rect.fromCenter(
    center: Offset(x, base - 2 * u),
    width: 240 * u,
    height: 48 * u,
  );
  canvas.drawOval(
    pool,
    Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFC36B).withValues(alpha: 0.3 * on),
          const Color(0x00FFC36B),
        ],
      ).createShader(pool),
  );

  final light = Offset(x, top + 14 * u);
  final halo = Rect.fromCircle(center: light, radius: 120 * u);
  canvas.drawCircle(
    light,
    120 * u,
    Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFC46E).withValues(alpha: 0.55 * on),
          const Color(0xFFFF9F5A).withValues(alpha: 0.12 * on),
          const Color(0x00FF9F5A),
        ],
        stops: const [0, 0.3, 1],
      ).createShader(halo),
  );

  final glass = Path()
    ..moveTo(x - 11 * u, top + 2 * u)
    ..lineTo(x + 11 * u, top + 2 * u)
    ..lineTo(x + 7 * u, top + 28 * u)
    ..lineTo(x - 7 * u, top + 28 * u)
    ..close();
  canvas.drawPath(
    glass,
    Paint()..color = _mix(const Color(0xFF6B4A3A), const Color(0xFFFFE6AA), on),
  );

  final post = Path()
    ..addRect(
      Rect.fromCenter(
        center: Offset(x, base - 9 * u),
        width: 16 * u,
        height: 18 * u,
      ),
    )
    ..addRect(
      Rect.fromLTRB(x - 2.6 * u, top + 28 * u, x + 2.6 * u, base - 18 * u),
    )
    ..addRect(
      Rect.fromCenter(
        center: Offset(x, top + 30 * u),
        width: 14 * u,
        height: 4 * u,
      ),
    )
    ..moveTo(x - 14 * u, top + 3 * u)
    ..lineTo(x, top - 10 * u)
    ..lineTo(x + 14 * u, top + 3 * u)
    ..close();
  canvas.drawPath(post, Paint()..color = s.silhouette);
}

typedef _Leaf = ({double dx, double dy, double r});

final List<_Leaf> _canopy = () {
  final rnd = math.Random(19);
  return <_Leaf>[
    (dx: 0, dy: 0, r: 95),
    (dx: -90, dy: 20, r: 70),
    (dx: 80, dy: 15, r: 75),
    (dx: -40, dy: -55, r: 70),
    (dx: 45, dy: -60, r: 68),
    (dx: -150, dy: 45, r: 48),
    (dx: 150, dy: 45, r: 50),
    (dx: 0, dy: 50, r: 70),
    for (var i = 0; i < 24; i++)
      () {
        final angle = i / 24 * math.pi * 2 + rnd.nextDouble() * 0.2;
        return (
          dx: math.cos(angle) * 170,
          dy: math.sin(angle) * 90 + (math.sin(angle) > 0 ? -20 : 0),
          r: 22 + rnd.nextDouble() * 16,
        );
      }(),
  ];
}();

/// Mangueira no canto esquerdo da praça, com a copa voltada para o centro.
void _paintTree(Canvas canvas, _Stage s) {
  // Menor que o original para a copa não cobrir o texto do topo.
  const scale = 0.72;
  final base = s.ground + 10 * s.unit;
  canvas.save();
  canvas.translate(s.treeX, base);
  canvas.scale(-scale, scale);
  canvas.translate(0, -base);
  _paintTreeShape(canvas, s);
  canvas.restore();
}

/// Desenha a árvore com o tronco em x = 0 e a copa pendendo para a esquerda.
void _paintTreeShape(Canvas canvas, _Stage s) {
  final u = s.unit;
  const x = 0.0;
  final base = s.ground + 10 * u;
  final trunkTop = base - 175 * u;
  final paint = Paint()..color = s.silhouette;

  final trunk = Path()
    ..moveTo(x - 16 * u, base)
    ..quadraticBezierTo(x - 8 * u, base - 80 * u, x - 9 * u, trunkTop)
    ..lineTo(x + 7 * u, trunkTop)
    ..quadraticBezierTo(x + 6 * u, base - 80 * u, x + 18 * u, base)
    ..close()
    ..moveTo(x - 6 * u, trunkTop + 40 * u)
    ..quadraticBezierTo(
      x - 40 * u,
      trunkTop + 10 * u,
      x - 72 * u,
      trunkTop - 12 * u,
    )
    ..lineTo(x - 66 * u, trunkTop - 18 * u)
    ..quadraticBezierTo(x - 36 * u, trunkTop, x - 2 * u, trunkTop + 26 * u)
    ..close();
  canvas.drawPath(trunk, paint);

  final sway = math.sin(s.t * 0.5) * 2 * u;
  final center = Offset(x - 30 * u + sway, trunkTop - 50 * u);
  final canopy = Path();
  for (final leaf in _canopy) {
    canopy.addOval(
      Rect.fromCircle(
        center: center + Offset(leaf.dx * u, leaf.dy * u),
        radius: leaf.r * u,
      ),
    );
  }
  canvas.drawPath(canopy, paint);
}

// ---------------------------------------------------------------------------
// A roda de violão
// ---------------------------------------------------------------------------

void _paintFriends(Canvas canvas, _Stage s) {
  final u = s.unit;
  final gx = s.friendsX;
  final ground = s.ground;
  final seatY = ground - 36 * u;
  final sil = s.silhouette;
  final body = Paint()..color = sil;

  // Banco da praça.
  final bench = Path()
    ..addRect(
      Rect.fromLTRB(gx - 78 * u, seatY - 3 * u, gx + 70 * u, seatY + 4 * u),
    )
    ..addRect(
      Rect.fromLTRB(gx - 78 * u, seatY - 32 * u, gx + 70 * u, seatY - 26 * u),
    )
    ..addRect(
      Rect.fromLTRB(gx - 78 * u, seatY - 21 * u, gx + 70 * u, seatY - 16 * u),
    )
    ..addRect(Rect.fromLTRB(gx - 71 * u, seatY - 32 * u, gx - 67 * u, seatY))
    ..addRect(Rect.fromLTRB(gx + 59 * u, seatY - 32 * u, gx + 63 * u, seatY))
    ..addRect(Rect.fromLTRB(gx - 72 * u, seatY + 4 * u, gx - 66 * u, ground))
    ..addRect(Rect.fromLTRB(gx + 58 * u, seatY + 4 * u, gx + 64 * u, ground));
  canvas.drawPath(
    bench,
    Paint()..color = _mix(sil, const Color(0xFF5A3444), 0.28),
  );

  _paintDog(canvas, s, Offset(gx - 102 * u, ground));
  final soundHole = _paintGuitarist(canvas, s, gx - 36 * u, seatY, body);
  _paintListener(canvas, s, gx + 28 * u, seatY, body);
  _paintPercussionist(canvas, s, gx + 112 * u, ground, body);
  _paintNotes(canvas, s, soundHole);
}

void _limb(Canvas canvas, Color color, double width, List<Offset> points) {
  final path = Path()..moveTo(points.first.dx, points.first.dy);
  for (final point in points.skip(1)) {
    path.lineTo(point.dx, point.dy);
  }
  canvas.drawPath(path, _stroke(color, width)..strokeJoin = StrokeJoin.round);
}

void _torso(Canvas canvas, Offset hips, double angle, double u, Paint paint) {
  canvas.save();
  canvas.translate(hips.dx, hips.dy);
  canvas.rotate(angle);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(-12 * u, -48 * u, 24 * u, 50 * u),
      Radius.circular(10 * u),
    ),
    paint,
  );
  canvas.restore();
}

/// Retorna a boca do violão, de onde saem as notas.
Offset _paintGuitarist(
  Canvas canvas,
  _Stage s,
  double px,
  double seatY,
  Paint body,
) {
  final u = s.unit;
  final sil = body.color;
  final bob = math.sin(s.t * 2.4) * 1.3 * u;
  final strum = math.sin(s.t * 9) * 3 * u;

  _limb(canvas, sil, 12 * u, [
    Offset(px + 2 * u, seatY - 4 * u),
    Offset(px + 26 * u, seatY - 6 * u),
  ]);
  _limb(canvas, sil, 9.5 * u, [
    Offset(px + 26 * u, seatY - 6 * u),
    Offset(px + 30 * u, s.ground - 3 * u),
  ]);
  _limb(canvas, sil, 5 * u, [
    Offset(px + 30 * u, s.ground - 2 * u),
    Offset(px + 38 * u, s.ground - 2 * u),
  ]);
  _torso(canvas, Offset(px, seatY), -0.1, u, body);
  _limb(canvas, sil, 7 * u, [
    Offset(px + 1 * u, seatY - 44 * u),
    Offset(px + 4 * u, seatY - 54 * u + bob),
  ]);
  canvas.drawCircle(Offset(px + 5 * u, seatY - 60 * u + bob), 10.5 * u, body);

  // Braço que faz os acordes.
  _limb(canvas, sil, 6 * u, [
    Offset(px - 2 * u, seatY - 40 * u),
    Offset(px - 16 * u, seatY - 18 * u),
    Offset(px - 27 * u, seatY - 30 * u),
  ]);

  // Violão.
  final center = Offset(px + 16 * u, seatY - 14 * u);
  final wood = _mix(sil, const Color(0xFF7A4530), 0.5 * (1 - s.dusk * 0.6));
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(0.4);
  final guitar = Path()
    ..addOval(Rect.fromCircle(center: Offset(8 * u, 0), radius: 12.5 * u))
    ..addOval(Rect.fromCircle(center: Offset(-9 * u, 0), radius: 9.5 * u))
    ..addRect(Rect.fromLTRB(-9 * u, -7 * u, 8 * u, 7 * u));
  final neck = Path()
    ..addRect(Rect.fromLTRB(-60 * u, -2.2 * u, -16 * u, 2.2 * u))
    ..addRect(Rect.fromLTRB(-70 * u, -3.4 * u, -60 * u, 3.4 * u));
  canvas.drawPath(neck, Paint()..color = _mix(sil, wood, 0.35));
  canvas.drawPath(guitar, Paint()..color = wood);
  canvas.drawPath(
    guitar,
    _stroke(
      const Color(0xFFFFD28A).withValues(alpha: 0.28 * (1 - s.dusk)),
      1.2 * u,
    ),
  );
  canvas.drawCircle(Offset(-1 * u, 0), 3.6 * u, Paint()..color = sil);
  canvas.restore();

  // Braço que dedilha.
  _limb(canvas, sil, 6 * u, [
    Offset(px + 6 * u, seatY - 40 * u),
    Offset(px + 22 * u, seatY - 26 * u),
    Offset(px + 17 * u, seatY - 13 * u + strum),
  ]);

  return center + Offset(-1 * u, -4 * u);
}

void _paintListener(
  Canvas canvas,
  _Stage s,
  double px,
  double seatY,
  Paint body,
) {
  final u = s.unit;
  final sil = body.color;
  final sway = math.sin(s.t * 2.4 + 0.8) * 2.2 * u;
  final sip = math.max(0.0, math.sin(s.t * 0.35)) * 6 * u;

  _limb(canvas, sil, 12 * u, [
    Offset(px + 2 * u, seatY - 4 * u),
    Offset(px + 22 * u, seatY - 2 * u),
  ]);
  _limb(canvas, sil, 9.5 * u, [
    Offset(px + 22 * u, seatY - 2 * u),
    Offset(px + 28 * u, s.ground - 3 * u),
  ]);
  _limb(canvas, sil, 12 * u, [
    Offset(px + 2 * u, seatY - 6 * u),
    Offset(px + 24 * u, seatY - 11 * u),
  ]);
  _limb(canvas, sil, 9.5 * u, [
    Offset(px + 24 * u, seatY - 11 * u),
    Offset(px + 14 * u, s.ground - 12 * u),
  ]);
  _torso(canvas, Offset(px, seatY), 0.08, u, body);

  // Braço apoiado no encosto do banco.
  _limb(canvas, sil, 6 * u, [
    Offset(px + 6 * u, seatY - 40 * u),
    Offset(px + 40 * u, seatY - 31 * u),
  ]);

  // Cabelo comprido e cabeça acompanhando o ritmo.
  final head = Offset(px + 3 * u + sway, seatY - 60 * u);
  canvas.drawOval(
    Rect.fromCenter(
      center: head + Offset(-1 * u, 9 * u),
      width: 25 * u,
      height: 34 * u,
    ),
    body,
  );
  canvas.drawCircle(head, 10.5 * u, body);

  // Mão com o copo.
  final hand = Offset(px - 4 * u, seatY - 24 * u - sip);
  _limb(canvas, sil, 6 * u, [
    Offset(px - 6 * u, seatY - 40 * u),
    Offset(px - 12 * u, seatY - 20 * u),
    hand,
  ]);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: hand + Offset(2 * u, -5 * u),
        width: 6 * u,
        height: 9 * u,
      ),
      Radius.circular(1.5 * u),
    ),
    body,
  );
}

void _paintPercussionist(
  Canvas canvas,
  _Stage s,
  double cx,
  double ground,
  Paint body,
) {
  final u = s.unit;
  final sil = body.color;
  final hit = math.max(0.0, math.sin(s.t * 6));
  final seat = ground - 26 * u;

  // Isopor servindo de banquinho.
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - 17 * u, ground - 24 * u, 34 * u, 24 * u),
      Radius.circular(2 * u),
    ),
    Paint()..color = _mix(sil, const Color(0xFF5A3444), 0.28),
  );

  _limb(canvas, sil, 12 * u, [
    Offset(cx - 2 * u, seat - 3 * u),
    Offset(cx - 24 * u, seat - 5 * u),
  ]);
  _limb(canvas, sil, 9.5 * u, [
    Offset(cx - 24 * u, seat - 5 * u),
    Offset(cx - 28 * u, ground - 3 * u),
  ]);
  _limb(canvas, sil, 5 * u, [
    Offset(cx - 28 * u, ground - 2 * u),
    Offset(cx - 36 * u, ground - 2 * u),
  ]);
  _torso(canvas, Offset(cx, seat), -0.12, u, body);

  // Cabeça de boné.
  final head = Offset(cx - 7 * u, seat - 60 * u);
  canvas.drawCircle(head, 10.5 * u, body);
  canvas.drawArc(
    Rect.fromCircle(center: head + Offset(0, -1 * u), radius: 11.5 * u),
    math.pi,
    math.pi,
    true,
    body,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(head.dx - 22 * u, head.dy - 4 * u, 14 * u, 3.5 * u),
      Radius.circular(1.5 * u),
    ),
    body,
  );

  // Pandeiro.
  final pandeiro = Offset(cx - 28 * u, seat - 40 * u - hit * 1.5 * u);
  _limb(canvas, sil, 6 * u, [
    Offset(cx - 10 * u, seat - 42 * u),
    Offset(cx - 18 * u, seat - 28 * u),
    pandeiro + Offset(6 * u, 8 * u),
  ]);
  canvas.drawCircle(
    pandeiro,
    11 * u,
    Paint()
      ..color = _mix(sil, const Color(0xFF8A5A3C), 0.3 * (1 - s.dusk * 0.5)),
  );
  canvas.drawCircle(pandeiro, 11 * u, _stroke(sil, 3.2 * u));
  _limb(canvas, sil, 6 * u, [
    Offset(cx - 2 * u, seat - 40 * u),
    Offset(cx - 8 * u, seat - 22 * u),
    Offset(cx - 22 * u + hit * 3 * u, seat - 36 * u - hit * 8 * u),
  ]);
}

void _paintDog(Canvas canvas, _Stage s, Offset feet) {
  final u = s.unit;
  final paint = Paint()..color = s.silhouette;
  final wag = math.sin(s.t * 8) * 4 * u;
  canvas.drawOval(
    Rect.fromCenter(
      center: feet + Offset(0, -7 * u),
      width: 36 * u,
      height: 13 * u,
    ),
    paint,
  );
  canvas.drawCircle(feet + Offset(-18 * u, -13 * u), 6.5 * u, paint);
  canvas.drawOval(
    Rect.fromCenter(
      center: feet + Offset(-25 * u, -11 * u),
      width: 8 * u,
      height: 4.5 * u,
    ),
    paint,
  );
  final ear = Path()
    ..moveTo(feet.dx - 20 * u, feet.dy - 18 * u)
    ..lineTo(feet.dx - 14 * u, feet.dy - 25 * u)
    ..lineTo(feet.dx - 13 * u, feet.dy - 16 * u)
    ..close();
  canvas.drawPath(ear, paint);
  canvas.drawRect(
    Rect.fromLTWH(feet.dx - 24 * u, feet.dy - 4 * u, 14 * u, 3.5 * u),
    paint,
  );
  _limb(canvas, s.silhouette, 3 * u, [
    feet + Offset(16 * u, -9 * u),
    feet + Offset(28 * u, -14 * u + wag),
  ]);
}

void _paintNotes(Canvas canvas, _Stage s, Offset origin) {
  const count = 5;
  const period = 5.0;
  final u = s.unit;
  for (var i = 0; i < count; i++) {
    final progress = ((s.t + i * period / count) % period) / period;
    final alpha = math.sin(progress * math.pi) * 0.9;
    if (alpha <= 0.01) continue;
    final position =
        origin +
        Offset(
          progress * 70 * u + math.sin(progress * 6 + i) * 10 * u,
          -20 * u - progress * 130 * u,
        );
    final scale = u * (0.8 + progress * 0.5);
    final color = const Color(0xFFFFE2A8).withValues(alpha: alpha);
    final paint = Paint()..color = color;

    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(math.sin(s.t * 2 + i) * 0.2);
    void head(double dx) {
      canvas.save();
      canvas.translate(dx * scale, 0);
      canvas.rotate(-0.35);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: 9 * scale,
          height: 6.5 * scale,
        ),
        paint,
      );
      canvas.restore();
    }

    final stem = _stroke(color, 1.6 * scale)..strokeCap = StrokeCap.butt;
    if (i.isEven) {
      head(0);
      canvas.drawLine(
        Offset(4 * scale, -1 * scale),
        Offset(4 * scale, -20 * scale),
        stem,
      );
      final flag = Path()
        ..moveTo(4 * scale, -20 * scale)
        ..quadraticBezierTo(12 * scale, -15 * scale, 9 * scale, -7 * scale);
      canvas.drawPath(flag, stem);
    } else {
      head(0);
      head(13);
      canvas.drawLine(
        Offset(4 * scale, -1 * scale),
        Offset(4 * scale, -19 * scale),
        stem,
      );
      canvas.drawLine(
        Offset(17 * scale, -1 * scale),
        Offset(17 * scale, -22 * scale),
        stem,
      );
      canvas.drawLine(
        Offset(4 * scale, -19 * scale),
        Offset(17 * scale, -22 * scale),
        _stroke(color, 3.4 * scale)..strokeCap = StrokeCap.butt,
      );
    }
    canvas.restore();
  }
}

typedef _Firefly = ({double x, double y, double phase, double speed});

final List<_Firefly> _fireflies = () {
  final rnd = math.Random(5);
  return List<_Firefly>.generate(
    18,
    (_) => (
      x: rnd.nextDouble(),
      y: rnd.nextDouble(),
      phase: rnd.nextDouble() * math.pi * 2,
      speed: 0.6 + rnd.nextDouble() * 0.8,
    ),
  );
}();

void _paintFireflies(Canvas canvas, _Stage s) {
  final visible = 0.25 + 0.75 * s.dusk;
  final paint = Paint();
  for (final fly in _fireflies) {
    final x =
        fly.x * s.w + math.sin(s.t * 0.3 * fly.speed + fly.phase) * 30 * s.unit;
    final y =
        s.shore -
        60 * s.unit +
        fly.y * (s.h - s.shore) +
        math.cos(s.t * 0.4 * fly.speed + fly.phase * 2) * 16 * s.unit;
    final glow = math
        .pow(0.5 + 0.5 * math.sin(s.t * 1.7 * fly.speed + fly.phase), 3)
        .toDouble();
    final alpha = visible * glow;
    if (alpha < 0.02) continue;
    paint.color = const Color(0xFFFFE7A0).withValues(alpha: 0.14 * alpha);
    canvas.drawCircle(Offset(x, y), 6 * s.unit, paint);
    paint.color = const Color(0xFFFFF1C2).withValues(alpha: 0.95 * alpha);
    canvas.drawCircle(Offset(x, y), 1.6 * s.unit, paint);
  }
}

void _paintVignette(Canvas canvas, _Stage s, double progress) {
  final rect = Rect.fromLTWH(0, 0, s.w, s.h);
  canvas.drawRect(
    rect,
    Paint()
      ..shader = const RadialGradient(
        center: Alignment(0, -0.2),
        radius: 1.15,
        colors: [Color(0x00000000), Color(0x59000000)],
        stops: [0.55, 1],
      ).createShader(rect),
  );

  // Escurece enquanto o conteúdo passa por cima e clareia de novo no rodapé,
  // para a roda de violão aparecer à noite.
  final scrim =
      0.5 *
      _smoothstep(0.02, 0.16, progress) *
      (1 - _smoothstep(0.9, 1, progress));
  if (scrim > 0) {
    canvas.drawRect(
      rect,
      Paint()..color = const Color(0xFF0D0812).withValues(alpha: scrim),
    );
  }
}
