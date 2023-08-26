import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarrosselWidget extends StatelessWidget {
  final List<String> urlsImages;
  const CarrosselWidget({super.key, required this.urlsImages});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
      ),
      items: urlsImages.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SvgPicture.asset(item),
                );
              },
              child: SvgPicture.asset(item),
            );
          },
        );
      }).toList(),
    );
  }
}
