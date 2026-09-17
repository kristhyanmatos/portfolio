import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'sunset_scene_painter.dart';

/// Cenário fixo atrás da página, animado em ~30 fps.
class SunsetScene extends StatefulWidget {
  const SunsetScene({super.key, required this.progress});

  final ValueListenable<double> progress;

  @override
  State<SunsetScene> createState() => _SunsetSceneState();
}

class _SunsetSceneState extends State<SunsetScene>
    with SingleTickerProviderStateMixin {
  static const _frameInterval = Duration(milliseconds: 33);

  /// Instante usado quando o usuário pede menos movimento.
  static const _stillTime = 12.0;

  final _time = ValueNotifier<double>(_stillTime);
  late final Ticker _ticker = createTicker(_onTick);
  Duration _lastFrame = Duration.zero;

  void _onTick(Duration elapsed) {
    if (elapsed - _lastFrame < _frameInterval) return;
    _lastFrame = elapsed;
    _time.value =
        _stillTime + elapsed.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion && _ticker.isActive) {
      _ticker.stop();
    } else if (!reduceMotion && !_ticker.isActive) {
      _lastFrame = Duration.zero;
      _ticker.start();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: SunsetScenePainter(time: _time, progress: widget.progress),
          ),
          // Granulado de filme por cima de tudo.
          Image.asset(
            'assets/noise.png',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.05),
            excludeFromSemantics: true,
          ),
        ],
      ),
    );
  }
}
