import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyWidget extends StatelessWidget {
  final String name;
  final String logo;
  final double height;
  const CompanyWidget({
    super.key,
    required this.name,
    required this.logo,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: SvgPicture.asset(logo, height: height),
          ),
        ),
      ],
    );
  }
}
