import 'package:get/get.dart';

import '../../controllers/organizer/ods_controller.dart';
import '../../controllers/player/pds_controller.dart';

/// Player drawer screen
class PDSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PDSController());
  }
}
