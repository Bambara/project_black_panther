import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_export.dart';
import '../../models/common/address.dart';
import '../../models/common/avatar.dart';
import '../../models/common/contact.dart';
import '../../models/common/organization.dart';
import '../../models/common/organization_member.dart';
import '../../models/common/play_frequency.dart';
import '../../models/common/reminder_type.dart';
import '../../models/common/user_account_type.dart';
import '../../models/organizer/organizer_profile.dart';
import '../../models/user/user_profile.dart';

class OASController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();

  final _apiClient = Get.find<ApiClient>();

  final _fNameCtrl = TextEditingController();
  final _lNameCtrl = TextEditingController();
  final _userNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _cPasswordCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();

  final _organizerNameCtrl = TextEditingController();

  final _organizationCtrl = TextEditingController();

  bool _isOrganizer = false;
  bool _isSponsor = false;
  bool _isClubOwner = false;

  bool _isPromotion = false;
  bool _isNews = false;
  bool _isTournament = false;

  File _userProfileImage = File('');
  String _networkUserProfileImage = '';
  bool _isUserProfileSelected = false;

  File _organizerProfileImage = File('');
  String _networkOrganizerProfileImage = '';
  bool _isOrganizerProfileSelected = false;

  File _organizationProfileImage = File('');
  String _networkOrganizationProfileImage = '';
  bool _isOrganizationProfileSelected = false;

  final List _profileCount = [];

  String _organizationName = 'None';
  final List<String> _organizationNames = ['None'];

  String _organizationType = 'None';
  final List<String> _organizationTypes = ['None', 'Club', 'Clan', 'Other'];

  String _organizerType = 'None';
  final List<String> _organizerTypes = ['None', 'Default'];

  late Organization _organization;
  late OrganizerProfile _organizerProfile;
  String _organizationId = '';
  late List<Organization> _organizations;
  late UserProfile _userProfile;

  // final List<String> _organizers = [];

  bool _loading = false;

  @override
  void onReady() {
    getUserProfile();
    // getAllOrganizations();
  }

  void onChangedOrganizer(bool value) {
    isOrganizer = value;
  }

  void onChangedSponsor(bool value) {
    isSponsor = value;
  }

  void onChangedClubOwner(bool value) {
    isClubOwner = value;
  }

  void onChangedPromotion(bool value) {
    isPromotion = value;
  }

  void onChangedNews(bool value) {
    isNews = value;
  }

  void onChangedTournament(bool value) {
    isTournament = value;
  }

  void selectOrganization(String value) {
    organizationName = value;
    getOrganizationByName();
  }

  void selectOrganizerType(String value) {
    organizerType = value;
  }

  void selectOrganizationType(String value) {
    organizationType = value;
  }

  Future<File> pickUserProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isUserProfileSelected = true;
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
  }

  Future<File> pickOrganizerProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isOrganizerProfileSelected = true;
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
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
    if (isUserProfileSelected) {
      Log.i(_userProfileImage.path);
      await _apiClient.uploadUserImage(_userProfileImage, _userNameCtrl.text).then((result) {
        avatarInfo = result;
        isUserProfileSelected = false;
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
    if (executeList['api_01'] == true && executeList['api_02'] == true && executeList['api_03'] == true) {
      loading = true;
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

            _apiClient.getUserProfileById(session.id, 'Enable', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                userProfile = (status['user_profile'] as UserProfile);

                // Log.i(userProfile.toJson());

                _fNameCtrl.text = userProfile.firstName;
                _lNameCtrl.text = userProfile.lastName;
                _userNameCtrl.text = userProfile.userName;
                _emailCtrl.text = userProfile.email;
                _mobileCtrl.text = userProfile.mobile;
                _passwordCtrl.text = '';
                _cPasswordCtrl.text = '';

                for (var element in userProfile.accountType) {
                  switch (element.type) {
                    case 'Organizer':
                      {
                        isOrganizer = element.status;
                      }
                      break;
                    case 'Sponsor':
                      {
                        isSponsor = element.status;
                      }
                      break;
                    case 'Club Owner':
                      {
                        isClubOwner = element.status;
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

                networkUserProfileImage = userProfile.avatar.url;
                userProfileImage = File('');

                executeList['api_01'] = true;
              } else if (status['status'].toString() == '401') {
                executeList['api_01'] = true;
                Log.w('User Name or Password is Invalid');
              }
              // update();
            }).catchError((onError) {
              Fluttertoast.showToast(
                  msg: 'Error : $onError}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.errorRed,
                  textColor: ColorConstant.darkBlack,
                  fontSize: 14);
            }).whenComplete(() => loadReady(executeList));

            _apiClient.getAllOrganizations('Enable', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organizations = (status['organizations']) as List<Organization>;

                // Log.w(organizations.organizations[0].name);

                _organizationNames.clear();
                _organizationNames.add('None');

                for (var element in organizations) {
                  _organizationNames.add(element.name);
                }

                executeList['api_02'] = true;
              } else if (status['status'].toString() == '404') {
                executeList['api_02'] = true;
                Log.w('Organizations not found');
              }
            }).catchError((onError) {
              // Log.e(onError);
              Fluttertoast.showToast(
                  msg: 'Error : $onError}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.errorRed,
                  textColor: ColorConstant.darkBlack,
                  fontSize: 14);
            }).whenComplete(() => loadReady(executeList));

            _apiClient.getOrganizerProfileByUserId(session.id, session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organizerProfile = (status['organizer'] as OrganizerProfile);

                organizerProfileImage = File('');
                networkOrganizerProfileImage = organizerProfile.avatar.url;

                _organizerNameCtrl.text = organizerProfile.name;
                organizerType = organizerProfile.type;
                // organizationName = organizerProfile.organization[0].name;

                organizationName = organizations
                    .where((organization) {
                      final id = organization.id;
                      final input = organizerProfile.organizationId;

                      return id.contains(input);
                    })
                    .toList()
                    .first
                    .name;
                executeList['api_03'] = true;

                //GFToast.showToast('Profile successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);

                // Log.i('Organizer Name : ${organizerProfile.name}');

                // update();
              } else if (status['status'].toString() == '404') {
                executeList['api_03'] = true;
                Log.w('Organizer not found');
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
            }).whenComplete(() => loadReady(executeList));
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

  void getAllOrganizations() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getAllOrganizations('ACTIVE', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                final organizations = (status['organizations']) as List<Organization>;

                Log.w(organizations[0].name);

                _organizationNames.clear();
                _organizationNames.add('None');

                for (var element in organizations) {
                  _organizationNames.add(element.name);
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

  /*void updateOrganizerProfile() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getAllOrganizations('Active', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                final organizations = (status['organizations'] as Organizations);

                // Log.w(organizations.organizations[0].name);

                _organizationNames.clear();
                _organizationNames.add('None');

                for (var element in organizations.organizations) {
                  _organizationNames.add(element.name);
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
  }*/

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

  Future<HashMap<String, String>?> uploadOrganizerAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
    if (isOrganizerProfileSelected) {
      Log.i(_organizerProfileImage.path);
      await _apiClient.uploadOrganizerProfileImage(_organizerProfileImage, _organizerNameCtrl.text).then((result) {
        avatarInfo = result;
        isOrganizerProfileSelected = false;
      });
    } else if (organizerProfile.avatar.url.isNotEmpty) {
      Log.i(organizerProfile.avatar.url);
      avatarInfo['id'] = organizerProfile.avatar.cloudId;
      avatarInfo['name'] = organizerProfile.avatar.name;
      avatarInfo['url'] = organizerProfile.avatar.url;
    } else {
      avatarInfo['id'] = _organizerNameCtrl.text;
      avatarInfo['url'] = '';
    }

    return avatarInfo;
  }

  void getOrganizationByName() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getOrganizationByName(organizationName, session.token).then((status) {
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
              final logo = Avatar(avatarInfo!['id'].toString(), _organizerNameCtrl.text, avatarInfo['url'].toString());

              if (organizerProfile.id.isEmpty) {
                OrganizerProfile organizerProfile = OrganizerProfile('', _organizerNameCtrl.text, _organizerType, logo, 'ACTIVE', organization.id, session.id, '', '', []);

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
                organizerProfile.name = _organizerNameCtrl.text;
                organizerProfile.type = _organizerType;
                organizerProfile.avatar = logo;
                organizerProfile.status = 'ACTIVE';
                organizerProfile.organizationId = organization.id;
                organizerProfile.userId = session.id;
                organizerProfile.createdAt = '';
                organizerProfile.updatedAt = '';
                organizerProfile.organization = [];

                _apiClient.updateOrganizerProfile(organizerProfile, organizerProfile.id, session.token).then((result) {
                  if (result['status'].toString() == '200') {
                    Navigator.pop(context, 0);
                    organizerProfile = (result['organizerProfile'] as OrganizerProfile);

                    organizerProfileImage = File('');
                    networkOrganizerProfileImage = organizerProfile.avatar.url;

                    _organizerNameCtrl.text = organizerProfile.name;
                    organizerType = organizerProfile.type;
                    // organizationName = organizerProfile.organization[0].name;

                    organizationName = organizations
                        .where((organization) {
                          final id = organization.id;
                          final input = organizerProfile.organizationId;

                          return id.contains(input);
                        })
                        .toList()
                        .first
                        .name;

                    update();

                    GFToast.showToast('Organizer profile updated successfully', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appGreen);

                    Log.i(organizerProfile.name);
                    Log.i('Organizations create success');
                  } else if (result['status'].toString() == '404') {
                    Navigator.pop(context, 0);
                    update();

                    GFToast.showToast('Organizer profile not found', context, toastPosition: GFToastPosition.BOTTOM, backgroundColor: ColorConstant.appOrange);

                    Log.w(organizerProfile.name);
                    Log.w('Organizer Profile Not Found');
                  }
                });
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

  void getOrganizerProfileByUserId() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.getOrganizerProfileByUserId('userProfile.id', session.token).then((status) {
              if (status!['status'].toString() == '200') {
                organizerProfile = (status['organizer'] as OrganizerProfile);

                Log.i('Organizer Name : ${organizerProfile.name}');

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

  void updateUserProfile(BuildContext context) {
    try {
      _showLoaderDialog(context);

      final accountType = [
        UserAccountType('', 'Organizer', _isOrganizer),
        UserAccountType('', 'Sponsor', _isSponsor),
        UserAccountType('', 'Club Owner', _isClubOwner),
      ];

      final playFrequency = [
        PlayFrequency('', 'Per', '0'),
        PlayFrequency('', 'Times', '0'),
        PlayFrequency('', 'Hours', '0'),
      ];

      final reminderType = [
        ReminderType('', 'Promotion', _isPromotion),
        ReminderType('', 'News', _isNews),
        ReminderType('', 'Tournament', _isTournament),
      ];
      final address = Address('', '', '', '', '', '');
      final contact = Contact('', '', '', '', '');

      _prefUtils.getLoggingSession().then((session) {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            uploadAvatar().then((avatarInfo) {
              final avatar = Avatar(avatarInfo!['id'].toString(), avatarInfo!['name'].toString(), avatarInfo['url'].toString());

              final playerSignup = UserProfile(
                session.id,
                _fNameCtrl.text,
                _lNameCtrl.text,
                _userNameCtrl.text,
                _emailCtrl.text,
                _mobileCtrl.text,
                contact,
                address,
                _cPasswordCtrl.text,
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

  String get networkUserProfileImage => _networkUserProfileImage;

  set networkUserProfileImage(String value) {
    _networkUserProfileImage = value;
    update();
  }

  get apiClient => _apiClient;

  get fNameCtrl => _fNameCtrl;

  get lNameCtrl => _lNameCtrl;

  get userNameCtrl => _userNameCtrl;

  get emailCtrl => _emailCtrl;

  get passwordCtrl => _passwordCtrl;

  get cPasswordCtrl => _cPasswordCtrl;

  get mobileCtrl => _mobileCtrl;

  get organizationCtrl => _organizationCtrl;

  bool get isUserProfileSelected => _isUserProfileSelected;

  set isUserProfileSelected(bool value) {
    _isUserProfileSelected = value;
    update();
  }

  File get userProfileImage => _userProfileImage;

  set userProfileImage(File value) {
    _userProfileImage = value;
    update();
  }

  bool get isTournament => _isTournament;

  set isTournament(bool value) {
    _isTournament = value;
    update();
  }

  bool get isNews => _isNews;

  set isNews(bool value) {
    _isNews = value;
    update();
  }

  bool get isPromotion => _isPromotion;

  set isPromotion(bool value) {
    _isPromotion = value;
    update();
  }

  bool get isClubOwner => _isClubOwner;

  set isClubOwner(bool value) {
    _isClubOwner = value;
    update();
  }

  bool get isSponsor => _isSponsor;

  set isSponsor(bool value) {
    _isSponsor = value;
    update();
  }

  bool get isOrganizer => _isOrganizer;

  set isOrganizer(bool value) {
    _isOrganizer = value;
    update();
  }

  List get profileCount => _profileCount;

  String get organizerType => _organizerType;

  set organizerType(String value) {
    _organizerType = value;
    update();
  }

  String get organizationName => _organizationName;

  set organizationName(String value) {
    _organizationName = value;
    update();
  }

  List<String> get organizationNames => _organizationNames;

  bool get isOrganizerProfileSelected => _isOrganizerProfileSelected;

  set isOrganizerProfileSelected(bool value) {
    _isOrganizerProfileSelected = value;
    update();
  }

  String get networkOrganizerProfileImage => _networkOrganizerProfileImage;

  set networkOrganizerProfileImage(String value) {
    _networkOrganizerProfileImage = value;
    update();
  }

  File get organizerProfileImage => _organizerProfileImage;

  set organizerProfileImage(File value) {
    _organizerProfileImage = value;
    update();
  }

  List<String> get organizerTypes => _organizerTypes;

  List<String> get organizationTypes => _organizationTypes;

  String get organizationType => _organizationType;

  set organizationType(String value) {
    _organizationType = value;
    update();
  }

  bool get isOrganizationProfileSelected => _isOrganizationProfileSelected;

  set isOrganizationProfileSelected(bool value) {
    _isOrganizationProfileSelected = value;
    update();
  }

  String get networkOrganizationProfileImage => _networkOrganizationProfileImage;

  set networkOrganizationProfileImage(String value) {
    _networkOrganizationProfileImage = value;
    update();
  }

  File get organizationProfileImage => _organizationProfileImage;

  set organizationProfileImage(File value) {
    _organizationProfileImage = value;
    update();
  }

  get organizerNameCtrl => _organizerNameCtrl;

  Organization get organization => _organization;

  set organization(Organization value) {
    _organization = value;
    // update();
  }

  String get organizationId => _organizationId;

  set organizationId(String value) {
    _organizationId = value;
  }

  OrganizerProfile get organizerProfile => _organizerProfile;

  set organizerProfile(OrganizerProfile value) {
    _organizerProfile = value;
  }

  List<Organization> get organizations => _organizations;

  set organizations(List<Organization> value) {
    _organizations = value;
  }

  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile value) {
    _userProfile = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }
}
