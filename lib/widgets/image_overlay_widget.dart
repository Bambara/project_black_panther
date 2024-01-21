import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class ImageOverlayWidget extends StatelessWidget {
  const ImageOverlayWidget({Key? key, required this.title, required this.provider, required this.heightFactor, required this.widthFactor, required this.boarderRadius, required this.boarderStatus})
      : super(key: key);
  final ImageProvider provider;
  final String title;
  final double heightFactor;
  final double widthFactor;
  final double boarderRadius;
  final bool boarderStatus;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GFImageOverlay(
      // image: const AssetImage('assets/images/company_logo.jpg'),
      image: provider,
      width: screenWidth * widthFactor,
      height: screenWidth * heightFactor,
      borderRadius: BorderRadius.circular(screenWidth * boarderRadius),
      boxFit: BoxFit.scaleDown,
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.darken),
      border: boarderStatus == true ? Border.all(width: 0.7) : const Border.symmetric(vertical: BorderSide.none, horizontal: BorderSide.none),
      child: provider.isBlank == false ? const Center() : Center(child: Text(title)),
    );
  }
}
