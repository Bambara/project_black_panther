import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/rest/api_client.dart';
import '../../core/utils/generator.dart';
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
import '../../routes/bindings/ods_binding.dart';
import '../../routes/bindings/otps_binding.dart';
import '../../views/organizer/organizer_drawer_screen.dart';
import '../../views/user/login_screen.dart';
import '../../views/user/otp_verify_screen.dart';
import '../init_controller.dart';

class PSSController extends GetxController {
  final _initCtrl = Get.find<InitController>();
  final _apiClient = Get.find<ApiClient>();

  final String signupType;

  final fNameCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  bool _isOrganizer = false;
  bool _isSponsor = false;
  bool _isClubOwner = false;

  bool _isPromotion = false;
  bool _isNews = false;
  bool _isTournament = false;

  File _profileImage = File('');
  bool _isSelected = false;

  PSSController({required this.signupType});

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

  Future<HashMap<String, String>?> uploadAvatar() async {
    HashMap<String, String>? avatarInfo = HashMap();
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

      _apiClient.isConnect().then((connect) {
        if (connect == true) {
          uploadAvatar().then((avatarInfo) {
            final avatar = Avatar(avatarInfo!['id'].toString(), userNameCtrl.text, avatarInfo['url'].toString());

            final premiumUser = UserSignup(
              '',
              fNameCtrl.text,
              lNameCtrl.text,
              userNameCtrl.text.trim(),
              emailCtrl.text.trim(),
              mobileCtrl.text.trim(),
              contact,
              address,
              signupType == 'Email' ? cPasswordCtrl.text.trim() : Generator.getRandomString(12),
              'PREMIUM',
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

            // Log.i(premiumUser.toJson());

            if (signupType == 'Email') {
              _apiClient.premiumSignup(premiumUser).then((result) {
                Navigator.pop(context, 0);
                if (result['status'] == '201') {
                  //
                  final userSignup = (result['user']) as UserSignup;
                  //
                  _initCtrl.createUserWithEmailAndPass(userSignup.email, userSignup.password).then((value) {
                    if (value == true) {
                      Get.offAll(() => const LoginScreen());
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
              Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: premiumUser, mobileNumber: premiumUser.mobile.trim(), openType: 'signup', userType: 'premium'));
            } else if (signupType == 'Google') {
              _initCtrl.signInWithGoogle().then((uc) {
                if (uc.user != null) {
                  UserSignup signup = premiumUser;
                  signup.email = uc.user!.email!;
                  signup.password = uc.user!.uid;

                  // Log.i(signup.toJson());

                  _apiClient.premiumSignup(signup).then((result) {
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
    if (loggingSession.role == 'Player') {
    } else if (loggingSession.role == 'PREMIUM') {
      Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
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

  bool get isPromotion => _isPromotion;

  set isPromotion(bool value) {
    _isPromotion = value;
    update();
  }

  bool get isOrganizer => _isOrganizer;

  set isOrganizer(bool value) {
    _isOrganizer = value;
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

  get logger => Log;
}
