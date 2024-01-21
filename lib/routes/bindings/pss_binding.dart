import 'package:get/get.dart';

import '../../controllers/user/pss_controller.dart';

class PSSBinding extends Bindings {
  final String _signupType;

  PSSBinding({required String signupType}) : _signupType = signupType;

  @override
  void dependencies() {
    Get.lazyPut(() => PSSController(signupType: _signupType));
  }
}
