import 'package:flutter/material.dart';

class ExperienceWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String inicio;
  final String fim;
  final String develop;
  const ExperienceWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.inicio,
    required this.fim,
    required this.develop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
        Text(
          '$inicio $fim',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
        Text(
          develop,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
