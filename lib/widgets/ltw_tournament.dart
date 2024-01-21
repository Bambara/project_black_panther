import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_black_panther/core/app_export.dart';

import '../models/organizer/t_list.dart';
import '../models/tournament/tournament.dart';
import 'icon_button_widget.dart';

class LTWTournament extends StatelessWidget {
  final TList tournaments;
  final int index;
  final Function(Tournament) openTournament;
  final Function(int) editItem;
  final Function(int) openPlayerList;
  final Function(Tournament) openEventList;
  final Function(int) openTimeTable;
  final Function(int) openScoreBoard;
  final Function(int) removeItem;

  const LTWTournament(
      {Key? key,
      required this.tournaments,
      required this.index,
      required this.openTournament,
      required this.editItem,
      required this.openPlayerList,
      required this.openEventList,
      required this.openTimeTable,
      required this.openScoreBoard,
      required this.removeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        openTournament(tournaments.tournaments[index].tournament);
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
                  image: tournaments.tournaments[index].tournament.artWorks[0].url != ''
                      ? DecorationImage(fit: BoxFit.cover, image: NetworkImage(tournaments.tournaments[index].tournament.artWorks[0].url))
                      : const DecorationImage(fit: BoxFit.cover, image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/06.png')),
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
                    colors: [themeData.shadowColor.withOpacity(0.3), ColorConstant.black900.withOpacity(0.8)],
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
                          tournaments.tournaments[index].tournament.name,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.getFont('Arvo', fontWeight: FontWeight.w600, fontSize: screenHeight * 0.025, color: themeData.colorScheme.secondary),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.46,
                          child: Text('Organizer', style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                        ),
                        SizedBox(
                          width: screenWidth * 0.46,
                          child: Text('Sponsor', style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    // SizedBox(
                    //   height: screenWidth * 0.06,
                    //   child: Row(),
                    // ),
                    // SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: screenWidth * 0.922,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Participants : 5000', style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
                          Text('Status : ${tournaments.tournaments[index].tournament.status}', style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
                          Text('Next Match : 19/10/22', style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    SizedBox(
                      width: screenWidth * 0.9,
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
                            color: themeData.colorScheme.primary.withAlpha(230),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openPlayerList(index);
                            },
                            isIcon: true,
                            iconData: Icons.recent_actors,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(230),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openEventList(tournaments.tournaments[index].tournament);
                            },
                            isIcon: true,
                            iconData: Icons.list_alt,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(230),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openTimeTable(index);
                            },
                            isIcon: true,
                            iconData: Icons.event_note,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(230),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              openScoreBoard(index);
                            },
                            isIcon: true,
                            iconData: Icons.scoreboard,
                            iconSize: screenWidth * 0.06,
                            color: themeData.colorScheme.primary.withAlpha(230),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          IconButtonWidget(
                            imagePath: '',
                            function: () {
                              removeItem(index);
                            },
                            isIcon: true,
                            iconData: FontAwesomeIcons.trashArrowUp,
                            iconSize: screenWidth * 0.05,
                            color: themeData.colorScheme.primary.withAlpha(230),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenWidth * 0.02,
                bottom: 0,
                left: screenWidth * 0.03,
                right: screenWidth * 0.5,
                // width: screenWidth * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemCount: tournaments.tournaments[index].organizers.length,
                  cacheExtent: 10,
                  itemBuilder: (BuildContext context, int index_01) {
                    return tournaments.tournaments[index].organizers[index_01].logo.url != ''
                        ? GFImageOverlay(
                            // border: Border.all(color: themeData.backgroundColor),
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            shape: BoxShape.circle,
                            boxFit: BoxFit.scaleDown,
                            image: NetworkImage(tournaments.tournaments[index].organizers[index_01].logo.url),
                          )
                        : GFImageOverlay(
                            // border: Border.all(color: themeData.backgroundColor),
                      width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            shape: BoxShape.circle,
                            boxFit: BoxFit.scaleDown,
                            image: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/evenatus_logo.png'),
                          );
                  },
                ),
              ),
              Positioned(
                top: screenWidth * 0.02,
                bottom: 0,
                left: screenWidth * 0.5,
                right: screenWidth * 0.02,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemCount: tournaments.tournaments[index].sponsors.length,
                  cacheExtent: 10,
                  itemBuilder: (BuildContext context, int index_01) {
                    return tournaments.tournaments[index].sponsors[index_01].artWorks[0].url != ''
                        ? GFImageOverlay(
                            // border: Border.all(color: themeData.backgroundColor),
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            shape: BoxShape.circle,
                            boxFit: BoxFit.scaleDown,
                            image: NetworkImage(tournaments.tournaments[index].sponsors[index_01].artWorks[0].url),
                          )
                        : GFImageOverlay(
                            // border: Border.all(color: themeData.backgroundColor),
                      width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            shape: BoxShape.circle,
                            boxFit: BoxFit.scaleDown,
                            image: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/evenatus_logo.png'),
                          );
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
