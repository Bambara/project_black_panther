import 'package:get/get.dart';

import '../../controllers/organizer/tls_controller.dart';

class OTLSBinding extends Bindings {
  // OTLSBinding - OrganizerTournamentListScreenBinding
  @override
  void dependencies() {
    Get.lazyPut(() => OTLSController());
  }
}
