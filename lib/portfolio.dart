import 'package:flutter/material.dart';

import 'layouts/mobile_layout.dart';
import 'layouts/web_layout.dart';
import 'widgets/backgound_widget.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgoundWidget(
        child: getChild(context),
      ),
    );
  }

  Widget getChild(BuildContext context) {
    if (MediaQuery.of(context).size.width > 480) {
      return const WebLayout();
    } else {
      return const MobileLayout();
    }
  }
}
