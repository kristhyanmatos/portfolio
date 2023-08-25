import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'carrossel_widget.dart';

class ProjectWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> urlsIcons;
  final String develop;
  final List<String> urlsImages;
  const ProjectWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.urlsIcons,
    required this.develop,
    required this.urlsImages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                ),
              ),
              Text(
                develop,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        CarrosselWidget(urlsImages: urlsImages)
      ],
    );
  }
}
