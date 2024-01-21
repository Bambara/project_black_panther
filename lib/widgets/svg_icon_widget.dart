import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SVGIconWidget extends StatelessWidget {
  const SVGIconWidget({
    Key? key,
    required this.path,
    required this.sizeFactor,
  }) : super(key: key);
  final String path;

  // final double heightFactor;
  final double sizeFactor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Image(image: Svg(path, size: Size(screenWidth * sizeFactor, screenWidth * sizeFactor)));
  }
}
