import 'dart:math';

import 'package:flutter/material.dart';

import 'hexagono_widget.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: ClipPath(
        clipper: HexagonClipper(pi / 2),
        child: Image.network(
          'https://avatars.githubusercontent.com/u/44785539?v=4',
        ),
      ),
    );
  }
}
