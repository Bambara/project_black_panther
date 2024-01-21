import 'package:get/get.dart';

import '../../../controllers/player/pas_controller.dart';

class PASBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PASController());
  }
}
