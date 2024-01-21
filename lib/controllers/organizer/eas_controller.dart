import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_black_panther/models/common/art_work.dart';
import 'package:project_black_panther/models/tournament/tournament_event.dart';

import '../../core/app_export.dart';
import '../../models/common/game.dart';
import '../../models/tournament/tournament.dart';

class EventAddScreenController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final nameCtrl = TextEditingController();

  final List<String> gameNameList = ['None'];
  String gameName = 'None';
  late List<Game> games;

  final List<String> eventTypeList = ["None", "Single", "Series"];
  String eventType = 'None';

  final List<String> teamTypeList = ["None", "Solo", "Duo", "Squad"];
  String teamType = 'None';

  final List<String> artTypeList = ["None", "Wall", "Other"];
  String artType = 'None';

  final Tournament? tournament;

  bool isArtWorkSelected = false;
  String artWorkPath = 'assets/images/user.png';
  late File pickedArtWork;
  final List<ArtWork> artWorks = [];

  bool loaded = false;

  EventAddScreenController({required this.tournament});

  @override
  void onInit() {
    super.onInit();
    _loadTournamentGames();
  }

  void selectGame(String value) {
    gameName = value;
    update(['gameName', true]);
  }

  void selectEventType(String value) {
    eventType = value;
    update(['eventType', true]);
  }

  void selectTeamType(String value) {
    teamType = value;
    update(['teamType', true]);
  }

  void selectArtType(String value) {
    artType = value;
    update();
  }

  void _loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true) {
      loaded = true;
      update(['gameName', true]);
    }
  }

  void _loadTournamentGames() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;

            final List<String> gameIds = [];

            for (var game in tournament!.tgList) {
              gameIds.add(game.gameId);
            }

            _apiClient.getGamesByIds(gameIds, session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                games = result['games'] as List<Game>;

                gameNameList.clear();
                gameNameList.add('None');

                for (var game in games) {
                  gameNameList.add(game.name);
                }

                executeList['api_01'] = true;
              } else if (result['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('No game data');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError);
            }).whenComplete(() => _loadReady(executeList));
          } else {
            Toaster.showErrorToast('Error : No Connection');
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError);
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void pickArtWork() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800).then((pickedFile) {
        if (pickedFile != null) {
          isArtWorkSelected = true;
          pickedArtWork = File(pickedFile.path);
          artWorkPath = pickedFile.path;
        }
      }).onError((error, stackTrace) {
        artWorkPath = 'assets/images/user.png';
        pickedArtWork = File(artWorkPath);
      }).whenComplete(() => update());
    } catch (e) {
      Log.e(e);
    }
  }

  void selectArtWork(BuildContext context) {
    try {
      artWorks.removeWhere((element) => element.name == '${nameCtrl.text}_$artType');
      artWorks.add(ArtWork('', '', '${nameCtrl.text}_$artType', artWorkPath));
      update(['tFDs', true]);
      // update();
      Navigator.of(context).pop();
    } catch (e) {
      Log.e(e);
    }
  }

  void removeArtWork(int index) {
    try {
      artWorks.removeAt(index);
      // update(['tFDs', true]);
      update(['tFDs', true]);
    } catch (e) {
      Log.e(e);
    }
  }

  Widget _showLoaderDialog(BuildContext context) {
    // BuildContext dialogContext;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Center(
            child: Container(
              color: Colors.transparent,
              height: height * 0.2,
              width: width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitFadingCircle(color: Colors.greenAccent, size: 50),
                  SizedBox(width: 10),
                  Text("Saving..."),
                ],
              ),
            ),
          );
        },
      ),
    );
    showDialog(
      context: context,
      builder: (context) {
        // dialogContext = context;
        return alert;
      },
    );

    return alert;
  }

  Future<HashMap<String, String>?> uploadEventArtWorks(String prefix) async {
    HashMap<String, String>? wallArtInfo = HashMap();
    try {
      if (isArtWorkSelected) {
        Log.i(artWorkPath);
        await _apiClient.uploadEventArtWorks(pickedArtWork, nameCtrl.text, prefix).then((result) {
          wallArtInfo = result;
        });
      } else {
        wallArtInfo['id'] = nameCtrl.text;
        wallArtInfo['url'] = '';
      }
    } catch (e) {
      Log.e(e);
    }

    return wallArtInfo;
  }

  void createEvent(BuildContext context) {
    try {
      _showLoaderDialog(context);
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;

            uploadEventArtWorks(artType).then((value) {
              Log.i(value?['url']);

              final event = TournamentEvent(
                  '',
                  nameCtrl.text,
                  eventType,
                  teamType,
                  artWorks,
                  'Enable',
                  games
                      .where((game) {
                        final name = game.name;
                        final input = gameName;

                        return name.contains(input);
                      })
                      .toList()
                      .first
                      .id,
                  tournament!.id,
                  '',
                  '');

              Log.w(event.toJson());

              _apiClient.createEvent(event, session.token).then((result) {
                if (result['status'].toString() == '201') {
                  // Log.w(statusSponsor['sponsors']);

                  final tournamentEvent = (result['t_events']) as List<TournamentEvent>;
                  // Log.w(tournamentEvent.toJson());

                  executeList['api_01'] = true;
                  Navigator.pop(context, 0);
                  Get.back();
                } else if (result['status'].toString() == '404') {
                  executeList['api_01'] = true;
                  Log.w('No game data');
                }
              }).catchError((onError) {
                Toaster.showErrorToast(onError);
              }).whenComplete(() => _loadReady(executeList));
            });
          } else {
            Toaster.showErrorToast('Error : No Connection');
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError);
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }
}
