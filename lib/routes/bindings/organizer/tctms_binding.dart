import 'package:get/get.dart';

import '../../../controllers/organizer/tournament/tctms_controller.dart';
import '../../../models/tournament/player_team.dart';
import '../../../models/tournament/tournament.dart';

// TCTMSBinding - TournamentCoordinatorTeamManageScreenBinding
class TCTMSBinding extends Bindings {
  final Tournament? _tournament;
  final PlayerTeam? _playerTeam;

  @override
  void dependencies() {
    Get.lazyPut(() => TCTMSController(tournament: _tournament, playerTeam: _playerTeam));
  }

  TCTMSBinding({
    required Tournament? tournament,
    required PlayerTeam? playerTeam,
  })  : _tournament = tournament,
        _playerTeam = playerTeam;
}
