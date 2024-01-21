import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../core/constants/constants.dart';
import 'icon_button_widget.dart';

class GTWProfile extends StatelessWidget {
  const GTWProfile({Key? key, required this.profileList, required this.index, required this.removeItem, required this.navigate}) : super(key: key);

  final List profileList;
  final int index;
  final Function(int) removeItem;
  final VoidCallback navigate;

  void get() {
    if (kDebugMode) {
      print('Call');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          elevation: 2,
          shadowColor: Theme.of(context).textTheme.bodyText1?.color,
          // color: Theme.of(context).primaryColorLight,
          child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
            Container(
              // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              decoration: BoxDecoration(
                  //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  color: themeData.canvasColor.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenWidth * 0.18,
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(children: [Text(storeMember[index].id, style: const TextStyle(fontSize: 12))]),
                    ],
                  ),*/
                  /*SizedBox(
                    height: screenWidth * 0.05,
                  ),*/
                  // const Divider(thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(profileList[index].name, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth * 0.03,
                  ),
                  //const Divider(endIndent: 100, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(profileList[index].product_code, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth * 0.03,
                  ),
                  //const Divider(endIndent: 100, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [Text('Qty : ${profileList[index].bar_code}', style: const TextStyle(fontSize: 14))]),
                      Row(
                        children: [
                          IconButtonWidget(
                            imagePath: 'assets/images/create.png',
                            function: () {
                              removeItem(index);
                            },
                            isIcon: true,
                            iconData: Icons.edit_note,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(50),
                          ),
                          IconButtonWidget(
                            imagePath: 'assets/images/delete_sweep.png',
                            function: () {
                              removeItem(index);
                            },
                            isIcon: true,
                            iconData: Icons.delete,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(50),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -(screenHeight * 0.05),
              left: screenHeight * 0.045,

              /*child: CircleAvatar(
                radius: screenHeight * 0.06,
                backgroundImage: const AssetImage('assets/images/dettol.jpg'),
                backgroundColor: Colors.grey.shade600,
                child: Text(
                  storeMember[index].status[0].toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),*/
              child: GFImageOverlay(
                borderRadius: BorderRadius.circular(screenWidth * Constants.boarderRadius),
                height: screenWidth * 0.3,
                width: screenWidth * 0.3,
                image: const AssetImage('assets/images/dettol.jpg'),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
