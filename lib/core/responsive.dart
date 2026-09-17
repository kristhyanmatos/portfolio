import 'package:flutter/widgets.dart';

extension Responsive on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Celulares e janelas estreitas.
  bool get isCompact => screenWidth < 720;
}
