import 'package:get/get.dart';

import '../../controllers/organizer/oeds_controller.dart';
import '../../models/common/organization.dart';
import '../../models/player/player_profile.dart';
import '../../models/tournament/player_team.dart';
import '../../models/tournament/tournament_event.dart';

class OEDSBinding extends Bindings {
  // OEDSBinding - OrganizerEventDashboardScreenBinding
  final TournamentEvent? _tEvent;
  final List<Organization> _clans, _clubs;
  final List<PlayerProfile> _playerProfiles;
  final List<PlayerTeam> _playerTeams;

  OEDSBinding({
    required TournamentEvent? tEvent,
    required List<Organization> clans,
    required List<Organization> clubs,
    required List<PlayerProfile> playerProfiles,
    required List<PlayerTeam> playerTeams,
  })  : _tEvent = tEvent,
        _clans = clans,
        _clubs = clubs,
        _playerProfiles = playerProfiles,
        _playerTeams = playerTeams;

  @override
  void dependencies() {
    Get.lazyPut(() => OEDSController(tEvent: _tEvent, clans: _clans, clubs: _clubs, playerProfiles: _playerProfiles, playerTeams: _playerTeams));
  }
}
