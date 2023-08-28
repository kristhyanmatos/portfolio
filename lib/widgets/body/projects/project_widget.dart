// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:js' as js;
import 'carrossel_widget.dart';

class Tag {
  final String name;
  final String link;

  Tag(this.name, this.link);
}

class ProjectWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> urlsIcons;
  final String develop;
  final List<String> urlsImages;
  final List<Tag> tags;
  const ProjectWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.urlsIcons,
    required this.develop,
    required this.urlsImages,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) => ActionChip.elevated(
              visualDensity: VisualDensity.compact,
              label: Text(tags[index].name),
              onPressed: () => js.context.callMethod(
                'open',
                [tags[index].link],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        CarrosselWidget(urlsImages: urlsImages),
        SizedBox(
          height: 60,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: urlsIcons.length,
            itemBuilder: (context, index) => SvgPicture.asset(
              urlsIcons[index],
              height: 30,
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
        Text(
          develop,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
