import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_black_panther/generated/assets.dart';
import 'package:project_black_panther/models/common/art_work.dart';

import 'image_button_widget.dart';

//TFD - Tournament Finance Details
class ListTileWidgetArtWork extends StatelessWidget {
  final List<ArtWork> artWorks;
  final int index;
  final Function function;
  final Function(int index) removeItem;
  final VoidCallback navigate;

  const ListTileWidgetArtWork({Key? key, required this.artWorks, required this.index, required this.function, required this.removeItem, required this.navigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.008, left: screenWidth * 0.038, right: screenWidth * 0.038),
        child: Card(
          color: themeData.highlightColor.withAlpha(200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          elevation: 2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenHeight * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: artWorks[index].url.contains('http')
                              ? GFImageOverlay(
                                  image: NetworkImage(artWorks[index].url),
                                  height: screenHeight * 0.09,
                                  width: screenHeight * 0.15,
                                  shape: BoxShape.rectangle,
                                  boxFit: BoxFit.cover,
                                )
                              : GFImageOverlay(
                                  image: FileImage(File(artWorks[index].url)),
                                  height: screenHeight * 0.09,
                                  width: screenHeight * 0.15,
                                  shape: BoxShape.rectangle,
                                  boxFit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(width: screenHeight * 0.01),
                        Text('Type : ${artWorks[index].name.split('_')[1]}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize)),
                      ],
                    ),
                    ImageButtonWidget(
                      imagePath: Assets.iconsDelete,
                      function: () {
                        removeItem(index);
                      },
                      isIcon: false,
                      iconData: Icons.adb,
                      iconSize: screenHeight * 0.04,
                      color: themeData.colorScheme.secondary,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
