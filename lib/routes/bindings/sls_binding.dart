import 'package:get/get.dart';

import '../../controllers/organizer/sls_controller.dart';
import '../../models/tournament/tournament_event.dart';

class SLSBinding extends Bindings {
  // SLSBinding - SoloListScreenBinding
  final TournamentEvent? _tEvent;

  SLSBinding({required TournamentEvent? tEvent}) : _tEvent = tEvent;

  @override
  void dependencies() {
    Get.lazyPut(() => SLSController(tEvent: _tEvent));
  }
}
