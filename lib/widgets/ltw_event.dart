import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/color_constant.dart';
import '../models/tournament/tournament_event.dart';
import 'icon_button_widget.dart';

class LTWEvent extends StatelessWidget {
  final List<TournamentEvent> tEvents;
  final List<String> organizers;
  final List<String> sponsors;
  final int index;
  final Function(int index) openEvent;
  final Function(int index) editItem;
  final Function(int index) openPlayerList;
  final Function(int index) openEventList;
  final Function(int index) openTimeTable;
  final Function(int index) openScoreBoard;
  final Function(int index) removeItem;

  ///Tournament Event List tile Widget
  const LTWEvent(
      {Key? key,
      required this.tEvents,
      required this.index,
      required this.openEvent,
      required this.editItem,
      required this.openPlayerList,
      required this.openEventList,
      required this.openTimeTable,
      required this.openScoreBoard,
      required this.removeItem,
      required this.organizers,
      required this.sponsors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        openEvent(index);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenWidth * 0.005),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          elevation: 2,
          shadowColor: Theme.of(context).textTheme.bodyText1?.color,
          // color: Theme.of(context).primaryColorLight,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
                  color: Colors.transparent,
                  image: const DecorationImage(fit: BoxFit.cover, image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398886/assets/06.jpg')),
                ),
                height: screenHeight * 0.27,
              ),
              Container(
                height: screenHeight * 0.27,
                // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
                decoration: BoxDecoration(
                  //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [themeData.shadowColor.withOpacity(0.2), ColorConstant.teal900.withOpacity(0.7)],
                    // stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.066,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          tEvents[index].eventName,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.getFont('Arvo', fontWeight: FontWeight.w600, fontSize: screenHeight * 0.025, color: themeData.appBarTheme.foregroundColor),
                        ),
                      ),
                    ),
                    // Flexible(
                    //   child: Text(
                    //     tEvents[index].eventName,
                    //     maxLines: 2,
                    //     softWrap: true,
                    //     overflow: TextOverflow.fade,
                    //     style: GoogleFonts.getFont(
                    //       'Arvo',
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: themeData.textTheme.headline6?.fontSize,
                    //       color: themeData.colorScheme.secondary,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.461,
                          child: Text('Organizer', style: TextStyle(color: themeData.appBarTheme.foregroundColor)),
                        ),
                        SizedBox(
                          width: screenWidth * 0.461,
                          child: Text('Sponsor', style: TextStyle(color: themeData.appBarTheme.foregroundColor)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      height: screenWidth * 0.06,
                      child: Row(),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: screenWidth * 0.922,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Participants : 5000', style: TextStyle(fontSize: 14, color: themeData.appBarTheme.foregroundColor)),
                          Text('Status : Ongoing', style: TextStyle(fontSize: 14, color: themeData.appBarTheme.foregroundColor)),
                          Text('Next Match : 19/10/2022', style: TextStyle(fontSize: 14, color: themeData.appBarTheme.foregroundColor)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      width: screenWidth * 0.922,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              editItem(index);
                            },
                            isIcon: true,
                            iconData: Icons.edit_note,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openPlayerList(index);
                            },
                            isIcon: true,
                            iconData: Icons.recent_actors,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openEventList(index);
                            },
                            isIcon: true,
                            iconData: Icons.list_alt,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openTimeTable(index);
                            },
                            isIcon: true,
                            iconData: Icons.event_note,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openScoreBoard(index);
                            },
                            isIcon: true,
                            iconData: Icons.scoreboard,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              removeItem(index);
                            },
                            isIcon: true,
                            iconData: FontAwesomeIcons.trashArrowUp,
                            iconSize: screenWidth * 0.05,
                            color: themeData.colorScheme.primary,
                          )
                          /*const Text('Status : ', style: TextStyle(fontSize: 14)),
                                              Row(
                                                children: [

                                                ],
                                              )*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenWidth * 0.01,
                bottom: 0,
                left: screenWidth * 0.03,
                right: screenWidth * 0.5,
                // width: screenWidth * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemCount: organizers.length,
                  cacheExtent: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GFImageOverlay(
                        // border: Border.all(color: themeData.backgroundColor),
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        shape: BoxShape.circle,
                        boxFit: BoxFit.scaleDown,
                        image: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/evenatus_logo.png'));
                  },
                ),
              ),
              Positioned(
                top: screenWidth * 0.01,
                bottom: 0,
                left: screenWidth * 0.5,
                right: screenWidth * 0.02,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemCount: sponsors.length,
                  cacheExtent: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GFImageOverlay(
                        // border: Border.all(color: themeData.backgroundColor),
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        shape: BoxShape.circle,
                        boxFit: BoxFit.scaleDown,
                        image: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/evenatus_logo.png'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
