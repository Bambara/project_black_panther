import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_export.dart';
import '../../models/common/address.dart';
import '../../models/common/avatar.dart';
import '../../models/common/contact.dart';
import '../../models/common/game.dart';
import '../../models/common/organization.dart';
import '../../models/common/organization_member.dart';
import '../../models/common/play_frequency.dart';
import '../../models/common/reminder_type.dart';
import '../../models/common/user_account_type.dart';
import '../../models/organizer/organizer_profile.dart';
import '../../models/player/player_profile.dart';
import '../../models/user/user_profile.dart';

class PASController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final fNameCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  final defaultIGNCtrl = TextEditingController();
  final clanCtrl = TextEditingController();
  final clubCtrl = TextEditingController();

  final gameNameCtrl = TextEditingController();
  final organizationCtrl = TextEditingController();

  bool isTeamLeader = false;
  bool isCoordinator = false;
  bool isSpectator = false;

  String perValue = 'Day';
  String perTimes = '0';
  String perHours = '0';

  bool isPromotion = false;
  bool isNews = false;
  bool isTournament = false;

  File upiFile = File('');
  String upiNetworkUrl = '';
  bool isUPIPicked = false;

  File ppiFile = File('');
  String ppiNetworkUrl = '';
  bool isPPIPicked = false;

  final List _profileCount = [];

  final List<String> clubNames = ['None'];
  final List<String> clanNames = ['None'];

  final List<Game> games = [];
  late Game selectedGame;
  bool isGameSelected = false;
  final List<String> gameNames = ['None'];

  late Organization organization;
  late PlayerProfile playerProfile;
  String organizationId = '';
  final List<Organization> organizations = [];
  late UserProfile userProfile;

  bool loading = false;

  @override
  void onReady() {
    getUserProfile();
    // getAllOrganizations();
  }

  void onChangedTeamLeader(bool value) {
    isTeamLeader = value;
    update(['tl', true]);
  }

  void onChangedCoordinator(bool value) {
    isCoordinator = value;
    update(['Coordinator', true]);
  }

  void onChangedSpectator(bool value) {
    isSpectator = value;
    update(['Spectator', true]);
  }

  void selectPerType(String per) {
    perValue = per;
    update(['per', true]);
  }

  void selectTimesValue(String times) {
    perTimes = times;
    update(['times', true]);
  }

  void selectHoursValue(String hours) {
    perHours = hours;
    update(['hours', true]);
  }

  void onChangedPromotion(bool value) {
    isPromotion = value;
    update(['Promotion', true]);
  }

  void onChangedNews(bool value) {
    isNews = value;
    update(['News', true]);
  }

  void onChangedTournament(bool value) {
    isTournament = value;
    update(['Tournament', true]);
  }

  void selectOrganization(String value) {
    // organizationName = value;
    getOrganizationByName();
  }

  Future<File> pickUserProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isUPIPicked = true;
      update(['upi', true]);
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
  }

  Future<File> pickPlayerProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isPPIPicked = true;
      update(['ppi', true]);
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
  }

  void _showLoaderDialog(BuildContext context) {
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

    // return dialogContext;
  }

  Future<HashMap<String, String>?> uploadAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
    if (isUPIPicked) {
      Log.i(upiFile.path);
      await _apiClient.uploadUserImage(upiFile, userNameCtrl.text).then((result) {
        avatarInfo = result;
        isUPIPicked = false;
      });
    } else if (userProfile.avatar.url.isNotEmpty) {
      Log.i(userProfile.avatar.url);
      avatarInfo['id'] = userProfile.avatar.cloudId;
      avatarInfo['name'] = userProfile.avatar.name;
      avatarInfo['url'] = userProfile.avatar.url;
    } else {
      avatarInfo['id'] = userNameCtrl.text;
      avatarInfo['url'] = '';
    }

    return avatarInfo;
  }

  loadReady(HashMap<String, bool> executeList) {
    if (executeList['api_01'] == true && executeList['api_02'] == true && executeList['api_03'] == true && executeList['api_04'] == true) {
      ppiFile = File('');

      defaultIGNCtrl.text = playerProfile.defaultIgn;
      ppiNetworkUrl = playerProfile.avatar.url;

      clubCtrl.text = organizations
          .where((org) {
            final id = org.id;
            final input = playerProfile.clubId;

            return id == (input);
          })
          .toList()
          .first
          .name;

      clanCtrl.text = organizations
          .where((org) {
            final id = org.id;
            final input = playerProfile.clanId;

            return id == (input);
          })
          .toList()
          .first
          .name;

      loading = true;
      //
      update(['tl', true]);
      update(['Coordinator', true]);
      update(['Spectator', true]);
      //
      update(['per', true]);
      update(['times', true]);
      update(['hours', true]);
      //
      update(['Promotion', true]);
      update(['News', true]);
      update(['Tournament', true]);
      //
      update(['club', true]);
      update(['clan', true]);
      //
      update();
    }
  }

  void getUserProfile() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            HashMap<String, bool> executeList = HashMap();

            executeList['api_01'] = false;
            executeList['api_02'] = false;
            executeList['api_03'] = false;
            executeList['api_04'] = false;

            _apiClient.getUserProfileById(session.id, 'Enable', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                userProfile = (status['user_profile'] as UserProfile);

                // Log.i(userProfile.toJson());

                fNameCtrl.text = userProfile.firstName;
                lNameCtrl.text = userProfile.lastName;
                userNameCtrl.text = userProfile.userName;
                emailCtrl.text = userProfile.email;
                mobileCtrl.text = userProfile.mobile;
                passwordCtrl.text = '';
                cPasswordCtrl.text = '';

                for (var element in userProfile.accountType) {
                  switch (element.type) {
                    case 'Team Leader':
                      {
                        isTeamLeader = element.status;
                      }
                      break;
                    case 'Coordinator':
                      {
                        isCoordinator = element.status;
                      }
                      break;
                    case 'Spectator':
                      {
                        isSpectator = element.status;
                      }
                      break;
                  }
                }

                for (var element in userProfile.playFrequency) {
                  switch (element.type) {
                    case 'Per':
                      {
                        perValue = element.value;
                      }
                      break;
                    case 'Times':
                      {
                        perTimes = element.value;
                      }
                      break;
                    case 'Hours':
                      {
                        perHours = element.value;
                      }
                      break;
                  }
                }

                for (var element in userProfile.reminderType) {
                  switch (element.type) {
                    case 'Promotion':
                      {
                        isPromotion = element.status;
                      }
                      break;
                    case 'News':
                      {
                        isNews = element.status;
                      }
                      break;
                    case 'Tournament':
                      {
                        isTournament = element.status;
                      }
                      break;
                  }
                }

                upiNetworkUrl = userProfile.avatar.url;
                upiFile = File('');

                executeList['api_01'] = true;
              } else if (status['status'].toString() == '401') {
                executeList['api_01'] = true;
                Log.w('User Name or Password is Invalid');
              }
              // update();
            }).catchError((onError) {
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => loadReady(executeList));

            _apiClient.getAllOrganizations('Enable', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organizations.clear();
                organizations.addAll((status['organizations']) as List<Organization>);

                // Log.w(organizations.organizations[0].name);

                clubNames.clear();
                // clubNames.add('None');

                clanNames.clear();
                // clanNames.add('None');

                for (var element in organizations) {
                  if (element.type == 'Club') {
                    clubNames.add(element.name);
                  }

                  if (element.type == 'Clan') {
                    clanNames.add(element.name);
                  }
                }

                executeList['api_02'] = true;
              } else if (status['status'].toString() == '404') {
                executeList['api_02'] = true;
                Log.w('Organizations not found');
              }
            }).catchError((onError) {
              // Log.e(onError);
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => loadReady(executeList));

            _apiClient.getPlayerProfileByUserId(session.id, session.token).then((status) {
              if (status!['status'].toString() == '200') {
                playerProfile = (status['player'] as PlayerProfile);

                executeList['api_03'] = true;
              } else if (status['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('Organizer not found');
              }
            }).catchError((onError) {
              Log.e(onError);
              Toaster.showErrorToast(onError.toString());
            }).whenComplete(() => loadReady(executeList));

            _apiClient.getAllGames('Enable', session.token).then((statusGame) {
              if (statusGame!['status'].toString() == '200') {
                // Log.w(statusSponsor['sponsors']);
                games.clear();
                games.addAll(statusGame['games'] as List<Game>);

                gameNames.clear();
                gameNames.addAll(games.map((game) {
                  return game.name;
                }));

                // for (var element in games) {
                //   gameNames.add(element.name);
                // }

                executeList['api_04'] = true;
              } else if (statusGame['status'].toString() == '404') {
                executeList['api_04'] = true;
                Log.w('Games not found');
              }
            }).catchError((onError) {
              Toaster.showErrorToast(onError);
            }).whenComplete(() => loadReady(executeList));
          }
        });
      });
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }

    // if (_userNameCtrl.text == 'o' && _passwordCtrl.text == 'o') {
    //   final gLogin = GenericLogin(_userNameCtrl.text, _passwordCtrl.text);
    //   Log.i(gLogin.toJson());
    //   Get.offAll(() => OrganizerDrawerScreen());
    // } else if (user == 'cus' && pass == 'cus123') {
    //   // Get.offAll(() => BuyerDrawerScreen());
    // }
  }

  void getAllOrganizations() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getAllOrganizations('ACTIVE', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                final organizations = (status['organizations']) as List<Organization>;

                Log.w(organizations[0].name);

                clubNames.clear();
                clubNames.add('None');

                clanNames.clear();
                clanNames.add('None');

                for (var element in organizations) {
                  if (element.type == 'Club') {
                    clubNames.add(element.name);
                  }

                  if (element.type == 'Clan') {
                    clanNames.add(element.name);
                  }
                }

                update();
              } else if (status['status'].toString() == '404') {
                Log.w('Organizations not found');
              }
            });
          }
        });
      });
    } catch (e) {
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

  Future<HashMap<String, String>?> uploadOrganizationAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
    // if (_isOrganizationProfileSelected) {
    //   Log.i(_organizationProfileImage.path);
    //   await _apiClient.uploadOrganizationProfileImage(_organizationProfileImage, organizationCtrl.text).then((result) {
    //     avatarInfo = result;
    //   });
    // } else {
    //   avatarInfo['id'] = organizationCtrl.text;
    //   avatarInfo['url'] = '';
    // }

    return avatarInfo;
  }

  void createOrganization(BuildContext context) {
    try {
      // BuildContext loaderDialog = _showLoaderDialog(context)!;
      _showLoaderDialog(context);

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            uploadOrganizationAvatar().then((avatarInfo) {
              final logo = Avatar(avatarInfo!['id'].toString(), organizationCtrl.text, avatarInfo['url'].toString());

              List<OrganizationMember> organizationMembers = [OrganizationMember('', '', session.id, 'ACTIVE')];

              Organization organization = Organization('', organizationCtrl.text, logo, '', 'ACTIVE', organizationMembers, '', '');

              _apiClient.createOrganization(organization, session.token).then((result) {
                if (result['status'].toString() == '201' || result['status'].toString() == '200') {
                  Navigator.pop(context, 0);
                  // Navigator.of(loaderDialog!, rootNavigator: true).pop('dialog');
                  final organizations = (result['organizations']) as List<Organization>;

                  // Log.w(organizations.organizations.last.name);

                  // _organizationNames.clear();
                  // _organizationNames.add('None');

                  for (var element in organizations) {
                    // _organizationNames.add(element.name);
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

  Future<HashMap<String, String>?> uploadOrganizerAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
    if (isPPIPicked) {
      Log.i(ppiFile.path);
      await _apiClient.uploadOrganizerProfileImage(ppiFile, defaultIGNCtrl.text).then((result) {
        avatarInfo = result;
        isPPIPicked = false;
      });
    } else if (playerProfile.avatar.url.isNotEmpty) {
      Log.i(playerProfile.avatar.url);
      avatarInfo['id'] = playerProfile.avatar.cloudId;
      avatarInfo['name'] = playerProfile.avatar.name;
      avatarInfo['url'] = playerProfile.avatar.url;
    } else {
      avatarInfo['id'] = defaultIGNCtrl.text;
      avatarInfo['url'] = '';
    }

    return avatarInfo;
  }

  void getOrganizationByName() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getOrganizationByName('', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organization = (status['organization'] as Organization);

                Log.i(organization.id);

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

  void createOrganizerProfile(BuildContext context) {
    try {
      // BuildContext loaderDialog = _showLoaderDialog(context)!;
      _showLoaderDialog(context);

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            uploadOrganizerAvatar().then((avatarInfo) {
              final logo = Avatar(avatarInfo!['id'].toString(), defaultIGNCtrl.text, avatarInfo['url'].toString());

              if (playerProfile.id.isEmpty) {
                OrganizerProfile organizerProfile = OrganizerProfile('', defaultIGNCtrl.text, '', logo, 'ACTIVE', organization.id, session.id, '', '', []);

                _apiClient.createOrganizerProfile(organizerProfile, session.token).then((result) {
                  if (result['status'].toString() == '201') {
                    Navigator.pop(context, 0);
                    final organizerProfile = (result['organizerProfile'] as OrganizerProfile);
                    GFToast.showToast('Organizer profile create successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);
                    update();

                    Log.i(organizerProfile.name);
                    Log.i('Organizations create success');
                  } else if (result['status'].toString() == '409') {
                    Navigator.pop(context, 0);
                    final organizerProfile = (result['organizerProfile'] as OrganizerProfile);
                    update();

                    GFToast.showToast('Organizer profile already exist', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appOrange);

                    Log.w(organizerProfile.name);
                    Log.w('Organizations name is already exist');
                  }
                });
              } else {
                // playerProfile.name = _organizerNameCtrl.text;
                // playerProfile.type = _organizerType;
                // playerProfile.avatar = logo;
                // playerProfile.status = 'ACTIVE';
                // playerProfile.organizationId = organization.id;
                // playerProfile.userId = session.id;
                // playerProfile.createdAt = '';
                // playerProfile.updatedAt = '';
                // playerProfile.organization = [];
                //
                // _apiClient.updateOrganizerProfile(playerProfile, playerProfile.id, session.token).then((result) {
                //   if (result['status'].toString() == '200') {
                //     Navigator.pop(context, 0);
                //     playerProfile = (result['organizerProfile'] as OrganizerProfile);
                //
                //     organizerProfileImage = File('');
                //     networkOrganizerProfileImage = playerProfile.avatar.url;
                //
                //     _organizerNameCtrl.text = playerProfile.name;
                //     organizerType = playerProfile.type;
                //     // organizationName = organizerProfile.organization[0].name;
                //
                //     organizationName = organizations
                //         .where((organization) {
                //           final id = organization.id;
                //           final input = playerProfile.organizationId;
                //
                //           return id.contains(input);
                //         })
                //         .toList()
                //         .first
                //         .name;
                //
                //     update();
                //
                //     GFToast.showToast('Organizer profile updated successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);
                //
                //     Log.i(playerProfile.name);
                //     Log.i('Organizations create success');
                //   } else if (result['status'].toString() == '404') {
                //     Navigator.pop(context, 0);
                //     update();
                //
                //     GFToast.showToast('Organizer profile not found', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appOrange);
                //
                //     Log.w(playerProfile.name);
                //     Log.w('Organizer Profile Not Found');
                //   }
                // });
              }
            });
          }
        });
      });
    } catch (e) {
      Navigator.pop(context, 0);
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

  void getPlayerProfileByUserId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getPlayerProfileByUserId(userProfile.id, session.token).then((status) {
              if (status!['status'].toString() == '200') {
                playerProfile = (status['player'] as PlayerProfile);

                Log.i('Player IGN : ${playerProfile.defaultIgn}');

                // update();
              } else if (status['status'].toString() == '404') {
                Log.w('Player not found');
              }
            });
          }
        });
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void updateUserProfile(BuildContext context) {
    try {
      _showLoaderDialog(context);

      final accountType = [
        UserAccountType('', 'Team Leader', isTeamLeader),
        UserAccountType('', 'Coordinator', isCoordinator),
        UserAccountType('', 'Spectator', isSpectator),
      ];

      final playFrequency = [
        PlayFrequency('', 'Per', '0'),
        PlayFrequency('', 'Times', '0'),
        PlayFrequency('', 'Hours', '0'),
      ];

      final reminderType = [
        ReminderType('', 'Promotion', isPromotion),
        ReminderType('', 'News', isNews),
        ReminderType('', 'Tournament', isTournament),
      ];
      final address = Address('', '', '', '', '', '');
      final contact = Contact('', '', '', '', '');

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            uploadAvatar().then((avatarInfo) {
              final avatar = Avatar(avatarInfo!['id'].toString(), avatarInfo['name'].toString(), avatarInfo['url'].toString());

              final playerSignup = UserProfile(
                session.id,
                fNameCtrl.text,
                lNameCtrl.text,
                userNameCtrl.text,
                emailCtrl.text,
                mobileCtrl.text,
                contact,
                address,
                cPasswordCtrl.text,
                'PREMIUM',
                'Enable',
                avatar,
                accountType,
                playFrequency,
                reminderType,
                'ACTIVE',
                '',
                '',
              );

              _apiClient.updateUserProfile(playerSignup, session.token).then((result) {
                if (result['status'].toString() == '200') {
                  final userProfile = (result['userProfile'] as UserProfile);
                  Log.i('User profile update success : ${userProfile.id}');
                } else {
                  Log.w('User profile update fail');
                }
                Navigator.pop(context, 0);
                update();
              });
            });
          }
        });
      });
    } on Error catch (e) {
      Log.e(e);
    }
  }

  List get profileCount => _profileCount;

  void selectGame(String name) {
    try {
      selectedGame = games
          .where((game) {
            final id = game.name;
            final input = name;
            isGameSelected = true;
            return id == (input);
          })
          .toList()
          .first;
      // Log.i(selectedGame.toJson());
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }
}
