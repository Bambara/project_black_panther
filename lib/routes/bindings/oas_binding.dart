import 'package:get/get.dart';

import '../../controllers/organizer/oas_controller.dart';

class OASBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OASController());
  }
}
