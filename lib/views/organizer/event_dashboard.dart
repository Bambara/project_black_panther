import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_black_panther/widgets/loading_dialog.dart';

import '../../controllers/organizer/oeds_controller.dart';
import '../../core/app_export.dart';
import '../../generated/assets.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_espt.dart';
import '../../widgets/search_text_field_widget.dart';
import '../../widgets/svg_icon_widget.dart';

class OrganizerEventDashboard extends GetView<OEDSController> {
  const OrganizerEventDashboard({Key? key}) : super(key: key);

  void _loadPlayerTeamListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();
    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: screenHeight * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: themeData.colorScheme.primary.withAlpha(220),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.45,
                              ),
                              const Text('Player List', style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  controller.getPlayerTeamNames();
                                  Navigator.pop(context);
                                  _assignPlayerTeamBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                iconData: Icons.add_circle_outline_rounded,
                                isIcon: true,
                                iconSize: 32,
                                color: themeData.textTheme.bodyLarge?.color,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  Navigator.pop(context);
                                },
                                iconData: Icons.close,
                                isIcon: true,
                                iconSize: 32,
                                color: themeData.textTheme.bodyLarge?.color,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Expanded(
                      child: GetBuilder<OEDSController>(
                        builder: (controller) => controller.playerTeamsLoaded
                            ? ListView.builder(
                                addAutomaticKeepAlives: false,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                cacheExtent: 10,
                                itemCount: controller.assignedPlayerTeams.length,
                                itemBuilder: (context, index) => LTWEAPlayerTeam(
                                  playerTeams: controller.assignedPlayerTeams,
                                  clubs: controller.clubs,
                                  clans: controller.clans,
                                  players: controller.playerProfiles,
                                  assignedTeams: controller.assignedTeams,
                                  navigate: () {
                                    Navigator.pop(context);
                                    // Get.to(() => const PTMScreen(), binding: PTMSBinding(tournament: controller.tournament, playerTeam: controller.playerTeams[index]));
                                  },
                                  index: index,
                                  function: () {},
                                  remove: (assignedTeam) {
                                    controller.resignPlayerTeam(context, assignedTeam);
                                  },
                                ),
                              )
                            : loadingDialog(context),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void _assignPlayerTeamBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();
    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: controller.splbsLoaded
                ? SizedBox(
                    height: screenHeight * 0.525,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: themeData.colorScheme.primary.withAlpha(220),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.37,
                                  ),
                                  const Text('Player Team Assign', style: TextStyle(fontSize: 16))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      Navigator.pop(context);
                                      // Get.to(() => const EventAddScreen(), binding: OEASBinding(tournament: controller.tournament));
                                    },
                                    iconData: Icons.add_circle_outline_rounded,
                                    isIcon: true,
                                    iconSize: 32,
                                    color: themeData.textTheme.bodyLarge?.color,
                                  ),*/
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    iconData: Icons.close,
                                    isIcon: true,
                                    iconSize: 32,
                                    color: themeData.textTheme.bodyLarge?.color,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Column(
                          children: [
                            GetBuilder<OEDSController>(
                              builder: (controller) => SizedBox(
                                width: 0.97 * screenWidth,
                                child: SearchTextFieldWidget(
                                  hintText: 'Player Team',
                                  labelText: 'Player Team',
                                  enableValidate: true,
                                  txtCtrl: controller.playerTeamCtrl,
                                  fontSize: 0.03,
                                  heightFactor: 0.057,
                                  widthFactor: 0.95,
                                  inputType: TextInputType.text,
                                  items: controller.ptNames,
                                  onItemTap: (selectItem) {
                                    controller.searchPlayerTeamByName(selectItem);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            GetBuilder<OEDSController>(
                              builder: (controller) => Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.25,
                                decoration: BoxDecoration(
                                  color: themeData.highlightColor,
                                  borderRadius: BorderRadius.all(Radius.circular(screenHeight / screenWidth) * Constants.boarderRadius),
                                ),
                                child: controller.searchedTeam.name == ''
                                    ? const Center()
                                    : Stack(
                                        fit: StackFit.loose,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            top: screenHeight * 0.01,
                                            left: screenHeight * 0.01,
                                            child: controller.searchedTeam.logo.url == ''
                                                ? CircleAvatar(
                                              radius: MediaQuery.of(context).size.height * 0.06,
                                                    backgroundImage: const AssetImage(Assets.imagesGamer),
                                                    backgroundColor: Colors.grey.shade600,
                                                    child: Text(
                                                      controller.searchedTeam.name[0].toUpperCase(),
                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: MediaQuery.of(context).size.height * 0.06,
                                                    backgroundImage: NetworkImage(controller.searchedTeam.logo.url),
                                                    backgroundColor: Colors.grey.shade600,
                                                    // child: Text(
                                                    //   playerTeams[index].name[0].toUpperCase(),
                                                    //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                                                    // ),
                                                  ),
                                          ),
                                          Positioned(
                                            top: screenHeight * 0.16,
                                            left: screenHeight * 0.05,
                                            child: const GFBadge(
                                              size: GFSize.LARGE,
                                              shape: GFBadgeShape.standard,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.0075),
                                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.0075),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(controller.searchedTeam.name.toString(), style: TextStyle(fontSize: (themeData.textTheme.headlineSmall!.fontSize! - 3)))),
                                                Divider(indent: screenWidth * 0.22),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      SizedBox(width: screenWidth * 0.25),
                                                      const Text('Code : '),
                                                      Text(controller.searchedTeam.code, style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize))
                                                    ])
                                                  ],
                                                ),
                                                Divider(indent: screenWidth * 0.21, endIndent: screenWidth * 0.15),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      SizedBox(width: screenWidth * 0.25),
                                                      const Text('Club : '),
                                                      Text(
                                                          controller.clubs
                                                              .where((club) {
                                                                return club.id == controller.searchedTeam.clubId.toString();
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
                                                      const Text('Clan : '),
                                                      Text(
                                                          controller.clans
                                                              .where((clan) {
                                                                return clan.id == controller.searchedTeam.clanId.toString();
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
                                                      const Text('Status : '),
                                                      Text(controller.searchedTeam.status.toString(), style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize)),
                                                    ]),
                                                    Row(children: [
                                                      const Text('Type : '),
                                                      Text(controller.searchedTeam.teamType.toString(), style: TextStyle(fontSize: themeData.textTheme.bodyLarge!.fontSize)),
                                                      SizedBox(width: screenWidth * 0.15),
                                                    ]),
                                                    /*Row(
                                                      children: [
                                                        SizedBox(width: screenWidth * 0.1),
                                                        const SVGIconWidget(path: Assets.iconsAddCircle, sizeFactor: 0.045),
                                                        SizedBox(width: screenHeight * 0.02),
                                                        GestureDetector(onTap: () => Log.i('Clicked'), child: const SVGIconWidget(path: Assets.iconsDelete, sizeFactor: 0.045)),
                                                      ],
                                                    )*/
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            FlatButtonWidget(
                                title: 'Assign',
                                function: () {
                                  controller.assignPlayerTeam(context);
                                  // Get.to(() => EventsListScreen());
                                },
                                heightFactor: 0.065,
                                widthFactor: 0.6,
                                color: themeData.colorScheme.secondary),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        )
                      ],
                    ),
                  )
                : loadingDialog(context),
          );
        });
  }

  void _loadRefListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();
    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: controller.splbsLoaded
                ? SizedBox(
                    height: screenHeight * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: themeData.colorScheme.primary.withAlpha(220),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.45,
                                  ),
                                  const Text('Ref List', style: TextStyle(fontSize: 16))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      Navigator.pop(context);
                                      // Get.to(() => const EventAddScreen(), binding: OEASBinding(tournament: controller.tournament));
                                    },
                                    iconData: Icons.add_circle_outline_rounded,
                                    isIcon: true,
                                    iconSize: 32,
                                    color: themeData.textTheme.bodyLarge?.color,
                                  ),
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    iconData: Icons.close,
                                    isIcon: true,
                                    iconSize: 32,
                                    color: themeData.textTheme.bodyLarge?.color,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        DropDownButtonWidget(
                          selectData: (value) {},
                          isRequired: true,
                          label: "Team",
                          items: const ["None", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13"],
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: 'None',
                          // ),
                        ),
                      ],
                    ),
                  )
                : loadingDialog(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: screenHeight * 0.15,
            floating: true,
            snap: true,
            title: const Text('Event Dashboard'),
            centerTitle: true,
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                child: Stack(children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: GetBuilder<OEDSController>(builder: (controller) {
                      if (controller.tEvent!.artWorks.isNotEmpty) {
                        for (var artWork in controller.tEvent!.artWorks) {
                          if (artWork.name.split('_')[1] == 'Wall') {
                            if (artWork.url.contains('http')) {
                              return GFImageOverlay(
                                image: NetworkImage(artWork.url),
                                boxFit: BoxFit.cover,
                              );
                            } else {
                              return GFImageOverlay(
                                image: FileImage(File(artWork.url)),
                                boxFit: BoxFit.cover,
                              );
                            }
                          } else {
                            return const GFImageOverlay(
                              image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398885/assets/02.jpg'),
                              boxFit: BoxFit.cover,
                            );
                          }
                        }
                      } else {
                        return const GFImageOverlay(
                          image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398885/assets/02.jpg'),
                          boxFit: BoxFit.cover,
                        );
                      }
                      return Container();
                    }),
                  ),
                  Container(
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      // color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [themeData.shadowColor.withOpacity(0.2), ColorConstant.lightBlue.withOpacity(0.7)],
                        // stops: const [0.0, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.tEvent!.eventName,
                          style: GoogleFonts.getFont(
                            'Arvo',
                            fontWeight: FontWeight.w600,
                            fontSize: themeData.textTheme.bodyLarge?.fontSize,
                            color: themeData.scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.005),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsTimeTable, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(
                                      onTap: () {
                                        controller.getAssignedPlayerTeams();
                                        _loadPlayerTeamListBottomSheet(context, screenHeight, screenWidth, themeData);
                                      },
                                      child: const SVGIconWidget(path: Assets.iconsTeam, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(RefListScreen.routeName);
                                        _loadRefListBottomSheet(context, screenHeight, screenWidth, themeData);
                                      },
                                      child: const SVGIconWidget(path: Assets.iconsRefTeam, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsAnnouncement, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsRar, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsLocation, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsPayments, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsRac, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                  GestureDetector(child: const SVGIconWidget(path: Assets.iconsSettings, sizeFactor: 0.07)),
                                  SizedBox(width: screenWidth * 0.05),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0025),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.5,
                  color: themeData.splashColor,
                ),
                GetBuilder<OEDSController>(
                  builder: (controller) => GFAccordion(
                    title: 'Events',
                    contentPadding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(5),
                    collapsedTitleBackgroundColor: themeData.splashColor,
                    expandedTitleBackgroundColor: themeData.splashColor,
                    onToggleCollapsed: (isOpen) {
                      controller.isOAOpen = isOpen;
                    },
                    titleBorderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                      bottomRight: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                    ),
                    contentChild: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                        child: Container(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.8,
                          color: themeData.splashColor,
                        )),
                  ),
                  id: 'organizerA',
                ),
                GFAccordion(
                  title: 'Sponsors',
                  contentPadding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(5),
                  collapsedTitleBackgroundColor: themeData.splashColor,
                  expandedTitleBackgroundColor: themeData.splashColor,
                  onToggleCollapsed: (isOpen) {
                    controller.isOAOpen = isOpen;
                  },
                  titleBorderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                    bottomRight: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                  ),
                  contentChild: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      child: Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.8,
                        color: themeData.splashColor,
                      )),
                ),
                GFAccordion(
                  title: 'Team Groups',
                  contentPadding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(5),
                  collapsedTitleBackgroundColor: themeData.splashColor,
                  onToggleCollapsed: (isOpen) {
                    controller.isOAOpen = isOpen;
                  },
                  titleBorderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                    bottomRight: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                  ),
                  contentChild: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      child: Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.8,
                        color: themeData.splashColor,
                      )),
                ),
                GFAccordion(
                  title: 'Team Sides',
                  contentPadding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(5),
                  collapsedTitleBackgroundColor: themeData.splashColor,
                  onToggleCollapsed: (isOpen) {
                    controller.isOAOpen = isOpen;
                  },
                  titleBorderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                    bottomRight: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                  ),
                  contentChild: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      child: Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.8,
                        color: themeData.splashColor,
                      )),
                ),
                GFAccordion(
                  title: 'Games',
                  contentPadding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(5),
                  collapsedTitleBackgroundColor: themeData.splashColor,
                  onToggleCollapsed: (isOpen) {
                    controller.isOAOpen = isOpen;
                  },
                  titleBorderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                    bottomRight: controller.isOAOpen ? const Radius.circular(0) : const Radius.circular(15),
                  ),
                  contentChild: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      child: Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.8,
                        color: themeData.splashColor,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
