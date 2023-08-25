import 'package:flutter/material.dart';

class SkillWidget extends StatelessWidget {
  final String title;
  final List<String> list;
  const SkillWidget({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list
                .map((item) => Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
