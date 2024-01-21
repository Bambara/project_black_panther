import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/rest/api_client.dart';
import '../../core/utils/log.dart';
import '../../core/utils/toaster.dart';
import '../../models/common/address.dart';
import '../../models/common/avatar.dart';
import '../../models/common/contact.dart';
import '../../models/common/play_frequency.dart';
import '../../models/common/reminder_type.dart';
import '../../models/common/user_account_type.dart';
import '../../models/user/generic_login.dart';
import '../../models/user/logging_session.dart';
import '../../models/user/user_signup.dart';
import '../../routes/bindings/otps_binding.dart';
import '../../routes/bindings/pds_binding.dart';
import '../../views/player/player_drawer_screen.dart';
import '../../views/user/login_screen.dart';
import '../../views/user/otp_verify_screen.dart';
import '../init_controller.dart';

class FSSController extends GetxController {
  // final _prefUtils = Get.find<PrefUtils>();
  final _initCtrl = Get.find<InitController>();
  final _apiClient = Get.find<ApiClient>();

  final fNameCtrl = TextEditingController();
  final textCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isPlayer = false;
  bool _isTeamLeader = false;
  bool _isCoordinator = false;
  bool _isSpectator = false;

  String _perValue = 'Day';
  String _perTimes = '0';
  String _perHours = '0';

  bool _isPromotion = false;
  bool _isNews = false;
  bool _isTournament = false;

  File _profileImage = File('');
  bool _isSelected = false;

  final String signupType;

  FSSController({required this.signupType});

  void onChangedTeamLeader(bool value) {
    isTeamLeader = value;
  }

  void onChangedCoordinator(bool value) {
    isCoordinator = value;
  }

  void onChangedSpectator(bool value) {
    isSpectator = value;
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

  void selectPerType(String per) {
    perValue = per;
  }

  void selectTimesValue(String times) {
    perTimes = times;
  }

  void selectHoursValue(String hours) {
    perHours = hours;
  }

  void _showLoaderDialog(BuildContext context) {
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
    showDialog(context: context, builder: (_) => alert);
  }

  void onValidate() {
    // Log.i('KKK');
    update();
  }

  Future<File> pickProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      isSelected = true;
      return File(pickedFile.path);
    }
    return File('assets/images/user.png');
  }

  Future<Map<String, String>?> uploadAvatar() async {
    Map<String, String>? avatarInfo = HashMap();
    if (_isSelected) {
      Log.i(_profileImage.path);
      await _apiClient.uploadUserImage(_profileImage, userNameCtrl.text).then((result) {
        avatarInfo = result;
      });
    } else {
      avatarInfo['id'] = userNameCtrl.text;
      avatarInfo['url'] = '';
    }

    return avatarInfo;
  }

  void signUpUser(BuildContext context) {
    try {
      _showLoaderDialog(context);

      final accountType = [
        UserAccountType('', 'Team Leader', isTeamLeader),
        UserAccountType('', 'Coordinator', isCoordinator),
        UserAccountType('', 'Spectator', isSpectator),
      ];

      final playFrequency = [
        PlayFrequency('', 'Per', perHours),
        PlayFrequency('', 'Times', perTimes),
        PlayFrequency('', 'Hours', perHours),
      ];

      final reminderType = [
        ReminderType('', 'Promotion', isPromotion),
        ReminderType('', 'News', isNews),
        ReminderType('', 'Tournament', isTournament),
      ];

      final address = Address('', '', '', '', '', '');
      final contact = Contact('', '', '', '', '');

      _apiClient.isConnect().then((connect) {
        if (connect == true) {
          uploadAvatar().then((avatarInfo) {
            final avatar = Avatar(avatarInfo!['id'].toString(), userNameCtrl.text, avatarInfo['url'].toString());

            final playerSignup = UserSignup(
              '',
              fNameCtrl.text,
              lNameCtrl.text,
              userNameCtrl.text.trim(),
              emailCtrl.text.trim(),
              mobileCtrl.text.trim(),
              contact,
              address,
              cPasswordCtrl.text.trim(),
              'FREE',
              '',
              'Enable',
              avatar,
              accountType,
              playFrequency,
              reminderType,
              '',
              '',
              0,
            );

            // Log.i(playerSignup.toJson());

            // _apiClient.playerSignup(playerSignup).then((status) {
            //   Navigator.pop(context, 0);
            //   if (status == '201' || status == '200') {
            //     Get.off(() => LoginScreen());
            //   }
            // });

            if (signupType == 'Email') {
              _apiClient.playerSignup(playerSignup).then((result) {
                Navigator.pop(context, 0);
                if (result['status'] == '201') {
                  //
                  final userSignup = (result['user']) as UserSignup;
                  //
                  _initCtrl.createUserWithEmailAndPass(userSignup.email, userSignup.password).then((value) {
                    if (value == true) {
                      _apiClient.userSignIn(GenericLogin(userSignup.email, userSignup.password)).then((signInResult) {
                        if (signInResult!['status'] == '200') {
                          final session = (signInResult['session']) as LoggingSession;
                          _openScreen(session);
                        }
                      });
                    } else {
                      _apiClient.removeFreshUser(userSignup.id).then((result) {
                        if (result['status'] == '200') {
                          Log.e('Auth creation fail !');
                          Toaster.showErrorToast('Auth creation fail !');
                        }
                      });
                    }
                  });
                }
              });
            } else if (signupType == 'Mobile') {
              Log.i(WidgetsBinding.instance.window.locale.countryCode);
              Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: playerSignup, mobileNumber: playerSignup.mobile.trim(), openType: 'signup', userType: 'free'));
            } else if (signupType == 'Google') {
              _initCtrl.signInWithGoogle().then((uc) {
                if (uc.user != null) {
                  UserSignup signup = playerSignup;
                  signup.email = uc.user!.email!;
                  signup.password = uc.user!.uid;

                  // Log.i(signup.toJson());

                  _apiClient.playerSignup(signup).then((result) {
                    if (result['status'] == '201') {
                      // final userSignup = (result['user']) as UserSignup;

                      _apiClient.userSignIn(GenericLogin(uc.user!.email!, uc.user!.uid)).then((signInResult) {
                        if (signInResult!['status'] == '200') {
                          final session = (signInResult['session']) as LoggingSession;
                          _openScreen(session);
                        }
                      });
                    }
                  });

                  // Get.offAll(() => const LoginScreen());
                } else {
                  Log.e('User not created !');
                }
              }).onError((error, stackTrace) {
                Log.e(error.toString());
              });
              //
            } else {}
          });
        }
      });
    } on Error catch (e) {
      Log.e(e);
    }
  }

  void _openScreen(LoggingSession loggingSession) {
    if (loggingSession.role == 'FREE') {
      // Log.i('Open Player');
      Get.offAll(() => const PlayerDrawerScreen(), binding: PDSBinding());
    }
  }

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

  String get perTimes => _perTimes;

  set perTimes(String value) {
    _perTimes = value;
    update();
  }

  String get perHours => _perHours;

  set perHours(String value) {
    _perHours = value;
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
