import 'package:get/get.dart';

import '../../controllers/organizer/otds_controller.dart';
import '../../models/tournament/tournament.dart';

class OTSBinding extends Bindings {
  // OTSBinding - OrganizerTournamentScreenBinding
  final Tournament? _tournament;

  @override
  void dependencies() {
    Get.lazyPut(() => OTDSController(tournament: _tournament));
  }

  OTSBinding({required Tournament? tournament}) : _tournament = tournament;
}
