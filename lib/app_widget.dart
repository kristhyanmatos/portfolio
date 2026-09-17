import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'portfolio_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kristhyan de Matos Maia',
      debugShowCheckedModeBanner: false,
      theme: buildDuskTheme(),
      home: const PortfolioPage(),
    );
  }
}
