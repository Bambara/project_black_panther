import 'package:flutter/material.dart';
import 'package:project_black_panther/models/tournament/duo_info.dart';

import '../generated/assets.dart';
import 'image_button_widget.dart';

class ListTileWidgetSquad extends StatelessWidget {
  const ListTileWidgetSquad({Key? key, required this.duoTeam, required this.index, required this.function, required this.navigate}) : super(key: key);

  final List<DuoInfo> duoTeam;
  final int index;
  final Function function;
  final VoidCallback navigate;

  void get() {
    print('Call');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [const SizedBox(width: 75), Text(duoTeam[index].name.toString(), style: const TextStyle(fontSize: 24))]),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [const SizedBox(width: 75), const Text('Club :'), Text(duoTeam[index].club.toString(), style: const TextStyle(fontSize: 24))])
                  ],
                ),
                const Divider(
                  endIndent: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [const SizedBox(width: 75), const Text('Clan :'), Text(duoTeam[index].clan.toString(), style: const TextStyle(fontSize: 24))]),
                    Row(
                      children: [
                        ImageButtonWidget(
                          imagePath: 'assets/images/create.png',
                          function: () => function,
                          isIcon: false,
                          iconData: Icons.adb,
                          iconSize: screenHeight * 0.04,
                          color: themeData.colorScheme.secondary,
                        ),
                        ImageButtonWidget(
                          imagePath: Assets.iconsDelete,
                          function: () => function,
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
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.06,
              backgroundImage: const AssetImage("assets/images/users_group_black.png"),
              backgroundColor: Colors.grey.shade600,
              /*child: Text(
                duoTeam[index].ign.toString()[0].toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),*/
            ),
            top: -20,
            left: 10,
          ),
        ]),
      ),
    );
  }
}
