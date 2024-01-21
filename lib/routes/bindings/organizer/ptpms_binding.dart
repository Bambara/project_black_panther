import 'package:get/get.dart';

import '../../../controllers/organizer/tournament/ptpms_controller.dart';
import '../../../models/common/payment.dart';
import '../../../models/tournament/tournament.dart';

// TCTMSBinding - TournamentCoordinatorTeamManageScreenBinding
class PTPMSBinding extends Bindings {
  final Tournament? _tournament;
  final Payment? _payment;

  @override
  void dependencies() {
    Get.lazyPut(() => PTPMSController(tournament: _tournament, payment: _payment));
  }

  PTPMSBinding({
    required Tournament? tournament,
    required Payment? payment,
  })  : _tournament = tournament,
        _payment = payment;
}
