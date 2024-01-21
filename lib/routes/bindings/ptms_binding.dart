import 'package:get/get.dart';

import '../../controllers/ptms_controller.dart';
import '../../models/tournament/player_team.dart';
import '../../models/tournament/tournament.dart';

class PTMSBinding extends Bindings {
  // OTSBinding - OrganizerTournamentScreenBinding
  final Tournament? _tournament;
  final PlayerTeam? _playerTeam;

  @override
  void dependencies() {
    Get.lazyPut(() => PTMSController(tournament: _tournament, playerTeam: _playerTeam));
  }

  PTMSBinding({
    required Tournament? tournament,
    required PlayerTeam? playerTeam,
  })  : _tournament = tournament,
        _playerTeam = playerTeam;
}
