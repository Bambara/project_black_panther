import 'package:flutter/widgets.dart';

import '../../core/app_export.dart';
import '../../models/solo_player_info.dart';

//ELSController - EventListScreenController
class ELSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  bool isChecked = false;

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
