import 'package:project_black_panther/controllers/init_controller.dart';

import '../app_export.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    // Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(Connectivity()));
    Get.put(InitController());
  }
}
