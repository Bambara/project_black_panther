import 'package:flutter/material.dart';
import 'package:project_black_panther/core/app_export.dart';
import 'package:project_black_panther/models/tournament/player_team.dart';
import 'package:project_black_panther/widgets/svg_icon_widget.dart';

import '../generated/assets.dart';
import '../models/common/organization.dart';
import '../models/player/player_profile.dart';

class LTWPlayerTeam extends StatelessWidget {
  final List<PlayerTeam> playerTeams;
  final List<Organization> clans, clubs;
  final List<PlayerProfile> players;
  final int index;
  final VoidCallback function;
  final VoidCallback navigate;

  const LTWPlayerTeam({
    Key? key,
    required this.playerTeams,
    required this.clans,
    required this.clubs,
    required this.players,
    required this.index,
    required this.function,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: navigate,
      child: Card(
        color: themeData.highlightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // shadowColor: Theme.of(context).textTheme.bodySmall?.color,
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.0075),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.0075),
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(Constants.screenCornerRadius))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(alignment: Alignment.centerRight, child: Text(playerTeams[index].name.toString(), style: TextStyle(fontSize: (themeData.textTheme.headlineSmall!.fontSize! - 3)))),
                  Divider(indent: screenWidth * 0.22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SizedBox(width: screenWidth * 0.25),
                        const Text('Club :'),
                        Text(
                            clubs
                                .where((club) {
                                  return club.id == playerTeams[index].clubId.toString();
                                })
                                .toList()
                                .first
                                .name,
                            style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize))
                      ])
                    ],
                  ),
                  Divider(indent: screenWidth * 0.21, endIndent: screenWidth * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SizedBox(width: screenWidth * 0.25),
                        const Text('Clan :'),
                        Text(
                            clans
                                .where((clan) {
                                  return clan.id == playerTeams[index].clanId.toString();
                                })
                                .toList()
                                .first
                                .name,
                            style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize))
                      ])
                    ],
                  ),
                  Divider(indent: screenWidth * 0.21, endIndent: screenWidth * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SizedBox(width: screenWidth * 0.2),
                        const Text('Status :'),
                        Text(playerTeams[index].status.toString(), style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize))
                      ]),
                      Row(
                        children: [
                          const SVGIconWidget(path: Assets.iconsEdit, sizeFactor: 0.045),
                          SizedBox(width: screenHeight * 0.01),
                          const SVGIconWidget(path: Assets.iconsDelete, sizeFactor: 0.045),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.01,
              left: screenHeight * 0.01,
              child: playerTeams[index].logo.url == ''
                  ? CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.06,
                      backgroundImage: const AssetImage(Assets.imagesGamer),
                      backgroundColor: Colors.grey.shade600,
                      child: Text(
                        playerTeams[index].name[0].toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                    )
                  : CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.06,
                      backgroundImage: NetworkImage(playerTeams[index].logo.url),
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
    );
  }
}
