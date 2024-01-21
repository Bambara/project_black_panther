import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../models/tournament/event_team_assign.dart';
import '../models/tournament/tournament_event.dart';
import 'image_button_widget.dart';

//LTWAssignEvent - ListTileWidgetAssignEvent
class LTWAssignEvent extends StatelessWidget {
  final List<EventTeamAssign> eventAssignTeams;
  final List<TournamentEvent> tEvents;
  final int index;
  final Function function;
  final Function(int index) removeItem;
  final VoidCallback navigate;
  final Function(int, bool) onChangeStatus;
  final bool? valveChoose;

  const LTWAssignEvent(
      {required this.eventAssignTeams,
      required this.tEvents,
      required this.index,
      required this.function,
      required this.removeItem,
      required this.navigate,
      required this.onChangeStatus,
      required this.valveChoose,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    final tEvent = tEvents
        .where((event) {
          return event.id == eventAssignTeams[index].teId;
        })
        .toList()
        .first;

    return GestureDetector(
      onTap: navigate,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.008, left: screenWidth * 0.015, right: screenWidth * 0.015),
        child: Card(
          color: themeData.highlightColor.withAlpha(200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          elevation: 2,
          child: Stack(clipBehavior: Clip.antiAliasWithSaveLayer, alignment: Alignment.center, children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenHeight * 0.015),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      SizedBox(width: screenHeight * 0.08),
                      Text(tEvent.eventName, style: TextStyle(fontSize: themeData.textTheme.bodyLarge?.fontSize)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: screenHeight * 0.08),
                          Row(
                            children: [
                              Text('Type : ${tEvent.eventType}', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize)),
                              SizedBox(
                                width: screenWidth * 0.03,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Status',
                            style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize),
                          ),
                          Switch.adaptive(
                            value: valveChoose!,
                            onChanged: (value) {
                              // Log.i(value);
                              onChangeStatus.call(index, value);
                            },
                          ),
                        ],
                      ),
                      ImageButtonWidget(
                        imagePath: Assets.iconsDelete,
                        function: () {
                          removeItem(index);
                        },
                        isIcon: false,
                        iconData: Icons.cancel,
                        iconSize: screenHeight * 0.04,
                        color: themeData.colorScheme.secondary,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.015,
              left: screenHeight * 0.01,
              child: Builder(
                builder: (context) {
                  late Widget avatar;
                  for (var artWork in tEvent.artWorks) {
                    if (artWork.name.split('_')[1] == 'Wall') {
                      avatar = CircleAvatar(
                        radius: screenHeight * 0.04,
                        backgroundImage: NetworkImage(artWork.url),
                        backgroundColor: Colors.grey.shade600,
                        // child: Text(
                        //   assignTeams[index].teId[0].toUpperCase(),
                        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        // ),
                      );
                    } else {
                      avatar = CircleAvatar(
                        radius: screenHeight * 0.04,
                        backgroundImage: const AssetImage(Assets.imagesGamer),
                        backgroundColor: Colors.grey.shade600,
                        child: Text(
                          eventAssignTeams[index].teId[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      );
                    }
                  }
                  return avatar;
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
