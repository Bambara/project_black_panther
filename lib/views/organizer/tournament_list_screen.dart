import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_black_panther/core/app_export.dart';
import 'package:project_black_panther/models/tournament/tournament.dart';
import 'package:project_black_panther/views/organizer/tournament/tournament_add_screen.dart';
import 'package:project_black_panther/views/organizer/tournament/tournament_dashboard.dart';

import '../../controllers/organizer/tls_controller.dart';
import '../../generated/assets.dart';
import '../../routes/bindings/oes_binding.dart';
import '../../routes/bindings/ots_binding.dart';
import '../../routes/bindings/tas_binding.dart';
import '../../widgets/drawer_menu_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/ltw_event.dart';
import '../../widgets/ltw_tournament.dart';
import '../../widgets/svg_icon_widget.dart';
import 'event_add_screen.dart';

class OTLScreen extends GetView<OTLSController> {
  final VoidCallback openDrawer;

  OTLScreen({Key? key, required this.openDrawer}) : super(key: key);

  final _otlsCtrl = Get.put(OTLSController());

  void _loadEventListBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData, Tournament tournament) {
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
                                Get.to(() => const EventAddScreen(), binding: OEASBinding(tournament: tournament));
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
                      itemCount: 10,
                      itemBuilder: (context, index) => LTWEvent(
                        tEvents: const [],
                        index: index,
                        openEvent: (index) {},
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
            ),
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
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.textTheme.bodyLarge!.color,
            floating: true,
            snap: true,
            title: const Text('Tournament List'),
            centerTitle: true,
            leading: DrawerMenuWidget(
              onClicked: openDrawer,
            ),
          )
        ],
        body: RefreshIndicator(
          displacement: screenHeight * 0.2,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            controller.loadingData();
            await Future.delayed(const Duration(milliseconds: 3000));
          },
          child: GetBuilder<OTLSController>(
            builder: (controller) => controller.loaded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          addAutomaticKeepAlives: false,
                          cacheExtent: 10,
                          itemCount: controller.tList.tournaments.length,
                          itemBuilder: (context, index) => LTWTournament(
                            tournaments: controller.tList,
                            index: index,
                            openTournament: (tournament) {
                              Get.to(() => const OrganizerTournamentScreen(), binding: OTSBinding(tournament: tournament));
                            },
                            editItem: (index) {},
                            openPlayerList: (index) {},
                            openEventList: (tournament) {
                              _loadEventListBottomSheet(context, screenHeight, screenWidth, themeData, tournament);
                            },
                            openTimeTable: (index) {},
                            openScoreBoard: (index) {},
                            removeItem: (index) {},
                          ),
                        ),
                      ),
                    ],
                  )
                : loadingDialog(context),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const TournamentAddScreen(), binding: TASBinding(tournament: null)),
        elevation: 0,
        backgroundColor: ColorConstant.transparentAsh,
        child: const SVGIconWidget(path: Assets.iconsAdd, sizeFactor: 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        backgroundColor: themeData.bottomNavigationBarTheme.backgroundColor,
        color: themeData.textTheme.bodyLarge?.color,
        items: const [
          TabItem(icon: SVGIconWidget(path: Assets.iconsRecent, sizeFactor: 0.06), title: 'Recent'),
          TabItem(icon: SVGIconWidget(path: Assets.iconsProcess, sizeFactor: 0.06), title: 'Ongoing'),
          TabItem(icon: SVGIconWidget(path: Assets.iconsFinish, sizeFactor: 0.06), title: 'Finished'),
        ],
        onTap: (int i) {
          controller.selectedTab = i;
          // controller.goto(context);
          // Get.put(InvoiceAddController()).onReady();
          if (kDebugMode) {
            print('click index=${controller.selectedTab}');
          }
        },
        curveSize: 100,
        style: TabStyle.reactCircle,
      ),
    );
  }
}
