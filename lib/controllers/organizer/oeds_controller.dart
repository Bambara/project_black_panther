import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_black_panther/models/common/avatar.dart';

import '../../core/app_export.dart';
import '../../models/common/organization.dart';
import '../../models/player/player_profile.dart';
import '../../models/tournament/event_team_assign.dart';
import '../../models/tournament/player_team.dart';
import '../../models/tournament/tournament_event.dart';

// OEDSController - OrganizerEventDashboardScreenController
class OEDSController extends GetxController {
  final TournamentEvent? tEvent;
  final List<Organization> clans, clubs;
  final List<PlayerProfile> playerProfiles;
  final List<PlayerTeam> playerTeams;

  OEDSController({
    required this.tEvent,
    required this.clans,
    required this.clubs,
    required this.playerProfiles,
    required this.playerTeams,
  });

  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final playerTeamCtrl = TextEditingController();

  File profileImage = File('');
  bool isSelected = false;
  bool _isOAOpen = false;

  bool loaded = false;
  bool splbsLoaded = true;
  bool playerTeamsLoaded = false;

  final List<EventTeamAssign> assignedTeams = [];
  final List<PlayerTeam> assignedPlayerTeams = [];

  //Player Team Names
  final List<String> ptNames = [''];

  PlayerTeam searchedTeam = PlayerTeam('', '', '', Avatar('', '', ''), '', '', '', [], '', '');

