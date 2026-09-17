import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetPicture extends StatelessWidget {
  const AssetPicture(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (asset.endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: width,
        height: height,
        fit: fit,
        semanticsLabel: semanticLabel,
      );
    }
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
      filterQuality: FilterQuality.medium,
    );
  }
}
