import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../config/drawer_item.dart';
import '../../core/utils/log.dart';
import '../../core/utils/pref_utils.dart';
import '../../routes/bindings/ls_binding.dart';
import '../../views/user/login_screen.dart';

class ODSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _zdc = ZoomDrawerController();
  String _screen = '';
  DrawerItem _item = DrawerItem('Dashboard', '');

  void toggleDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.toggle?.call();
    update();
  }

  void openDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.open?.call();
    update();
  }

  void closeDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.close?.call();
    update();
  }

  void logout() {
    try {
      _prefUtils.destroySession().then((value) => Get.offAll(const LoginScreen(), binding: LSBinding()));
    } catch (e) {
      Log.e(e);
    }
  }

  get screen => _screen;

  set screen(value) {
    _screen = value;
    update();
  }

  get zdc => _zdc;

  DrawerItem get item => _item;

  set item(DrawerItem value) {
    _item = value;
    update();
  }
}
