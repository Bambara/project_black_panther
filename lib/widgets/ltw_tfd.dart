import 'package:flutter/material.dart';
import 'package:project_black_panther/generated/assets.dart';

import '../models/tournament/t_fd.dart';
import 'image_button_widget.dart';

//TFD - Tournament Finance Details
class ListTileWidgetTFD extends StatelessWidget {
  final List<TFinanceDetails> tFD;
  final int index;
  final Function function;
  final Function(int index) removeItem;
  final VoidCallback navigate;

  const ListTileWidgetTFD({Key? key, required this.tFD, required this.index, required this.function, required this.removeItem, required this.navigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.003),
        child: Card(
          color: themeData.highlightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          elevation: 2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenHeight * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.centerLeft, child: SizedBox(child: Text('Type : ${tFD[index].type}'.toString(), style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize)))),
                const Divider(),
                Align(alignment: Alignment.centerLeft, child: Text('Bank : ${tFD[index].bank.toString()}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize))),
                Divider(endIndent: screenWidth * 0.2),
                Align(alignment: Alignment.centerLeft, child: Text('Branch : ${tFD[index].branch.toString()}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize))),
                Divider(endIndent: screenWidth * 0.2),
                Align(alignment: Alignment.centerLeft, child: Text('ACC Number : ${tFD[index].accountNumber.toString()}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize))),
                Divider(endIndent: screenWidth * 0.2),
                Align(alignment: Alignment.centerLeft, child: Text('Owner : ${tFD[index].accountHolder.toString()}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize))),
                Divider(endIndent: screenWidth * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Text('Branch : ${tFD[index].branch.toString()}', style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize))),
                    Row(
                      children: [
                        ImageButtonWidget(
                          imagePath: Assets.iconsCreate,
                          function: () => function,
                          isIcon: false,
                          iconData: Icons.adb,
                          iconSize: screenHeight * 0.04,
                          color: themeData.colorScheme.secondary,
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
