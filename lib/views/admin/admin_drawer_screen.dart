import 'package:flutter/material.dart';
import 'package:project_black_panther/generated/assets.dart';

import '../../models/drawer_item.dart';
import '../../widgets/drawer_items.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/image_button_widget.dart';
import 'chat.dart';
import 'dashboard.dart';
import 'news_feed_screen.dart';
import 'point_system.dart';
import 'registration.dart';
import 'score_board.dart';
import 'settings.dart';
import 'shuffle.dart';
import 'streams.dart';
import 'tournaments.dart';

class AdminDrawerScreen extends StatefulWidget {
  static const routeName = '/admin_drawer_screen';

  const AdminDrawerScreen({Key? key}) : super(key: key);

  @override
  State<AdminDrawerScreen> createState() => _AdminDrawerScreenState();
}

class _AdminDrawerScreenState extends State<AdminDrawerScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDragging = false;
  late bool isDrawerOpen;
  DrawerItem item = DrawerItems.dashBoard as DrawerItem;

  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openDrawer() {
    setState(() {
      xOffset = 250;
      yOffset = 150;
      scaleFactor = 0.7;
      isDragging = true;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDragging = false;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        buildDrawer(),
        buildPage(context),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDrawer() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUserArea(),
          SizedBox(
            width: xOffset,
            child: DrawerWidget(
              onSelectedItem: (item) {
                //setState(() => this.item = item);
                closeDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserArea() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.06,
                  backgroundImage: const AssetImage('assets/images/person_outline.png'),
                  backgroundColor: Colors.grey.shade600,
                  child: Text('Test'[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Buddhika Prasanna', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Account Type : Admin', style: TextStyle(color: Colors.white, fontSize: 15)),
                    Text('Player IGN', style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageButtonWidget(
                  imagePath: Assets.iconsLogout,
                  function: () {
                    // Get.offAll(const IntroScreen());
                  },
                  isIcon: false,
                  iconData: Icons.adb,
                  iconSize: screenWidth * 0.04,
                  color: themeData.colorScheme.secondary,
                ),
              ],
            )
          ],
        ));
  }

  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        onTap: closeDrawer,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: Container(
                color: isDrawerOpen ? Colors.white12 : Theme.of(context).primaryColor,
                child: getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    if (DrawerItems.dashBoard == item) {
      return Dashboard(openDrawer: openDrawer);
    } else if (DrawerItems.tournaments == item) {
      return Tournaments(openDrawer: openDrawer);
    } else if (DrawerItems.newsFeed == item) {
      return NewsFeedScreen(openDrawer: openDrawer);
    } else if (DrawerItems.stream == item) {
      return Streams(openDrawer: openDrawer);
    } else if (DrawerItems.chat == item) {
      return Chat(openDrawer: openDrawer);
    } else if (DrawerItems.shuffle == item) {
      return Shuffle(openDrawer: openDrawer);
    } else if (DrawerItems.scoreBoard == item) {
      return ScoreBoard(openDrawer: openDrawer);
    } else if (DrawerItems.registration == item) {
      return Registration(openDrawer: openDrawer);
    } else if (DrawerItems.pointSystem == item) {
      return PointSystem(openDrawer: openDrawer);
    } else if (DrawerItems.settings == item) {
      return Settings(openDrawer: openDrawer);
    } else {
      return Dashboard(openDrawer: openDrawer);
    }
  }
}
