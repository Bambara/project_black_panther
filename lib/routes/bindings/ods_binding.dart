import 'package:get/get.dart';

import '../../controllers/organizer/ods_controller.dart';

class ODSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ODSController());
  }
}
