import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../api/rest/api_client.dart';

class IntroController extends GetxController {
  final _apiClient = Get.find<ApiClient>();

  late PageController _pageController;

  late List<Widget> _slideList;

  late int _initialPage;

  int _initIndex = 0;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController(initialPage: 0);
    _initialPage = _pageController.initialPage;
  }

  int get initialPage => _initialPage;

  set initialPage(int value) {
    _initialPage = value;
    update();
  }

  List<Widget> get slideList => _slideList;

  set slideList(List<Widget> value) {
    _slideList = value;
    update();
  }

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
    update();
  }

  int get initIndex => _initIndex;

  set initIndex(int value) {
    _initIndex = value;
    update();
  }
}
