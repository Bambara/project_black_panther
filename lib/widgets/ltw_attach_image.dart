import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_black_panther/generated/assets.dart';
import 'package:project_black_panther/models/common/art_work.dart';

import 'icon_button_widget.dart';

///LTWAttacheImage - ListTileWidgetAttacheImage
class LTWAttacheImage extends StatelessWidget {
  final List<ArtWork> artWorks;
  final int index;
  final Function function;
  final Function(int index) removeItem;
  final VoidCallback navigate;

  const LTWAttacheImage({Key? key, required this.artWorks, required this.index, required this.function, required this.removeItem, required this.navigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.003, left: screenWidth * 0.02, right: screenWidth * 0.02),
      child: Card(
        color: themeData.highlightColor.withAlpha(200),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenHeight * 0.015),
        ),
        elevation: 2,
        child: Center(
          child: Stack(
            children: [
              artWorks[index].url.contains('http')
                  ? GFImageOverlay(
                      image: NetworkImage(artWorks[index].url),
                      height: screenHeight * 0.15,
                      width: screenHeight * 0.22,
                      shape: BoxShape.rectangle,
                      boxFit: BoxFit.cover,
                    )
                  : GFImageOverlay(
                      image: FileImage(File(artWorks[index].url)),
                      height: screenHeight * 0.17,
                      width: screenHeight * 0.23,
                      shape: BoxShape.rectangle,
                      boxFit: BoxFit.cover,
                    ),
              Positioned(
                top: -3,
                left: 140,
                child: IconButtonWidget(
                  imagePath: Assets.iconsDelete,
                  function: () {
                    removeItem(index);
                  },
                  isIcon: true,
                  iconData: FontAwesomeIcons.circleXmark,
                  iconSize: screenHeight * 0.04,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
