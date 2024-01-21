import 'package:get/get.dart';

import '../../controllers/user/login_controller.dart';

class LSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
