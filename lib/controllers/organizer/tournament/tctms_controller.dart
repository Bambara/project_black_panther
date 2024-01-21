import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/app_export.dart';
import '../../../models/common/avatar.dart';
import '../../../models/common/organization.dart';
import '../../../models/player/player_profile.dart';
import '../../../models/tournament/event_team_assign.dart';
import '../../../models/tournament/player_team.dart';
import '../../../models/tournament/pt_member.dart';
import '../../../models/tournament/tournament.dart';
import '../../../models/tournament/tournament_event.dart';

//PTMSController - PlayerTeamManagementScreenController
class TCTMSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();
  final _apiClient = Get.find<ApiClient>();

  final teamNameCtrl = TextEditingController();
  final clanCtrl = TextEditingController();
  final clubCtrl = TextEditingController();
  final memberCtrl = TextEditingController();
  String teamCode = '';

  final Tournament? tournament;
  final PlayerTeam? playerTeam;

  File teamLogo = File('');
  bool isTeamLogoSelected = false;

  final List<String> teamTypeList = ["None", "Solo", "Duo", "Squad"];
  String teamType = 'None';

  List<PTMember> ptMembers = [];

  late Organization clan, club;
  late List<Organization> clans, clubs;
  List<String> clanNames = [''], clubNames = [''], memberNames = [''];

  // late PlayerProfiles playerProfiles;
  late List<PlayerProfile> playerProfiles;
  late PlayerProfile selectedPlayer;

  int leaderPosition = 0;

  // final Map<int, bool> isMemberEnable = {0: true};
  final List<bool> isMemberEnable = [true];

  final List<String> eventNameList = ['None'];
  String eventName = 'None';

  late List<TournamentEvent> tEvents;
  late TournamentEvent tEvent;
  late EventTeamAssign eventTeamAssign;
  late List<EventTeamAssign> eventAssignTeams = [];

  final List<bool> isEventEnable = [true];

  bool loading = false, isEnable = false;

  TCTMSController({
    required this.tournament,
    required this.playerTeam,
  });

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void onReady() {
    _loadingData();
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

  void _loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true && executeList['api_02'] == true && executeList['api_03'] == true && executeList['api_04'] == true && executeList['api_05'] == true) {
      loading = true;
      if (playerTeam != null) {
        // Log.i(playerTeam!.toJson());
        teamCode = playerTeam!.code;
        teamNameCtrl.text = playerTeam!.name;
        teamType = playerTeam!.teamType;

        clan = clans
            .where((clan) {
              // Log.i(player.defaultIgn);
              return clan.id == playerTeam!.clanId;
            })
            .toList()
            .first;
        clanCtrl.text = clan.name;

        club = clubs
            .where((club) {
              // Log.i(player.defaultIgn);
              return club.id == playerTeam!.clubId;
            })
            .toList()
            .first;
        clubCtrl.text = club.name;
        ptMembers = playerTeam!.members;

        int index = 0;
        isMemberEnable.clear();
        for (var member in ptMembers) {
          if (member.status == 'Enable') {
            isMemberEnable.add(true);
          } else {
            isMemberEnable.add(false);
          }

          if (member.isLeader) {
            leaderPosition = index;
          }
          ++index;
        }

        isEnable = playerTeam!.status == 'Enable' ? true : false;

        // update();
      }
      update();
    }
  }

  void _loadingData() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;
            executeList['api_02'] = false;
            executeList['api_03'] = false;
            executeList['api_04'] = false;
            executeList['api_05'] = false;

            _apiClient.getOrganizationsByType('Clan', 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                clans = (statusOrg['organizations']) as List<Organization>;

                // Log.w(clans.toJson());
                clanNames.clear();
                for (var clan in clans) {
                  clanNames.add(clan.name);
                }

                executeList['api_01'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('Clans not found');
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

            _apiClient.getOrganizationsByType('Club', 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                clubs = (statusOrg['organizations']) as List<Organization>;

                // Log.w(clubs.toJson());

                clubNames.clear();
                for (var club in clubs) {
                  clubNames.add(club.name);
                }
                executeList['api_02'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_02'] = true;
                Log.w('Clans not found');
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

            _apiClient.getAllTNotRegPlayers('Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                playerProfiles = (statusOrg['playerProfiles'] as List<PlayerProfile>);

                // Log.w(clubs.toJson());

                memberNames.clear();
                for (var profile in playerProfiles) {
                  memberNames.add(profile.defaultIgn);
                }
                executeList['api_03'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('Players not found');
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

            _apiClient.getEventsByTournamentId(tournament!.id, 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                tEvents = (statusOrg['t_events']) as List<TournamentEvent>;

                // Log.w(clubs.toJson());

                eventNameList.clear();
                eventNameList.add('None');
                for (var event in tEvents) {
                  eventNameList.add(event.eventName);
                }

                executeList['api_04'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_04'] = true;
                Log.w('Players not found');
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

            if (playerTeam == null) {
              executeList['api_05'] = true;
            } else {
              _apiClient.getAssignPlayerTeamsByPtlId(playerTeam!.id, 'Enable', session.token).then((statusOrg) {
                if (statusOrg!['status'].toString() == '200') {
                  eventAssignTeams = (statusOrg['playerTeams'] as List<EventTeamAssign>);

                  isEventEnable.clear();
                  for (var assignTeams in eventAssignTeams) {
                    // Log.w(assignTeams.toJson());
                    if (assignTeams.status == 'Enable') {
                      isEventEnable.add(true);
                    } else {
                      isEventEnable.add(false);
                    }
                  }

                  executeList['api_05'] = true;
                } else if (statusOrg['status'].toString() == '404') {
                  executeList['api_05'] = true;
                  Log.w('Players not found');
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
            }
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.errorRed,
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

  Future<File> pickTeamLogo() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Log.i('select');
      isTeamLogoSelected = true;
      return File(pickedFile.path);
    } else {
      isTeamLogoSelected = false;
      getImageFileFromAssets('images/01.jpg');
    }
    // update();
    return File('');
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // update();
    return file;
  }

  set teamLogoImg(File value) {
    teamLogo = value;
    update(['teamLogo'], true);
  }

  void selectTeamType(String value) {
    teamType = value;
    update(['teamType', true]);
    // update();
  }

  void selectEvent(String value) {
    eventName = value;
    update(['events', true]);
    // update();
  }

  void print(String val) {
    Log.i(val);
  }

  void getClanByName() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getOrganizationByName(clanCtrl.text, session.token).then((status) {
              if (status!['status'].toString() == '200') {
                clan = (status['organization'] as Organization);

                Log.i(clan.id);

                // update();
              } else if (status['status'].toString() == '404') {
                Log.w('Organization not found');
              }
            });
          }
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void addMember(String search) {
    try {
      var profile = playerProfiles
          .where((player) {
            return player.defaultIgn == search;
          })
          .toList()
          .first;

      if (ptMembers
          .where((player) {
            // Log.i(player.defaultIgn);
            return player.defaultIgn == search;
          })
          .toList()
          .isEmpty) {
        selectedPlayer = profile;
        final ptMember = PTMember('', false, '', 'Enable', profile.defaultIgn, profile.id);
        isMemberEnable.add(true);
        ptMembers.add(ptMember);
        // Log.i(isMemberEnable.toString());
        update(['ptMember', true]);
      }
    } catch (e) {
      Log.e(e);
    }
  }

  void assignEvent(String search) {
    try {
      final event = tEvents
          .where((player) {
            return player.eventName == search;
          })
          .toList()
          .first;

      if (eventAssignTeams.isEmpty) {
        final assign = EventTeamAssign('', 'Enable', 'Green', '', event.id, '', '');

        isEventEnable.add(true);
        eventAssignTeams.add(assign);
        for (var element in eventAssignTeams) {
          Log.i(element.toJson());
        }
      } else {
        if (eventAssignTeams
            .where((team) {
              // Log.i(player.defaultIgn);
              return team.teId == event.id;
            })
            .toList()
            .isEmpty) {
          final assign = EventTeamAssign('', 'Enable', 'Green', '', event.id, '', '');

          isEventEnable.add(true);
          eventAssignTeams.add(assign);
          for (var element in eventAssignTeams) {
            Log.i(element.toJson());
          }
        }
      }
      update(['assignEvents', true]);
    } catch (e) {
      Log.e(e);
    }
  }

  void removeMember(int index) {
    try {
      ptMembers.removeAt(index);
      isMemberEnable.removeAt(index);
      update(['ptMember', true]);
    } catch (e) {
      Log.e(e);
    }
  }

  void removeEvent(int index) {
    try {
      eventAssignTeams.removeAt(index);
      isEventEnable.removeAt(index);
      update(['assignEvents', true]);
    } catch (e) {
      Log.e(e);
    }
  }

  void onChangeStatus(bool value) {
    isEnable = value;
    update(['ptStatus', true]);
  }

  void onChangeMemberStatus(int position, bool value) {
    isMemberEnable[position] = value;
    value ? ptMembers[position].status = 'Enable' : ptMembers[position].status = 'Disable';
    update(['ptMember', true]);
  }

  void onChangeEventStatus(int position, bool value) {
    isEventEnable[position] = value;
    value ? eventAssignTeams[position].status = 'Enable' : eventAssignTeams[position].status = 'Disable';
    update(['assignEvents', true]);
  }

  void onChangedLeader(Object value, int position) {
    // leaderPosition = int.parse(value.toString());
    leaderPosition = position;
    // Log.i(value.toString());
    // Log.i(position);
    int index = 0;
    for (var member in ptMembers) {
      if (index == leaderPosition) {
        ptMembers[leaderPosition].isLeader = true;
      } else {
        ptMembers[index].isLeader = false;
      }
      ++index;
    }

    // for (var member in ptMembers) {
    //   Log.i(member.toJson());
    // }
    update(['ptMember', true]);
  }

  Future<HashMap<String, String>?> uploadTeamLogo(String prefix) async {
    HashMap<String, String>? wallArtInfo = HashMap();
    try {
      if (isTeamLogoSelected) {
        Log.i(teamLogo.path);
        await _apiClient.uploadPlayerTeamLogo(teamLogo, teamNameCtrl.text, prefix).then((result) {
          wallArtInfo = result;
        });
      } else {
        if (playerTeam != null) {
          wallArtInfo['id'] = playerTeam!.logo.name;
          wallArtInfo['url'] = playerTeam!.logo.url;
        } else {
          wallArtInfo['id'] = teamNameCtrl.text;
          wallArtInfo['url'] = '';
        }
      }
    } catch (e) {
      Log.e(e);
    }

    return wallArtInfo;
  }

  String getRandomString(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  void addPlayerTeam(BuildContext context) {
    try {
      _showLoaderDialog(context);
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            late Avatar teamLogo;
            uploadTeamLogo('pt').then((logo) {
              teamLogo = Avatar(logo!['id'].toString(), '${teamNameCtrl.text}_pt', logo['url'].toString());

              final clanId = clans
                  .where((clan) {
                    // Log.i(player.defaultIgn);
                    return clan.name == clanCtrl.text;
                  })
                  .toList()
                  .first
                  .id;

              final clubId = clubs
                  .where((club) {
                    // Log.i(player.defaultIgn);
                    return club.name == clubCtrl.text;
                  })
                  .toList()
                  .first
                  .id;

              // Log.w(jsonEncode({'eventTeamAssign': eventAssignTeams}));

              if (playerTeam == null) {
                final playerTeamNew = PlayerTeam('', teamNameCtrl.text, getRandomString(8), teamLogo, teamType, clanId, clubId, ptMembers, isEnable ? 'Enable' : 'Disable', tournament!.id);
                // Log.i(playerTeamNew.toJson());

                _apiClient.registerPlayerTeam(playerTeamNew, session.token).then((result) {
                  if (result!['status'].toString() == '201') {
                    // Log.w(statusSponsor['sponsors']);

                    final playerTeam = result!['playerTeam'] as PlayerTeam;
                    // Log.w(playerTeams.toJson());

                    assignPlayerTeam(context, playerTeam, session.token);

                    // Navigator.pop(context, 0);
                    // Get.back();
                  } else if (result['status'].toString() == '404') {
                    Log.w('No team data');
                    Navigator.pop(context, 0);
                  }
                });
              } else {
                final playerTeamUpdate =
                    PlayerTeam(playerTeam!.id, teamNameCtrl.text, playerTeam!.code, teamLogo, teamType, clanId, clubId, ptMembers, isEnable ? 'Enable' : 'Disable', tournament!.id);
                Log.i(playerTeamUpdate.toJson());

                _apiClient.updatePlayerTeam(playerTeamUpdate, session.token).then((result) {
                  if (result!['status'].toString() == '200') {
                    // Log.w(statusSponsor['sponsors']);

                    // final playerTeams = result!['playerTeams'] as PlayerTeams;
                    // Log.w(playerTeams.toJson());

                    Navigator.pop(context, 0);
                    Get.back();
                  } else if (result['status'].toString() == '404') {
                    Log.w('No team data');
                    Navigator.pop(context, 0);
                  }
                });
              }

              // Log.i(playerTeam.toJson());
            });
          } else {
            Fluttertoast.showToast(
                msg: 'Error : No Connection}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorConstant.errorRed,
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
      Navigator.pop(context, 0);
    }
  }

  void assignPlayerTeam(BuildContext context, PlayerTeam playerTeam, String token) {
    try {
      for (int i = 0; i < eventAssignTeams.length; ++i) {
        eventAssignTeams[i].ptlId = playerTeam.id;
      }

      _apiClient.assignPlayerTeamsToEvents(eventAssignTeams, 'Enable', token).then((result) {
        if (result!['status'].toString() == '200') {
          //Log.w(result['playerTeams']);

          //final playerTeams = result!['playerTeams'] as PlayerTeams;
          // Log.w(playerTeams.toJson());

          Navigator.pop(context, 0);
          Get.back();
        } else if (result['status'].toString() == '404') {
          Log.w('No team assign data');
          Navigator.pop(context, 0);
        }
      });
    } catch (e) {
      Log.e(e);
    }
  }
}
