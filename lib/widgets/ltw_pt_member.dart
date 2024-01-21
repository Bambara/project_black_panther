import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_black_panther/generated/assets.dart';
import 'package:project_black_panther/models/tournament/pt_member.dart';

import 'image_button_widget.dart';

//LTWPTMember - ListTileWidgetPlayerTeamMember
class LTWPTMember extends StatelessWidget {
  final List<PTMember> ptMember;

  // final PlayerProfile selectedPlayer;
  final int index;
  final Function function;
  final Function(int index) removeItem;
  final VoidCallback navigate;
  final Function(Object, int) onChangedLeader;
  final Function(int, bool) onChangeStatus;
  final int rbPosition;
  final int groupValue;
  final bool? valveChoose;

  const LTWPTMember(
      {required this.ptMember,
      // required this.selectedPlayer,
      required this.index,
      required this.function,
      required this.removeItem,
      required this.navigate,
      required this.onChangedLeader,
      required this.onChangeStatus,
      required this.rbPosition,
      required this.groupValue,
      required this.valveChoose,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

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
                      Text('IGN : ${ptMember[index].defaultIgn}', style: TextStyle(fontSize: themeData.textTheme.bodyLarge?.fontSize)),
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
                              Text('Is Leader', style: TextStyle(fontSize: themeData.textTheme.bodyMedium?.fontSize)),
                              SizedBox(
                                width: screenWidth * 0.03,
                              ),
                              GFRadio(
                                size: screenWidth * 0.05,
                                value: rbPosition,
                                groupValue: groupValue,
                                onChanged: (value) {
                                  // Log.i('$value $position $groupValue');
                                  onChangedLeader.call(value!, rbPosition);
                                },
                                activeBorderColor: GFColors.SECONDARY,
                                radioColor: GFColors.SUCCESS,
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
              child: CircleAvatar(
                radius: screenHeight * 0.04,
                backgroundImage: const AssetImage(Assets.imagesGamer),
                backgroundColor: Colors.grey.shade600,
                child: Text(
                  ptMember[index].defaultIgn[0].toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
