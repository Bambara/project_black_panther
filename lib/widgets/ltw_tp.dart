import 'package:flutter/material.dart';
import 'package:project_black_panther/models/common/payment.dart';

import '../generated/assets.dart';
import 'image_button_widget.dart';

//LTWTP - Tournament Payment
///Tournament Payment List Tile Widget
class LTWTP extends StatelessWidget {
  final List<Payment> payments;
  final int index;
  final Function(int index) editItem;
  final Function(int index) removeItem;
  final VoidCallback navigate;

  const LTWTP({Key? key, required this.payments, required this.index, required this.editItem, required this.removeItem, required this.navigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.002, right: screenWidth * 0.002, left: screenHeight * 0.002),
        child: Card(
          color: themeData.highlightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          elevation: 0,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenHeight * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(child: Text('Trace : ${payments[index].trace}'.toString(), style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize)))),
                    Divider(endIndent: screenWidth * 0.19),
                    Align(alignment: Alignment.centerLeft, child: Text('Name : ${payments[index].payReason}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                    Divider(endIndent: screenWidth * 0.2),
                    Align(alignment: Alignment.centerLeft, child: Text('Amount : ${payments[index].payAmount}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                    Divider(endIndent: screenWidth * 0.17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(alignment: Alignment.centerLeft, child: Text('Status : ${payments[index].approveStatus}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                        Row(
                          children: [
                            /*ImageButtonWidget(
                              imagePath: Assets.iconsCreate,
                              function: () {
                                editItem(index);
                              },
                              isIcon: false,
                              iconData: Icons.adb,
                              iconSize: screenHeight * 0.03,
                              color: themeData.colorScheme.secondary,
                            ),*/
                            ImageButtonWidget(
                              imagePath: Assets.iconsDelete,
                              function: () {
                                removeItem(index);
                              },
                              isIcon: false,
                              iconData: Icons.adb,
                              iconSize: screenHeight * 0.03,
                              color: themeData.colorScheme.errorContainer,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              /*Positioned(
                top: screenHeight * 0.01,
                right: screenHeight * 0.01,
                child: payments[index].avatar.url == ''
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.055,
                        backgroundImage: const AssetImage(Assets.iconsUser),
                        backgroundColor: Colors.grey.shade600,
                        child: Text(
                          payments[index].name[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      )
                    : CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.055,
                        backgroundImage: NetworkImage(payments[index].avatar.url),
                        backgroundColor: Colors.grey.shade600,
                        // child: Text(
                        //   playerTeams[index].name[0].toUpperCase(),
                        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        // ),
                      ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
