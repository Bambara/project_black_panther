import 'package:get/get.dart';

import '../../controllers/organizer/eas_controller.dart';
import '../../models/tournament/tournament.dart';

class OEASBinding extends Bindings {
  // OEASBinding - OrganizerEventAddScreenBinding

  final Tournament? _tournament;

  OEASBinding({required Tournament? tournament}) : _tournament = tournament;

  @override
  void dependencies() {
    Get.lazyPut(() => EventAddScreenController(tournament: _tournament));
  }
}