  // late Organizations clans, clubs;
  // late PlayerProfiles playerProfiles;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Log.i(tEvent?.toJson());
    getEventByTId();
  }

  @override
  void onReady() {
    try {
      _loadingData();
    } catch (e) {
      Log.e(e);
    }
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<File> pickProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Log.i('select');
      isSelected = true;
      return File(pickedFile.path);
    } else {
      isSelected = false;
      getImageFileFromAssets('images/01.jpg');
    }
    update();
    return File('');
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    update();
    return file;
  }

  bool get isOAOpen => _isOAOpen;

  set isOAOpen(bool value) {
    _isOAOpen = value;
    update(['organizerA', true]);
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

  void _loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true && executeList['api_02'] == true && executeList['api_03'] == true && executeList['api_04'] == true) {
      loaded = true;
      playerTeamsLoaded = true;
      update();
    }
  }

  void _loadingData() {
    try {
      /*_prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;
            executeList['api_02'] = false;
            executeList['api_03'] = false;
            executeList['api_04'] = false;

            _apiClient.getOrganizationsByType('Clan', 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                clans = (statusOrg['organizations'] as Organizations);

                executeList['api_01'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('Clans not found');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));

            _apiClient.getOrganizationsByType('Club', 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                clubs = (statusOrg['organizations'] as Organizations);

                executeList['api_02'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_02'] = true;
                Log.w('Clans not found');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));

            _apiClient.getAllTRegPlayers('Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                playerProfiles = (statusOrg['playerProfiles'] as PlayerProfiles);

                // Log.w(clubs.toJson());
                executeList['api_03'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('Players not found');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));

            _apiClient.getTRegisteredPlayerTeamsByTId(tEvent!.tournamentId, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                if (playerTeams.isNotEmpty) {
                  playerTeams.clear();
                }

                playerTeams.addAll(result!['playerTeams'] as List<PlayerTeam>);
                playerTeamsLoaded = true;
                executeList['api_04'] = true;
              } else if (result['status'].toString() == '404') {
                executeList['api_04'] = true;
                Log.w('No team data');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));
          } else {
            Fluttertoast.showToast(msg: 'Error : No Connection}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
        });
      });*/
    } catch (e) {
      Log.e(e);
    }
  }

  void getEventByTId() {
    try {} catch (e) {
      Log.e(e);
    }
  }

  void getAssignedPlayerTeams() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            _apiClient.getAllEventAssignPlayerTeamsByEventId(tEvent!.id, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                if (assignedTeams.isNotEmpty) {
                  assignedTeams.clear();
                }
                assignedTeams.addAll(result!['assigned_teams'] as List<EventTeamAssign>);

                if (assignedPlayerTeams.isNotEmpty) {
                  assignedPlayerTeams.clear();
                }

                for (var assignedTeam in assignedTeams) {
                  assignedPlayerTeams.add(playerTeams
                      .where((team) {
                        return team.id == assignedTeam.ptlId;
                      })
                      .toList()
                      .first);
                }

                loaded = true;
                playerTeamsLoaded = true;
                update();

                // playerTeamsLoaded = true;
                // update();
              } else if (result['status'].toString() == '404') {
                Log.w('No team data');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(
                  msg: 'Error : $onError}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.errorRed,
                  textColor: ColorConstant.darkBlack,
                  fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.yellow400,
                textColor: ColorConstant.darkBlack,
                fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(
              msg: 'Error : $onError}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorConstant.errorRed,
              textColor: ColorConstant.darkBlack,
              fontSize: 14);
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void getPlayerTeamNames() {
    try {
      ptNames.clear();
      ptNames.addAll(playerTeams.map((e) => e.name).toList());
    } catch (e) {
      Log.e(e);
    }
  }

  void searchPlayerTeamByName(String name) {
    try {
      searchedTeam = playerTeams
          .where((team) {
            // Log.i(name);
            return team.name == name;
          })
          .toList()
          .first;
      // Log.i(team.toJson());
    } catch (e) {
      Log.e(e);
    }
  }

  void assignPlayerTeam(BuildContext context) {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            final teamAssign = EventTeamAssign('', 'Enable', 'Green', searchedTeam.id, tEvent!.id, '', '');

            _apiClient.assignPlayerTeamToEvent(teamAssign, session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                if (assignedTeams.isNotEmpty) {
                  assignedTeams.clear();
                }
                assignedTeams.addAll(result!['assigned_teams'] as List<EventTeamAssign>);

                if (assignedPlayerTeams.isNotEmpty) {
                  assignedPlayerTeams.clear();
                }

                for (var assignedTeam in assignedTeams) {
                  assignedPlayerTeams.add(playerTeams
                      .where((team) {
                        return team.id == assignedTeam.ptlId;
                      })
                      .toList()
                      .first);
                }

                loaded = true;
                playerTeamsLoaded = true;
                // update();

                // playerTeamsLoaded = true;
                // update();
                // Navigator.of(context).pop(true);
                //update();

                Fluttertoast.showToast(
                    msg: '"${searchedTeam.name}" successfully assigned to event',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorConstant.greenTransparent,
                    textColor: ColorConstant.darkBlack,
                    fontSize: 14);
                Navigator.of(context).pop(true);
              }
            }).catchError((onError) {
              Fluttertoast.showToast(
                  msg: 'Error : $onError}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.errorRed,
                  textColor: ColorConstant.darkBlack,
                  fontSize: 14);
            }).whenComplete(() {});
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.yellow400,
                textColor: ColorConstant.darkBlack,
                fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(
              msg: 'Error : $onError}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorConstant.errorRed,
              textColor: ColorConstant.darkBlack,
              fontSize: 14);
        });
      }).catchError((onError) {
        Fluttertoast.showToast(
            msg: 'Error : $onError}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorConstant.errorRed,
            textColor: ColorConstant.darkBlack,
            fontSize: 14);
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void resignPlayerTeam(BuildContext context, EventTeamAssign teamAssign) {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            _apiClient
                .resignPlayerTeamToEvent(teamAssign.id, teamAssign.teId, teamAssign.ptlId, session.token)
                .then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    if (assignedTeams.isNotEmpty) {
                      assignedTeams.clear();
                    }
                    assignedTeams.addAll(result!['assigned_teams'] as List<EventTeamAssign>);

                    if (assignedPlayerTeams.isNotEmpty) {
                      assignedPlayerTeams.clear();
                    }

                    for (var assignedTeam in assignedTeams) {
                      assignedPlayerTeams.add(playerTeams
                          .where((team) {
                            return team.id == assignedTeam.ptlId;
                          })
                          .toList()
                          .first);
                    }

                    loaded = true;
                    playerTeamsLoaded = true;
                    // update();

                    // playerTeamsLoaded = true;
                    // update();
                    // Navigator.of(context).pop(true);
                    //update();
                    Navigator.of(context).pop(true);
                  }
                })
                .catchError((onError) {})
                .whenComplete(() {});
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.yellow400,
                textColor: ColorConstant.darkBlack,
                fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(
              msg: 'Error : $onError}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorConstant.errorRed,
              textColor: ColorConstant.darkBlack,
              fontSize: 14);
        });
      }).catchError((onError) {
        Fluttertoast.showToast(
            msg: 'Error : $onError}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorConstant.errorRed,
            textColor: ColorConstant.darkBlack,
            fontSize: 14);
      });
    } catch (e) {
      Log.e(e);
    }
  }
}
