import 'package:get/get.dart';

import '../../controllers/organizer/els_controller.dart';

class OELSBinding extends Bindings {
  // OELSBinding - OrganizerEventListScreenBinding
  @override
  void dependencies() {
    Get.lazyPut(() => ELSController());
  }
}
