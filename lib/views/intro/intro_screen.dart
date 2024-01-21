/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../user/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen_new';

  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;

  late List<Widget> slideList;

  late int initialPage;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
  }

  int initIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GFIntroScreen(
      color: Colors.grey,
      slides: slides(context, screenWidth, screenHeight, themeData),
      pageController: _pageController,
      currentIndex: initIndex,
      pageCount: 5,
      introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
        backButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        skipButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        forwardButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        doneButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        pageController: _pageController,
        pageCount: slideList.length,
        currentIndex: initialPage,
        onForwardButtonTap: () {
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
          // Logger().i(_pageController.page);
        },
        onBackButtonTap: () {
          _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
          // Logger().i(_pageController.page);
        },
        onDoneTap: () => Get.offAll(() => LoginScreen()),
        onSkipTap: () => Get.offAll(() => LoginScreen()),
        navigationBarColor: themeData.scaffoldBackgroundColor,
        showDivider: false,
        inactiveColor: Colors.grey,
        activeColor: GFColors.DANGER,
      ),
    );
  }

  List<Widget> slides(BuildContext context, double screenWidth, double screenHeight, ThemeData themeData) {
    slideList = [
      GFImageOverlay(
        width: screenWidth,
        padding: const EdgeInsets.all(16),
        color: Colors.orange,
        image: const AssetImage('assets/images/01.jpg'),
        boxFit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        borderRadius: BorderRadius.circular(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.03),
              child: Text(
                'Welcome!',
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: themeData.textTheme.headline2!.fontSize),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/02.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/03.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/04.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/05.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
    ];
    return slideList;
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/user/intro_controller.dart';
import '../user/login_screen.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  static const routeName = '/intro_screen_new';

  final _iC = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GFIntroScreen(
      color: Colors.grey,
      slides: slides(context, screenWidth, screenHeight, themeData),
      pageController: _iC.pageController,
      currentIndex: _iC.initIndex,
      pageCount: 5,
      introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
        backButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        skipButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        forwardButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        doneButtonTextStyle: TextStyle(color: themeData.primaryColor, fontSize: themeData.textTheme.caption!.fontSize, fontFamily: themeData.textTheme.caption!.fontFamily),
        pageController: _iC.pageController,
        pageCount: _iC.slideList.length,
        currentIndex: _iC.initialPage,
        onForwardButtonTap: () {
          _iC.pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
          // Logger().i(_pageController.page);
        },
        onBackButtonTap: () {
          _iC.pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
          // Logger().i(_pageController.page);
        },
        onDoneTap: () => Get.offAll(() => const LoginScreen()),
        onSkipTap: () => Get.offAll(() => const LoginScreen()),
        navigationBarColor: themeData.scaffoldBackgroundColor,
        showDivider: false,
        inactiveColor: Colors.grey,
        activeColor: GFColors.DANGER,
      ),
    );
  }

  List<Widget> slides(BuildContext context, double screenWidth, double screenHeight, ThemeData themeData) {
    _iC.slideList = [
      GFImageOverlay(
        width: screenWidth,
        padding: const EdgeInsets.all(16),
        color: Colors.orange,
        image: const AssetImage('assets/images/01.jpg'),
        boxFit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        borderRadius: BorderRadius.circular(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.03),
              child: Text(
                'Welcome!',
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: themeData.textTheme.headline2!.fontSize),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/02.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/03.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/04.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/05.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )),
      ),
    ];
    return _iC.slideList;
  }
}
