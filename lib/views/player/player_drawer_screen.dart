import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/player/pds_controller.dart';
import '../../core/app_export.dart';
import '../../generated/assets.dart';
import '../../routes/bindings/player/pas_binding.dart';
import '../../widgets/drawer_items.dart';
import '../../widgets/icon_button_widget.dart';
import '../organizer/chat_screen.dart';
import '../organizer/dashboard_screen.dart';
import '../organizer/news_feed_screen.dart';
import '../organizer/point_system_screen.dart';
import '../organizer/registration_screen.dart';
import '../organizer/score_board_screen.dart';
import '../organizer/settings_screen.dart';
import '../organizer/shuffle_screen.dart';
import '../organizer/stream_screen.dart';
import '../organizer/tournament_list_screen.dart';
import 'pa_screen.dart';

class PlayerDrawerScreen extends GetView<PDSController> {
  const PlayerDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GetBuilder<PDSController>(
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

  final PDSController controller;
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
              decoration: BoxDecoration(color: themeData.colorScheme.secondary.withAlpha(80)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PAScreen(), binding: PASBinding());
                      toggleDrawer.call();
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(Assets.imagesGamer),
                      radius: 32,
                      backgroundColor: Colors.transparent,
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
                    color: themeData.primaryColorDark,
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
