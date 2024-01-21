import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/routes/bindings/oas_binding.dart';
import 'package:project_black_panther/views/organizer/tournament_list_screen.dart';

import '../../controllers/organizer/ods_controller.dart';
import '../../generated/assets.dart';
import '../../widgets/drawer_items.dart';
import '../../widgets/icon_button_widget.dart';
import 'chat_screen.dart';
import 'dashboard_screen.dart';
import 'news_feed_screen.dart';
import 'oa_screen.dart';
import 'point_system_screen.dart';
import 'registration_screen.dart';
import 'score_board_screen.dart';
import 'settings_screen.dart';
import 'shuffle_screen.dart';
import 'stream_screen.dart';

class OrganizerDrawerScreen extends GetView<ODSController> {
  const OrganizerDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GetBuilder<ODSController>(
      builder: (_) => ZoomDrawer(
        controller: controller.zdc,
        menuScreen: MenuScreen(
          controller: controller,
          toggleDrawer: toggleDrawer,
        ),
        menuScreenTapClose: true,
        mainScreen: loadScreen(),
        borderRadius: 24.0,
        //showShadow: true,
        moveMenuScreen: true,
        angle: 0.0,
        //openCurve: Curves.linear,
        //closeCurve: Curves.bounceIn,
        menuBackgroundColor: themeData.highlightColor.withAlpha(180),
        drawerShadowsBackgroundColor: Colors.black,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }

  void toggleDrawer() {
    controller.toggleDrawer();
    if (kDebugMode) {
      print("Toggle Drawer");
    }
  }

  Widget loadScreen() {
    if (DrawerItems.dashBoard == controller.item) {
      return DashboardScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.tournaments == controller.item) {
      return OTLScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.newsFeed == controller.item) {
      return NewsFeedScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.stream == controller.item) {
      return StreamScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.chat == controller.item) {
      return ChatScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.shuffle == controller.item) {
      return ShuffleScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.scoreBoard == controller.item) {
      return ScoreBoardScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.registration == controller.item) {
      return RegistrationScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.pointSystem == controller.item) {
      return PointSystemScreen(openDrawer: toggleDrawer);
    } else if (DrawerItems.settings == controller.item) {
      return SettingsScreen(openDrawer: toggleDrawer);
    } else {
      return DashboardScreen(openDrawer: toggleDrawer);
    }
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key, required this.controller, required this.toggleDrawer}) : super(key: key);

  final ODSController controller;
  final VoidCallback toggleDrawer;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: themeData.primaryColorLight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const OAScreen(), binding: OASBinding());
                      toggleDrawer.call();
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(Assets.imagesGamer),
                      radius: 32,
                    ),
                  ),
                  IconButtonWidget(
                    imagePath: Assets.iconsLogout,
                    function: () {
                      controller.logout();
                    },
                    iconData: FontAwesomeIcons.rightFromBracket,
                    isIcon: false,
                    iconSize: 32,
                    color: themeData.colorScheme.secondary,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: DrawerItems.all.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.screen = DrawerItems.all.elementAt(index).title;
                          controller.item = DrawerItems.all.elementAt(index);
                          controller.toggleDrawer();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(DrawerItems.all.elementAt(index).icon, fit: BoxFit.scaleDown, height: screenWidth * 0.06, width: screenWidth * 0.06),
                              // Icon(DrawerItems.all.elementAt(index).icon),
                              SizedBox(width: screenWidth * 0.05),
                              Text(
                                DrawerItems.all.elementAt(index).title,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
