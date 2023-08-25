import 'package:flutter/material.dart';

import '../widgets/about/about_widget.dart';
import '../widgets/body/body_widget.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: const AboutWidget(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: const BodyWidget(),
        ),
      ],
    );
  }
}
