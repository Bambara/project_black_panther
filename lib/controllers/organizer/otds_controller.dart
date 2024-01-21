import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_black_panther/models/common/payment.dart';

import '../../core/app_export.dart';
import '../../models/common/organization.dart';
import '../../models/player/player_profile.dart';
import '../../models/tournament/player_team.dart';
import '../../models/tournament/tc_team.dart';
import '../../models/tournament/tournament.dart';
import '../../models/tournament/tournament_event.dart';

// OTDSController - OrganizerTournamentDashboardScreenController
class OTDSController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final nameCtrl = TextEditingController();

  File wallArt = File('');
  bool isSelected = false;
  bool _isOAOpen = false;

  final Tournament? tournament;
  List<TournamentEvent> tEvents = [];
  late List<PlayerTeam> playerTeams;

  String teamCode = '';

  final List<String> teamTypeList = ["None", "Solo", "Duo", "Squad"];
  String teamType = 'None';

  // late Organization clan, club;
  late List<Organization> clans, clubs;
  List<PlayerProfile> playerProfiles = [];

  bool loaded = false;
  bool playerTeamsLoaded = false;

  late List<TCTeam> tcTeams;
  bool tcTeamsLoaded = false;

  List<Payment> payments = [];
  bool paymentsLoaded = false;

  OTDSController({required this.tournament});

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
      update(['gameName', true]);
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

            _apiClient.getOrganizationsByType('Clan', 'Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                clans = (statusOrg['organizations']) as List<Organization>;
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

            _apiClient.getEventsByTournamentId(tournament!.id, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                tEvents = result['t_events'] as List<TournamentEvent>;
                // Log.w(tEvent.toJson());

                executeList['api_03'] = true;
              } else if (result['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('No game data');
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

            _apiClient.getAllTRegPlayers('Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                playerProfiles = (statusOrg['playerProfiles'] as List<PlayerProfile>);
                // Log.w(clubs.toJson());
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
          } else {
            Toaster.showErrorToast('No Connection');
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError);
        });
      });
    } catch (e) {
      Toaster.showErrorToast(e.toString());
      Log.e(e);
    }
  }

/*  void _getEventByTId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;

            _apiClient.getEventsByTournamentId(tournament!.id, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                tEvent = result!['t_events'] as TEvents;
                // Log.w(tEvent.toJson());

                executeList['api_01'] = true;
              } else if (result['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('No game data');
              }
            }).catchError((onError) {
              Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
            }).whenComplete(() => _loadReady(executeList));
          } else {
            Fluttertoast.showToast(msg: 'Error : No Connection}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.yellow400, textColor: ColorConstant.darkBlack, fontSize: 14);
          }
        }).catchError((onError) {
          Fluttertoast.showToast(msg: 'Error : $onError}', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: ColorConstant.errorRed, textColor: ColorConstant.darkBlack, fontSize: 14);
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }*/

  void getTRegisteredPlayerTeamsByTId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            _apiClient.getTRegisteredPlayerTeamsByTId(tournament!.id, 'Enable', session.token).then((result) {
              if (result!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);

                playerTeams = result['playerTeams'] as List<PlayerTeam>;
                playerTeamsLoaded = true;
                update();
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
      Toaster.showErrorToast(e.toString());
      Log.e(e);
    }
  }

  ///Get All Tournament Coordinator teams by tournament id.
  ///
  ///A async functions
  void getAllTCTeamsByTId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            // HashMap<String, bool> executeList = HashMap();

            _apiClient.getAllTCTeamsByTournamentId(tournament!.id, 'Enable', session.token).then((result) {
              if (result['status'].toString() == '200') {
                // Log.i((result['te_teams'] as List<TCTeam>).first.toJson());

                tcTeams = result['te_teams'] as List<TCTeam>;
                tcTeamsLoaded = true;
                update();
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(
              () {},
            );
          } else {
            Toaster.showErrorToast('Error : No Connection');
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  void selectTeamType(String value) {
    teamType = value;
    // update(['teamType', true]);
    update();
  }

  ///Get all payments of the player teams for tournaments.
  ///
  ///A async functions
  void getAllTournamentPayments() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            // HashMap<String, bool> executeList = HashMap();

            _apiClient.getTournamentPayments('All', session.token).then((result) {
              if (result['status'].toString() == '200') {
                payments = (result['payments']) as List<Payment>;
                paymentsLoaded = true;
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => update());
          } else {
            Toaster.showErrorToast('Error : No Connection');
          }
        }).catchError((onError) {
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Toaster.showErrorToast(e.toString());
      Log.e(e);
    }
  }

  ///Remove Tournament payments
  void removeTournamentPayment(String id) {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) async {
          if (connect == true) {
            // HashMap<String, bool> executeList = HashMap();

            _apiClient.removeTournamentPayment(id, session.token).then((statusTP) {
              if (statusTP['status'].toString() == '200') {
                payments = (statusTP['payments']) as List<Payment>;
                paymentsLoaded = true;
              } else if (statusTP['status'].toString() == '404') {
                Log.w('Payment not found');
              }
            }).catchError((onError) {
              Log.e(onError);
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => update());
          }
        }).catchError((onError) {
          Log.e(onError);
          Toaster.showErrorToast(onError.toString());
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }
}
