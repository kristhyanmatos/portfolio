import 'dart:math';

import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  final double rotation; // Ângulo de rotação em radianos

  HexagonClipper(this.rotation);

  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = width / 2;

    const double angle = 2 * pi / 6;

    final List<Offset> points = List.generate(6, (index) {
      final double rotatedAngle = angle * index + rotation;
      final double x = centerX + radius * cos(rotatedAngle);
      final double y = centerY + radius * sin(rotatedAngle);
      return Offset(x, y);
    });

    final path = Path()..addPolygon(points, true);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
