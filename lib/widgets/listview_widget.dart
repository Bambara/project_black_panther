import 'package:flutter/material.dart';

import '../core/constants/constants.dart';
import 'image_button_widget.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key, required this.heightFactor, required this.widthFactor, required this.itemList, required this.removeItem}) : super(key: key);
  final num heightFactor;
  final num widthFactor;
  final List<String> itemList;
  final Function(int index) removeItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
      child: Container(
        height: screenHeight * heightFactor,
        width: screenWidth * widthFactor,
        color: themeData.colorScheme.secondary.withAlpha(25),
        /*decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
        ),*/
        child: ListView.builder(
          addAutomaticKeepAlives: false,
          cacheExtent: 10,
          // itemCount: itemList.length,
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
          itemCount: itemList.length,
          itemBuilder: (context, index) => ListItemWidget(
            itemList: itemList,
            index: index,
            removeItem: removeItem,
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({Key? key, required this.itemList, required this.index, required this.removeItem}) : super(key: key);
  final List<String> itemList;
  final int index;
  final Function(int index) removeItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(itemList.elementAt(index)),
          ImageButtonWidget(
            imagePath: '',
            function: () {
              removeItem(index);
            },
            iconData: Icons.remove_circle,
            isIcon: true,
            iconSize: screenHeight * 0.04,
            color: themeData.colorScheme.secondary,
          )
        ],
      ),
    );
  }
}
