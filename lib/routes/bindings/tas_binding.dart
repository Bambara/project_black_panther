import 'package:get/get.dart';

import '../../controllers/organizer/ta_controller.dart';
import '../../models/tournament/tournament.dart';

class TASBinding extends Bindings {
  // TASBinding - TournamentAddScreenBinding

  final Tournament? _tournament;

  TASBinding({required Tournament? tournament}) : _tournament = tournament;

  @override
  void dependencies() {
    Get.lazyPut(() => TournamentAddController(tournamentLoaded: _tournament));
  }
}
