import 'package:get/get.dart';

import '../../controllers/user/ass_controller.dart';

class ASSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ASSController());
  }
}
