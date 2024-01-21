import 'package:get/get.dart';

import '../../controllers/user/fss_controller.dart';

class FSSBinding extends Bindings {
  final String _signupType;

  FSSBinding({required String signupType}) : _signupType = signupType;

  @override
  void dependencies() {
    Get.lazyPut(() => FSSController(signupType: _signupType));
  }
}
