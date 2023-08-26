import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Engenheiro da Computação',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Bacharelado',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '2022',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Universidade do Sul e Sudeste do Pará - UNIFESSPA',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 60,
          width: 120,
          child: SvgPicture.asset('assets/unifesspa.svg'),
        ),
      ],
    );
  }
}
