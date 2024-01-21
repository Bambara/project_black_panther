import 'package:flutter/widgets.dart';

import '../../core/app_export.dart';
import '../../models/solo_player_info.dart';
import '../../models/tournament/tournament_event.dart';

class SLSController extends GetxController {
  final TournamentEvent? tEvent;

  bool isChecked = false;

  SLSController({required this.tEvent});

  List<SoloPlayerInfo> soloPlayer = [
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God')
  ];

  void addData(BuildContext context) {
    soloPlayer.add(SoloPlayerInfo(id: 2, ign: 'Sanju', name: 'Sanjaya', club: 'No', clan: 'God'));
  }

  void removePlayer() {
    soloPlayer.remove(soloPlayer.elementAt(1));
  }
}
