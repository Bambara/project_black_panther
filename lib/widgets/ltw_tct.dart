import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../models/tournament/tc_team.dart';
import 'image_button_widget.dart';

//TCTeam - Tournament Coordinate Teams
///Tournament Coordinate Teams List Tile Widget
class LTWTCTeam extends StatelessWidget {
  final List<TCTeam> tcTeams;
  final int index;
  final Function(int index) editItem;
  final Function(int index) removeItem;
  final VoidCallback navigate;

  const LTWTCTeam({Key? key, required this.tcTeams, required this.index, required this.editItem, required this.removeItem, required this.navigate}) : super(key: key);

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
                        child: SizedBox(child: Text('Code : ${tcTeams[index].code}'.toString(), style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize)))),
                    Divider(endIndent: screenWidth * 0.19),
                    Align(alignment: Alignment.centerLeft, child: Text('Name : ${tcTeams[index].name}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                    Divider(endIndent: screenWidth * 0.2),
                    Align(alignment: Alignment.centerLeft, child: Text('Role : ${tcTeams[index].role}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                    Divider(endIndent: screenWidth * 0.17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(alignment: Alignment.centerLeft, child: Text('Status : ${tcTeams[index].status}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize))),
                        Row(
                          children: [
                            ImageButtonWidget(
                              imagePath: Assets.iconsCreate,
                              function: () => editItem(index),
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
              Positioned(
                top: screenHeight * 0.01,
                right: screenHeight * 0.01,
                child: tcTeams[index].avatar.url == ''
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.055,
                        backgroundImage: const AssetImage(Assets.imagesGamer),
                        backgroundColor: Colors.grey.shade600,
                        child: Text(
                          tcTeams[index].name[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      )
                    : CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.055,
                        backgroundImage: NetworkImage(tcTeams[index].avatar.url),
                        backgroundColor: Colors.grey.shade600,
                        // child: Text(
                        //   playerTeams[index].name[0].toUpperCase(),
                        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        // ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
