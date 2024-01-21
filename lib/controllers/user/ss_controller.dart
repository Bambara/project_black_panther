import 'dart:io';

import 'package:get/get.dart';

import '../../api/rest/api_client.dart';

class SSController extends GetxController {
  final _apiClient = Get.find<ApiClient>();

  bool _isPlayer = false;
  bool _isTeamLeader = false;
  bool _isCoordinator = false;
  bool _isSpectator = false;

  String _perValue = 'Day';
  String _times = '0';
  String _hours = '0';

  bool _isPromotion = false;
  bool _isNews = false;
  bool _isTournament = false;

  File _profileImage = File('');
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    update();
  }

  File get profileImage => _profileImage;

  set profileImage(File value) {
    _profileImage = value;
    update();
  }

  bool get isPlayer => _isPlayer;

  bool get isPromotion => _isPromotion;

  set isPromotion(bool value) {
    _isPromotion = value;
    update();
  }

  set isPlayer(bool value) {
    _isPlayer = value;
    update();
  }

  bool get isTeamLeader => _isTeamLeader;

  set isTeamLeader(bool value) {
    _isTeamLeader = value;
    update();
  }

  bool get isSpectator => _isSpectator;

  set isSpectator(bool value) {
    _isSpectator = value;
    update();
  }

  bool get isCoordinator => _isCoordinator;

  set isCoordinator(bool value) {
    _isCoordinator = value;
    update();
  }

  String get perValue => _perValue;

  set perValue(String value) {
    _perValue = value;
    update();
  }

  String get times => _times;

  set times(String value) {
    _times = value;
    update();
  }

  String get hours => _hours;

  set hours(String value) {
    _hours = value;
    update();
  }

  bool get isNews => _isNews;

  set isNews(bool value) {
    _isNews = value;
    update();
  }

  bool get isTournament => _isTournament;

  set isTournament(bool value) {
    _isTournament = value;
    update();
  }
}
