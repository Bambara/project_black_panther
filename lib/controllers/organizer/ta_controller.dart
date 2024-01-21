import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/app_export.dart';
import '../../models/common/art_work.dart';
import '../../models/common/avatar.dart';
import '../../models/common/game.dart';
import '../../models/common/organization.dart';
import '../../models/common/organization_member.dart';
import '../../models/common/sponsor_profile.dart';
import '../../models/tournament/t_fd.dart';
import '../../models/tournament/t_game.dart';
import '../../models/tournament/tc_team.dart';
import '../../models/tournament/tc_team_member.dart';
import '../../models/tournament/tournament.dart';
import '../../models/tournament/tournament_organizer.dart';
import '../../models/tournament/tournament_sponsor.dart';
import '../../models/tournament/tt_group.dart';
import '../../models/tournament/tt_side.dart';
import '../../views/organizer/events_list_screen.dart';

class TournamentAddController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final _nameCtrl = TextEditingController();

  File _wallArt = File('');
  String wallArtNetworkUrl = '';
  bool _isWallArtSelected = false;

  int _type = 0;

  int _participantType = 0;

  String _startDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _startTime = '12:00 PM';
  String _endDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _endTime = '12:00 PM';
  String _regOpenDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _regOpenTime = '12:00 PM';
  String _regCloseDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _regCloseTime = '12:00 PM';

  File _organizationProfileImage = File('');
  String _networkOrganizationProfileImage = '';
  bool _isOrganizationProfileSelected = false;

  //Organization / Organizer
  final List<TournamentOrganizer> _tOrgs = [];
  final List<String> _organizerNames = [];
  String _organizationName = 'None';
  final List<String> _organizationNames = ['None'];
  late List<Organization> _organizations;

  final List<String> _status = ['Enable', 'Disable'];
  String _organizationStatus = 'Enable';

  final List<String> _organizerTypes = ['Default'];
  String _organizerType = 'Default';

  final List<String> _organizerRoles = ['Main', 'Media', 'Marketing'];
  String _organizerRole = 'Main';

  // Sponsor
  final List<TournamentSponsor> _tSponsors = [];
  final List<String> _sponsorNameList = [];
  String _sponsorName = 'None';
  final List<String> _sponsorNames = ['None'];
  late List<SponsorProfile> _sponsors;

  String _sponsorStatus = 'Enable';

  final List<String> _sponsorTypes = ['Default'];
  String _sponsorType = 'Default';

  final List<String> _sponsorCoverages = ['Main', 'Media', 'Marketing'];
  String _sponsorCoverage = 'Main';

  //Game
  final List<TGame> _tGames = [];
  final List<String> _gameNameList = [];
  String _gameName = 'None';
  final List<String> _gameNames = ['None'];
  late List<Game> _games;

  //
  final _organizerNameCtrl = TextEditingController();

  final _organizationCtrl = TextEditingController();

  String _organizationType = 'None';
  final List<String> _organizationTypes = ['None', 'Club', 'Clan', 'Other'];

  //T Team Groups
  final List<String> _teamGroupNames = [];
  final List<TTGroup> _teamGroups = [];
  final _ttgCodeCtrl = TextEditingController();
  final _ttgNameCtrl = TextEditingController();

  //T Team Sides
  final List<String> _teamSideNames = [];
  final List<TTSide> _teamSides = [];
  final _ttsSideCtrl = TextEditingController();
  final _ttsNameCtrl = TextEditingController();

  //Finance Details
  final List<String> _financeTypes = ['None', 'Default'];
  String _financeType = 'None';

  final List<String> _bankNames = [
    'None',
    'Amana Bank PLC',
    'Bank of Ceylon',
    'Bank of China Ltd',
    'Cargills Bank Ltd',
    'Commercial Bank of Ceylon PLC',
    'DFCC Bank PLC',
    'Hatton National Bank PLC',
    'National Development Bank PLC',
    'Nations Trust Bank PLC',
    'Pan Asia Banking Corporation PLC',
    "People's Bank",
    'Sampath Bank PLC',
    'Seylan Bank PLC',
    'Standard Chartered Bank',
    'Union Bank of Colombo PLC'
  ];
  String _bankName = 'None';

  final List<String> _branchNames = ['None'];
  String _branchName = 'None';

  final _tAccHolderCtrl = TextEditingController();
  final _tBankAccNumberCtrl = TextEditingController();

  final List<String> _tFD_Names = [];
  final List<TFinanceDetails> _tFDs = [];

  final Tournament? tournamentLoaded;

  bool _loading = false;

  TournamentAddController({required this.tournamentLoaded});

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
    if (executeList['api_01'] == true &&
        executeList['api_02'] == true &&
        executeList['api_03'] == true &&
        executeList['api_04'] == true &&
        executeList['api_05'] == true &&
        executeList['api_06'] == true) {
      loading = true;
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
            executeList['api_06'] = false;
            executeList['api_07'] = false;
            executeList['api_08'] = false;
            executeList['api_09'] = false;

            _apiClient.getAllOrganizations('Enable', session.token).then((statusOrg) {
              if (statusOrg!['status'].toString() == '200') {
                organizations = (statusOrg['organizations']) as List<Organization>;

                // Log.w(organizations.organizations[0].name);

                _organizationNames.clear();
                _organizationNames.add('None');

                for (var element in organizations) {
                  _organizationNames.add(element.name);
                }

                executeList['api_01'] = true;
              } else if (statusOrg['status'].toString() == '404') {
                executeList['api_01'] = true;
                Log.w('Organizations not found');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError);
            }).whenComplete(() => _loadReady(executeList));

            _apiClient.getAllSponsors('Enable', session.token).then((statusSponsor) {
              if (statusSponsor!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);
                sponsors = (statusSponsor['sponsors'] as List<SponsorProfile>);

                _sponsorNames.clear();
                _sponsorNames.add('None');

                for (var element in sponsors) {
                  _sponsorNames.add(element.name);
                }

                executeList['api_02'] = true;
              } else if (statusSponsor['status'].toString() == '404') {
                executeList['api_02'] = true;
                Log.w('Sponsors not found');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError);
            }).whenComplete(() => _loadReady(executeList));

            _apiClient.getAllGames('Enable', session.token).then((statusGame) {
              if (statusGame!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);
                games = (statusGame['games'] as List<Game>);

                _gameNames.clear();
                _gameNames.add('None');

                for (var element in games) {
                  _gameNames.add(element.name);
                }

                executeList['api_03'] = true;
              } else if (statusGame['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('Sponsors not found');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError);
            }).whenComplete(() => _loadReady(executeList));

            if (tournamentLoaded != null) {
              _nameCtrl.text = tournamentLoaded!.name;

              if (tournamentLoaded!.type == 'Single') {
                _type = 0;
              } else {
                _type = 1;
              }

              if (tournamentLoaded!.participantType == 'Solo') {
                _participantType = 0;
              } else if (tournamentLoaded!.participantType == 'Duo') {
                _participantType = 1;
              } else {
                _participantType = 2;
              }

              _startDate = tournamentLoaded!.startDate;
              _startTime = tournamentLoaded!.startTime;

              _endDate = tournamentLoaded!.endDate;
              _endTime = tournamentLoaded!.endTime;

              _regOpenDate = tournamentLoaded!.regOpenDate;
              _regOpenTime = tournamentLoaded!.regOpenTime;

              _regCloseDate = tournamentLoaded!.regCloseDate;
              _regCloseTime = tournamentLoaded!.regCloseTime;

              //Fill Organizer List
              _tOrgs.clear();
              _tOrgs.addAll(tournamentLoaded!.toList);

              final List<String> organizerIds = [];

              for (var organization in _tOrgs) {
                organizerIds.add(organization.organizationId);
              }
              // Log.w(organizerIds);
              _apiClient.getOrganizationByIds(organizerIds, session.token).then((statusOrg) {
                if (statusOrg!['status'].toString() == '200') {
                  organizations = (statusOrg['organizations']) as List<Organization>;

                  // Log.w(organizations.organizations[0].name);

                  _organizerNames.clear();

                  for (var element in organizations) {
                    _organizerNames.add(element.name);
                  }

                  executeList['api_04'] = true;
                } else if (statusOrg['status'].toString() == '404') {
                  executeList['api_04'] = true;
                  Log.w('Organizations not found');
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

              //Fill Sponsor List
              _tSponsors.clear();
              _tSponsors.addAll(tournamentLoaded!.tsList);

              final List<String> sponsorIds = [];

              for (var sponsor in _tSponsors) {
                sponsorIds.add(sponsor.sponsorId);
              }
              // Log.w(organizerIds);
              _apiClient.getSponsorsByIds(sponsorIds, session.token).then((statusSponsor) {
                if (statusSponsor!['status'].toString() == '200') {
                  sponsors = (statusSponsor['sponsors'] as List<SponsorProfile>);

                  // Log.w(organizations.organizations[0].name);

                  _sponsorNameList.clear();

                  for (var element in sponsors) {
                    _sponsorNameList.add(element.name);
                  }

                  executeList['api_05'] = true;
                } else if (statusSponsor['status'].toString() == '404') {
                  executeList['api_05'] = true;
                  Log.w('Sponsors not found');
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

              //Fill Game List
              _tGames.clear();
              _tGames.addAll(tournamentLoaded!.tgList);

              final List<String> gameIds = [];

              for (var game in _tGames) {
                gameIds.add(game.gameId);
              }
              // Log.w(organizerIds);
              _apiClient.getGamesByIds(gameIds, session.token).then((statusGame) {
                if (statusGame!['status'].toString() == '200') {
                  games = (statusGame['games'] as List<Game>);

                  // Log.w(organizations.organizations[0].name);

                  _gameNameList.clear();

                  for (var element in sponsors) {
                    _gameNameList.add(element.name);
                  }

                  executeList['api_06'] = true;
                } else if (statusGame['status'].toString() == '404') {
                  executeList['api_06'] = true;
                  Log.w('Sponsors not found');
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

              //Fill Team Groups List
              teamGroups.clear();
              for (var group in tournamentLoaded!.teamGroups) {
                teamGroupNames.add('${group.code} : ${group.name}');
                teamGroups.add(group);
              }

              //Fill Team Side List
              teamSides.clear();
              for (var side in tournamentLoaded!.teamSides) {
                teamSideNames.add('${side.side} : ${side.name}');
                teamSides.add(side);
              }

              //Fill Team Side List
              tFDs.addAll(tournamentLoaded!.financeDetails);
            } else {
              executeList['api_04'] = true;
              executeList['api_05'] = true;
              executeList['api_06'] = true;
              executeList['api_07'] = true;
              executeList['api_08'] = true;
              executeList['api_09'] = true;
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

  Future<File> pickWallArt() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        Log.i('select');
        _isWallArtSelected = true;
        return File(pickedFile.path);
      } else {
        _isWallArtSelected = false;
        getImageFileFromAssets('images/01.jpg');
      }
    } catch (e) {
      Log.e(e);
    }
    return File('');
  }

  Future<File> getImageFileFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load('assets/$path');

      final file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    } catch (e) {
      Log.e(e);
      return File('');
    }
  }

  Future<File> pickOrganizationProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isOrganizationProfileSelected = true;
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
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

  Future<HashMap<String, String>?> uploadOrganizationAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
    if (_isOrganizationProfileSelected) {
      Log.i(_organizationProfileImage.path);
      await _apiClient.uploadOrganizationProfileImage(_organizationProfileImage, _organizationCtrl.text).then((result) {
        avatarInfo = result;
      });
    } else {
      avatarInfo['id'] = _organizationCtrl.text;
      avatarInfo['url'] = '';
    }

    return avatarInfo;
  }

/*  void getOrganizationByName() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getOrganizationByName(organizationName, session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organization = (status['organization'] as Organization);

                Log.i(organization.id);

                update();
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
  }*/

  void createOrganization(BuildContext context) {
    try {
      // BuildContext loaderDialog = _showLoaderDialog(context)!;
      _showLoaderDialog(context);

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            uploadOrganizationAvatar().then((avatarInfo) {
              final logo = Avatar(avatarInfo!['id'].toString(), _organizationCtrl.text, avatarInfo['url'].toString());

              List<OrganizationMember> organizationMembers = [OrganizationMember('', '', session.id, 'ACTIVE')];

              Organization organization = Organization('', _organizationCtrl.text, logo, _organizationType, 'ACTIVE', organizationMembers, '', '');

              _apiClient.createOrganization(organization, session.token).then((result) {
                if (result['status'].toString() == '201' || result['status'].toString() == '200') {
                  Navigator.pop(context, 0);
                  // Navigator.of(loaderDialog!, rootNavigator: true).pop('dialog');
                  final organizations = (result['organizations']) as List<Organization>;

                  // Log.w(organizations.organizations.last.name);

                  _organizationNames.clear();
                  _organizationNames.add('None');

                  for (var element in organizations) {
                    _organizationNames.add(element.name);
                  }
                  GFToast.showToast('Organization create successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);
                  update();
                } else if (result['status'].toString() == '404') {
                  Navigator.pop(context);
                  Log.w('Organizations not found');
                }
              });
            });
          }
        });
      });
    } catch (e) {
      Navigator.pop(context);
      Log.e(e);
    }

    // if (_userNameCtrl.text == 'o' && _passwordCtrl.text == 'o') {
    //   final gLogin = GenericLogin(_userNameCtrl.text, _passwordCtrl.text);
    //   Log.i(gLogin.toJson());
    //   Get.offAll(() => OrganizerDrawerScreen());
    // } else if (user == 'cus' && pass == 'cus123') {
    //   // Get.offAll(() => BuyerDrawerScreen());
    // }
  }

  void onChangeType(Object value, int position) {
    type = position;
    update(['type'], true);
  }

  void onChangePType(Object value, int position) {
    participantType = position;
    update(['pType'], true);
  }

  void getStartDate(String date) {
    startDate = date;
    update(['startDate', true]);
  }

  void getStartTime(String time) {
    startTime = time;
    update(['startTime', true]);
  }

  void getEndDate(String date) {
    endDate = date;
    update(['endDate', true]);
  }

  void getEndTime(String time) {
    endTime = time;
    update(['endTime', true]);
  }

  void getRegOpenDate(String date) {
    regOpenDate = date;
    update(['regOpenDate', true]);
  }

  void getRegOpenTime(String time) {
    regOpenTime = time;
    update(['regOpenTime', true]);
  }

  void getRegCloseDate(String date) {
    regCloseDate = date;
    update(['regCloseDate'], true);
  }

  void getRegCloseTime(String time) {
    regCloseTime = time;
    update(['regCloseTime'], true);
  }

  void selectSponsor(String value) {
    sponsorName = value;
    update(['sponsorName'], true);
  }

  void selectSponsorType(String value) {
    sponsorType = value;
    update();
  }

  void selectSponsorCoverage(String value) {
    sponsorCoverage = value;
    update();
  }

  void selectSponsorStatus(String value) {
    sponsorStatus = value;
    update();
  }

  void addSponsor(BuildContext context) {
    sponsorNameList.add(sponsorName);
    // sponsorNameList.assignAll(sponsorNameList.toSet().toList());

    tSponsors.add(TournamentSponsor(
        '',
        sponsors
            .where((sponsor) {
              final name = sponsor.name;
              final input = sponsorName;

              return name.contains(input);
            })
            .toList()
            .first
            .id,
        sponsorType,
        sponsorCoverage,
        sponsorStatus));
    // tSponsors.assignAll(tSponsors.toSet().toList());
/*    for (var element in tSponsors) {
      Log.i(element.toJson());
    }*/
    update(['tSponsors', true]);
    Navigator.pop(context);
  }

  void selectGame(String value) {
    gameName = value;
    gameNameList.add(value);
    tGames.add(TGame(
        '',
        games
            .where((game) {
              final name = game.name;
              final input = gameName;

              return name.contains(input);
            })
            .toList()
            .first
            .id,
        'Enable'));
    for (var element in tGames) {
      Log.i(element.toJson());
    }
    update(['gameName'], true);
  }

  set removeGame(int index) {
    try {
      gameNameList.removeAt(index);
      Log.i(tGames.elementAt(index).toJson());
      tGames.removeAt(index);
      update(['gameName'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  // void selectOrganizer(String value) {
  //   // _organizer = value;
  //   _organizationName = value;
  //   // _organizers.add(value);
  //   getOrganizationByName();
  //   // update();
  // }

  void selectOrganization(String value) {
    organizationName = value;

    /* _organizers.add(organizations.organizations
        .where((organization) {
          final id = organization.name;
          final input = organizationName;

          return id.contains(input);
        })
        .toList()
        .first);*/
    update(['organizationName', true]);
    // getOrganizationByName();
  }

  void addOrganizer(BuildContext context) {
    organizerNames.add(organizationName);
    // organizerNames.assignAll(organizerNames.toSet().toList());

    tOrgs.add(TournamentOrganizer(
        organizationName,
        organizations
            .where((organization) {
              final name = organization.name;
              final input = organizationName;

              return name.contains(input);
            })
            .toList()
            .first
            .id,
        organizerType,
        organizerRole,
        organizationStatus));
    // tOrgs.assignAll(tOrgs.toSet().toList());
    // for (var element in tOrgs) {
    //   Log.i(element.toJson());
    // }
    update(['tOrg', true]);
    Navigator.pop(context);
  }

  void selectOrganizationType(String value) {
    organizationType = value;
    update();
  }

  void selectOrganizationStatus(String value) {
    organizationStatus = value;
    update();
  }

  void selectOrganizerType(String value) {
    organizerType = value;
    update();
  }

  void selectOrganizerRole(String value) {
    organizerRole = value;
    update();
  }

/*  set addOrganizer(String value) {
    _organizers.add(value);
    update();
  }*/

  set removeOrganizer(int index) {
    try {
      organizerNames.removeAt(index);
      // Log.i(tOrgs.elementAt(index).toJson());
      tOrgs.removeAt(index);
      update(['tOrg'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  void addTeamGroup(BuildContext context) {
    teamGroupNames.add('${_ttgCodeCtrl.text} : ${_ttgNameCtrl.text}');
    teamGroups.add(TTGroup('', _ttgCodeCtrl.text, _ttgNameCtrl.text, 'Enable'));
    _ttgCodeCtrl.text = '';
    _ttgNameCtrl.text = '';
    Navigator.pop(context);
    update(['teamGroupNames'], true);
  }

  set removeTeamGroup(int index) {
    try {
      teamGroupNames.removeAt(index);
      teamGroups.removeAt(index);
      update(['teamGroupNames'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  void addTeamSide(BuildContext context) {
    teamSideNames.add('${_ttsSideCtrl.text} : ${_ttsNameCtrl.text}');
    teamSides.add(TTSide('', _ttsSideCtrl.text, _ttsNameCtrl.text, 'Enable'));
    _ttsSideCtrl.text = '';
    _ttsNameCtrl.text = '';
    Navigator.pop(context);
    update(['teamSideNames'], true);
  }

  set removeTeamSide(int index) {
    try {
      teamSideNames.removeAt(index);
      teamSides.removeAt(index);
      update(['teamSideNames'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  void selectFinanceType(String value) {
    financeType = value;
    update();
  }

  void selectBank(String value) {
    bankName = value;
    update();
  }

  void selectBranch(String value) {
    branchName = value;
    update();
  }

  void addFinanceDetails(BuildContext context) {
    // tFD_Names.add('${bankName} : ${_ttsNameCtrl.text}');
    try {
      tFDs.add(TFinanceDetails('', financeType, bankName, branchName, _tBankAccNumberCtrl.text, _tAccHolderCtrl.text, 'Enable'));
      _tBankAccNumberCtrl.text = '';
      _tAccHolderCtrl.text = '';
      Navigator.pop(context);
      update(['tFDs'], true);
    } catch (e) {
      Log.e(e);
    }
  }

  Future<HashMap<String, String>?> uploadTournamentArtWork(String prefix) async {
    HashMap<String, String>? wallArtInfo = HashMap();
    try {
      if (_isWallArtSelected) {
        Log.i(wallArt.path);
        await _apiClient.uploadTournamentArtWork(wallArt, _nameCtrl.text, prefix).then((result) {
          wallArtInfo = result;
        });
      } else {
        wallArtInfo['id'] = _nameCtrl.text;
        wallArtInfo['url'] = '';
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

  void createTournament(BuildContext context) {
    try {
      _showLoaderDialog(context);

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;
            late ArtWork wallArt;
            uploadTournamentArtWork('wa').then((avatarInfo) {
              wallArt = ArtWork('', avatarInfo!['id'].toString(), '${_nameCtrl.text}_wa', avatarInfo['url'].toString());

              executeList['api_01'] = true;

              final String tType;
              if (type == 0) {
                tType = 'Single';
              } else {
                tType = 'Series';
              }

              final String tPType;
              if (participantType == 0) {
                tPType = 'Solo';
              } else if (participantType == 1) {
                tPType = 'Duo';
              } else {
                tPType = 'Squad';
              }

              final tcTeam = TCTeam('', getRandomString(6), getRandomString(6), Avatar('', '', ''), 'Master', 'Enable', [TCTeamMember('', session.id, 'Admin', 'Enable')]);

              String tournamentId = '';
              if (tournamentLoaded != null) {
                tournamentId = tournamentLoaded!.id;
              }

              final tournament = Tournament(tournamentId, _nameCtrl.text, startDate, startTime, endDate, endTime, regOpenDate, regOpenTime, regCloseDate, regCloseTime, [wallArt], tType, tPType,
                  'Schedule', tOrgs, tSponsors, [tcTeam], teamGroups, teamSides, tGames, tFDs, '', '');

              if (tournamentId == '') {
                _apiClient.createTournament(tournament, session.token).then((result) {
                  if (result['status'].toString() == '201') {
                    // Navigator.of(loaderDialog!, rootNavigator: true).pop('dialog');
                    final tournament = (result['tournament'] as Tournament);

                    // Log.w(tournament.name);

                    Navigator.pop(context, 0);
                    GFToast.showToast('Tournament create successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);
                    Get.to(() => const EventsListScreen());
                  } else if (result['status'].toString() == '404') {
                    Navigator.pop(context);
                    Log.w('Organizations not found');
                  }
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                }).whenComplete(() {});
              } else {
                _apiClient.updateTournament(tournament, session.token).then((result) {
                  if (result['status'].toString() == '200') {
                    // Navigator.of(loaderDialog!, rootNavigator: true).pop('dialog');
                    final tournament = (result['tournament'] as Tournament);

                    // Log.w(tournament.name);

                    Navigator.pop(context, 0);
                    GFToast.showToast('Tournament update successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);
                    // Get.to(() => const EventsListScreen());
                  } else if (result['status'].toString() == '404') {
                    Navigator.pop(context);
                    Log.w('Organizations not found');
                  }
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                }).whenComplete(() {});
              }
            });
          }
        });
      });
    } catch (e) {
      Navigator.pop(context);
      Log.e(e);
    }
  }

  set removeFinanceDetails(int index) {
    try {
      // teamSideNames.removeAt(index);
      tFDs.removeAt(index);
      update(['tFDs'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  List<String> get organizerNames => _organizerNames;

/*  set addSponsor(String value) {
    _sponsorNameList.add(value);
    update();
  }*/

  set removeSponsor(int index) {
    try {
      _sponsorNameList.removeAt(index);
      // Log.i(tSponsors.elementAt(index).toJson());
      tSponsors.removeAt(index);
      update(['tSponsors'], true);
    } catch (e) {
      Log.e(e);
      Fluttertoast.showToast(
          msg: 'Error : $e}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    }
  }

  List<String> get sponsorNameList => _sponsorNameList;

  bool get isWallArtSelected => _isWallArtSelected;

  set isWallArtSelected(bool value) {
    _isWallArtSelected = value;
    update();
  }

  File get wallArt => _wallArt;

  set wallArt(File value) {
    _wallArt = value;
    update(['wallArt'], true);
  }

  int get participantType => _participantType;

  set participantType(int value) {
    _participantType = value;
    //update();
  }

  int get type => _type;

  set type(int value) {
    _type = value;
    //update();
  }

  String get regCloseDate => _regCloseDate;

  set regCloseDate(String value) {
    _regCloseDate = value;
    // update();
  }

  String get regOpenDate => _regOpenDate;

  set regOpenDate(String value) {
    _regOpenDate = value;
    // update();
  }

  String get endDate => _endDate;

  set endDate(String value) {
    _endDate = value;
    // update();
  }

  String get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
    //update();
  }

/*  String get organizer => _organizer;

  set organizer(String value) {
    _organizer = value;
    update();
  }*/

/*  String get sponsor => _sponsor;

  set sponsor(String value) {
    _sponsor = value;
  }*/

/*  String get game => _game;

  set game(String value) {
    _game = value;
  }*/

  // List<String> get games => _gameList;

  get logger => Log;

  get nameCtrl => _nameCtrl;

  bool get isOrganizationProfileSelected => _isOrganizationProfileSelected;

  set isOrganizationProfileSelected(bool value) {
    _isOrganizationProfileSelected = value;
    update();
  }

  String get networkOrganizationProfileImage => _networkOrganizationProfileImage;

  set networkOrganizationProfileImage(String value) {
    _networkOrganizationProfileImage = value;
  }

  File get organizationProfileImage => _organizationProfileImage;

  set organizationProfileImage(File value) {
    _organizationProfileImage = value;
  }

  get organizationCtrl => _organizationCtrl;

  get organizerNameCtrl => _organizerNameCtrl;

  List<String> get organizationTypes => _organizationTypes;

/*  set organizationTypes(List<String> value) {
    _organizationTypes = value;
  }*/

  String get organizationType => _organizationType;

  set organizationType(String value) {
    _organizationType = value;
  }

  List<String> get organizationNames => _organizationNames;

/*  set organizationNames(List<String> value) {
    _organizationNames = value;
  }*/

  String get organizationName => _organizationName;

  set organizationName(String value) {
    _organizationName = value;
  }

/*  Organization get organization => _organization;

  set organization(Organization value) {
    _organization = value;
  }*/

  List<Organization> get organizations => _organizations;

  set organizations(List<Organization> value) {
    _organizations = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    update();
  }

  List<String> get sponsorNames => _sponsorNames;

  String get sponsorName => _sponsorName;

  set sponsorName(String value) {
    _sponsorName = value;
  }

  List<SponsorProfile> get sponsors => _sponsors;

  set sponsors(List<SponsorProfile> value) {
    _sponsors = value;
  }

  List<String> get gameNames => _gameNames;

/*  set gameNames(List<String> value) {
    _gameNames = value;
  }*/

  String get gameName => _gameName;

  set gameName(String value) {
    _gameName = value;
  }

  List<String> get gameNameList => _gameNameList;

/*  set gameList(List<String> value) {
    _gameList = value;
  }*/

  List<Game> get games => _games;

  set games(List<Game> value) {
    _games = value;
  }

  String get startTime => _startTime;

  set startTime(String value) {
    _startTime = value;
  }

  String get regCloseTime => _regCloseTime;

  set regCloseTime(String value) {
    _regCloseTime = value;
  }

  String get regOpenTime => _regOpenTime;

  set regOpenTime(String value) {
    _regOpenTime = value;
  }

  String get endTime => _endTime;

  set endTime(String value) {
    _endTime = value;
  }

  List<TTGroup> get teamGroups => _teamGroups;

  List<String> get teamGroupNames => _teamGroupNames;

  get ttgNameCtrl => _ttgNameCtrl;

  get ttgCodeCtrl => _ttgCodeCtrl;

  get ttsNameCtrl => _ttsNameCtrl;

  get ttsSideCtrl => _ttsSideCtrl;

  List<TTSide> get teamSides => _teamSides;

  List<String> get teamSideNames => _teamSideNames;

  String get organizationStatus => _organizationStatus;

  set organizationStatus(String value) {
    _organizationStatus = value;
  }

  List<String> get status => _status;

  String get organizerType => _organizerType;

  set organizerType(String value) {
    _organizerType = value;
  }

  List<String> get organizerTypes => _organizerTypes;

  String get organizerRole => _organizerRole;

  set organizerRole(String value) {
    _organizerRole = value;
  }

  List<String> get organizerRoles => _organizerRoles;

  List<TournamentOrganizer> get tOrgs => _tOrgs;

  List<TournamentSponsor> get tSponsors => _tSponsors;

  String get sponsorCoverage => _sponsorCoverage;

  set sponsorCoverage(String value) {
    _sponsorCoverage = value;
  }

  List<String> get sponsorCoverages => _sponsorCoverages;

  String get sponsorType => _sponsorType;

  set sponsorType(String value) {
    _sponsorType = value;
  }

  List<String> get sponsorTypes => _sponsorTypes;

  String get sponsorStatus => _sponsorStatus;

  set sponsorStatus(String value) {
    _sponsorStatus = value;
  }

  List<TGame> get tGames => _tGames;

  String get financeType => _financeType;

  set financeType(String value) {
    _financeType = value;
  }

  List<String> get financeTypes => _financeTypes;

  String get bankName => _bankName;

  set bankName(String value) {
    _bankName = value;
  }

  List<String> get bankNames => _bankNames;

  String get branchName => _branchName;

  set branchName(String value) {
    _branchName = value;
  }

  List<String> get branchNames => _branchNames;

  get tBankAccNumberCtrl => _tBankAccNumberCtrl;

  get tAccHolderCtrl => _tAccHolderCtrl;

  List<TFinanceDetails> get tFDs => _tFDs;

  List<String> get tFD_Names => _tFD_Names;
}
