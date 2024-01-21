import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../controllers/organizer/otds_controller.dart';
import '../../../core/app_export.dart';
import '../../../models/common/art_work.dart';
import '../../../routes/bindings/oeds_binding.dart';
import '../../../routes/bindings/oes_binding.dart';
import '../../../routes/bindings/organizer/ptpms_binding.dart';
import '../../../routes/bindings/organizer/tctms_binding.dart';
import '../../../routes/bindings/ptms_binding.dart';
import '../../../routes/bindings/tas_binding.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/ltw_event.dart';
import '../../../widgets/ltw_player_team.dart';
import '../../../widgets/ltw_tct.dart';
import '../../../widgets/ltw_tp.dart';
import '../event_add_screen.dart';
import '../event_dashboard.dart';
import 'ptm_screen.dart';
import 'ptpm_screen.dart';
import 'tctm_screen.dart';
import 'tournament_add_screen.dart';

class OrganizerTournamentScreen extends GetView<OTDSController> {
  const OrganizerTournamentScreen({
    Key? key,
  }) : super(key: key);

  void _loadEventListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: controller.loaded
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
                                  const Text('Events', style: TextStyle(fontSize: 16))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      Navigator.pop(context);
                                      Get.to(() => const EventAddScreen(), binding: OEASBinding(tournament: controller.tournament));
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
                          child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            padding: const EdgeInsets.all(0),
                            cacheExtent: 10,
                            itemCount: controller.tEvents.length,
                            itemBuilder: (context, index) => LTWEvent(
                              tEvents: controller.tEvents,
                              index: index,
                              openEvent: (index) {
                                Navigator.pop(context);
                                Get.to(() => const OrganizerEventDashboard(),
                                    binding: OEDSBinding(
                                      tEvent: controller.tEvents[index],
                                      clans: controller.clans,
                                      clubs: controller.clubs,
                                      playerProfiles: controller.playerProfiles,
                                      playerTeams: controller.playerTeams,
                                    ));
                              },
                              editItem: (index) {},
                              openPlayerList: (index) {},
                              openEventList: (index) {},
                              openTimeTable: (index) {},
                              openScoreBoard: (index) {},
                              removeItem: (index) {},
                              organizers: ['', '', ''],
                              sponsors: ['', '', ''],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : loadingDialog(context),
          );
        });
  }

  void _loadPlayerListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
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
                              width: screenWidth * 0.40,
                            ),
                            const Text('Player Teams', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                Navigator.pop(context);
                                Get.to(() => const PTMScreen(), binding: PTMSBinding(tournament: controller.tournament, playerTeam: null));
                              },
                              iconData: Icons.add_circle_outline_rounded,
                              isIcon: true,
                              iconSize: 32,
                              color: themeData.textTheme.bodyLarge?.color,
                            ),
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                controller.playerTeamsLoaded = false;
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
                    child: GetBuilder<OTDSController>(
                      builder: (controller) => controller.playerTeamsLoaded
                          ? ListView.builder(
                              addAutomaticKeepAlives: false,
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                              cacheExtent: 10,
                              itemCount: controller.playerTeams.length,
                              itemBuilder: (context, index) => LTWPlayerTeam(
                                playerTeams: controller.playerTeams,
                                clubs: controller.clubs,
                                clans: controller.clans,
                                players: controller.playerProfiles,
                                navigate: () {
                                  Navigator.pop(context);
                                  Get.to(() => const PTMScreen(), binding: PTMSBinding(tournament: controller.tournament, playerTeam: controller.playerTeams[index]));
                                },
                                index: index,
                                function: () {},
                              ),
                            )
                          : loadingDialog(context),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          );
        });
  }

  void _loadCoordinatorListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();
    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        isDismissible: false,
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
                              width: screenWidth * 0.35,
                            ),
                            const Text('Coordinator Teams', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                Navigator.pop(context);
                                Get.to(() => const TCTMScreen(), binding: TCTMSBinding(tournament: controller.tournament, playerTeam: null));
                              },
                              iconData: Icons.add_circle_outline_rounded,
                              isIcon: true,
                              iconSize: 32,
                              color: themeData.textTheme.bodyLarge?.color,
                            ),
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                controller.tcTeamsLoaded = false;
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
                    child: GetBuilder<OTDSController>(
                      builder: (controller) => controller.tcTeamsLoaded
                          ? ListView.builder(
                              addAutomaticKeepAlives: false,
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                              cacheExtent: 10,
                              itemCount: controller.tcTeams.length,
                              itemBuilder: (context, index) => LTWTCTeam(
                                tcTeams: controller.tcTeams,
                                index: index,
                                navigate: () {
                                  Navigator.pop(context);
                                  Get.to(() => const TCTMScreen(), binding: TCTMSBinding(tournament: controller.tournament, playerTeam: null));
                                },
                                editItem: (index) {},
                                removeItem: (index) {},
                              ),
                            )
                          : loadingDialog(context),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          );
        });
  }

  void _loadPaymentBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        isDismissible: true,
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
                              width: screenWidth * 0.42,
                            ),
                            const Text('Payments', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                Navigator.pop(context);
                                Get.to(() => const PTPMScreen(), binding: PTPMSBinding(tournament: controller.tournament, payment: null));
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
                    child: GetBuilder<OTDSController>(
                      builder: (controller) => controller.paymentsLoaded
                          ? ListView.builder(
                              addAutomaticKeepAlives: false,
                              padding: const EdgeInsets.all(0),
                              cacheExtent: 10,
                              itemCount: controller.payments.length,
                              itemBuilder: (context, index) => LTWTP(
                                payments: controller.payments,
                                index: index,
                                editItem: (index) {
                                  Log.i('index');
                                },
                                removeItem: (index) {
                                  controller.removeTournamentPayment(controller.payments[index].id);
                                },
                                navigate: () {
                                  Navigator.pop(context);
                                  Get.to(() => const PTPMScreen(), binding: PTPMSBinding(tournament: controller.tournament, payment: controller.payments[index]));
                                },
                              ),
                            )
                          : loadingDialog(context),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          );
        });
  }

  String _loadWallArt(List<ArtWork> artWorks) {
    if (artWorks.isNotEmpty) {
      return controller.tournament!.artWorks
          .where((artWork) {
            return artWork.name.split('_')[1].contains('wa');
          })
          .first
          .url;
    } else {
      return '';
    }
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
            title: Text('Tournament Dashboard', style: TextStyle(color: themeData.textTheme.titleLarge!.color)),
            centerTitle: true,
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                child: Stack(children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: GetBuilder<OTDSController>(
                      builder: (controller) => controller.isSelected == false
                          ? controller.tournament != null
                              ? _loadWallArt(controller.tournament!.artWorks) == ''
                                  ? const GFImageOverlay(
                        image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398885/assets/02.jpg'),
                                      boxFit: BoxFit.cover,
                                    )
                                  : GFImageOverlay(
                                      image: NetworkImage(_loadWallArt(controller.tournament!.artWorks)),
                                      boxFit: BoxFit.cover,
                                    )
                              : const GFImageOverlay(
                        image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398885/assets/02.jpg'),
                                  boxFit: BoxFit.cover,
                                )
                          : GFImageOverlay(
                              image: FileImage(controller.wallArt),
                              boxFit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      // color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [themeData.shadowColor.withOpacity(0.2), themeData.scaffoldBackgroundColor.withOpacity(0.7)],
                        // stops: const [0.0, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.005),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  Get.to(() => const TournamentAddScreen(), binding: TASBinding(tournament: controller.tournament));
                                },
                                isIcon: true,
                                iconData: Icons.edit_note,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  controller.getTRegisteredPlayerTeamsByTId();
                                  _loadEventListBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                isIcon: true,
                                // iconData: FontAwesomeIcons.list,
                                iconData: Icons.emoji_events_outlined,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  controller.getTRegisteredPlayerTeamsByTId();
                                  _loadPlayerListBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                isIcon: true,
                                iconData: Icons.recent_actors,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: FontAwesomeIcons.shuffle,
                                iconSize: screenWidth * 0.065,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: Icons.event_note,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: Icons.scoreboard,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  controller.getAllTournamentPayments();
                                  _loadPaymentBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                isIcon: true,
                                iconData: FontAwesomeIcons.moneyBill1,
                                iconSize: screenWidth * 0.065,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: Icons.live_tv_rounded,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  controller.getAllTCTeamsByTId();
                                  _loadCoordinatorListBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                isIcon: true,
                                iconData: Icons.diversity_3_sharp,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: FontAwesomeIcons.sliders,
                                iconSize: screenWidth * 0.065,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: Icons.announcement,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                              IconButtonWidget(
                                imagePath: '',
                                function: () {},
                                isIcon: true,
                                iconData: Icons.report,
                                iconSize: screenWidth * 0.07,
                                color: themeData.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                GetBuilder<OTDSController>(
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
