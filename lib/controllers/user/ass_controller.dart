import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ASSController extends GetxController {
  final _userCtrl = TextEditingController();

  get userCtrl => _userCtrl;
}
