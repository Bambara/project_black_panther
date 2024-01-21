import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVGImageWidget extends StatelessWidget {
  const SVGImageWidget({
    Key? key,
    required this.path,
    required this.heightFactor,
    required this.widthFactor,
    required this.boarderRadius,
    required this.boarderStatus,
  }) : super(key: key);
  final String path;
  final double heightFactor;
  final double widthFactor;
  final double boarderRadius;
  final bool boarderStatus;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SvgPicture.asset(path, fit: BoxFit.scaleDown, height: screenWidth * heightFactor, width: screenWidth * widthFactor);
  }
}
