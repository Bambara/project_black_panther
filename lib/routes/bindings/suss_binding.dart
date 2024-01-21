import 'package:get/get.dart';

import '../../controllers/user/ss_controller.dart';

class SUSSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SSController());
  }
}
