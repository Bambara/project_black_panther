import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/models/user/generic_login.dart';

import '../../api/rest/api_client.dart';
import '../../core/constants/contries.dart';
import '../../core/utils/log.dart';
import '../../models/user/logging_session.dart';
import '../../models/user/user_signup.dart';
import '../../routes/bindings/ods_binding.dart';
import '../../routes/bindings/pds_binding.dart';
import '../../views/organizer/organizer_drawer_screen.dart';
import '../../views/player/player_drawer_screen.dart';
import '../init_controller.dart';
// import '../../data/recover_database.dart';

class OPTVerifyController extends GetxController {
  final _apiClient = ApiClient();
  final initCtrl = Get.find<InitController>();

  final UserSignup? userSignup;
  final String mobileNumber;
  final String openType;
  final String userType;

  final digit01Ctrl = TextEditingController();
  final digit02Ctrl = TextEditingController();
  final digit03Ctrl = TextEditingController();
  final digit04Ctrl = TextEditingController();
  final digit05Ctrl = TextEditingController();
  final digit06Ctrl = TextEditingController();
  final otpCtrl = TextEditingController();

  bool isVerified = false;

  OPTVerifyController({required this.userSignup, required this.mobileNumber, required this.openType, required this.userType});

  @override
  void onReady() {
    auth();
  }

  @override
  void onClose() {
    _removeFreshUser();
  }

  void auth() {
    Map<String, String> countyCode = {'code': WidgetsBinding.instance.window.locale.countryCode.toString()};

    var dialCode = Countries.allCountries
        .where((team) {
          final id = team['code'];
          final input = countyCode['code'];

          return id == (input);
        })
        .toList()
        .first['dial_code'];

    if (mobileNumber.substring(0, 1) == '+') {
      initCtrl.authViaMobile(mobileNumber);
    } else if (mobileNumber.substring(0, 1) == '0') {
      String rawMobile = mobileNumber.substring(1, 10);
      // var fullMobile = dialCode!+rawMobile;
      // Log.i(fullMobile);
      initCtrl.authViaMobile((dialCode! + rawMobile).trim());
    } else {
      initCtrl.authViaMobile((dialCode! + mobileNumber).trim());
    }

    // Log.i(openType );
    // if (openType == 'signup') {
    //   initCtrl.authViaMobile(mobileNumber.trim());
    // }
  }

  void _openScreen(LoggingSession loggingSession) {
    if (loggingSession.role == 'FREE') {
      // Log.i('Player Login');
      Get.offAll(() => const PlayerDrawerScreen(), binding: PDSBinding());
    } else if (loggingSession.role == 'PREMIUM') {
      Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
    }
  }

  Future<void> verifyOTP(String otp) async {
    UserCredential uc = await initCtrl.verifyOTP(otp);
    if (uc.user != null) {
      isVerified = true;
      Log.i('Verified');

      if (openType == 'signup') {
        //
        userSignup!.password = uc.user!.uid;

        Log.i(uc.toString());
        Log.i(userSignup!.password);
        // uc.user!.updatePhotoURL('');

        if (userType == 'premium') {
          _apiClient.premiumSignup(userSignup!).then((result) {
            if (result['status'] == '201') {
              //
              // final userSignup = (result['user']) as UserSignup;
              //
              _apiClient.userSignIn(GenericLogin(userSignup!.email, uc.user!.uid)).then((signInResult) {
                if (signInResult!['status'] == '200') {
                  final session = (signInResult['session']) as LoggingSession;
                  _openScreen(session);
                }
              });
            }
          });
        } else if (userType == 'free') {
          _apiClient.playerSignup(userSignup!).then((result) {
            if (result['status'] == '201') {
              //
              // final userSignup = (result['user']) as UserSignup;
              //
              _apiClient.userSignIn(GenericLogin(userSignup!.email, uc.user!.uid)).then((signInResult) {
                if (signInResult!['status'] == '200') {
                  final session = (signInResult['session']) as LoggingSession;
                  _openScreen(session);
                }
              });
            }
          });
        }
      } else if (openType == 'signing') {
        //
        _apiClient.userSignIn(GenericLogin(mobileNumber, uc.user!.uid)).then((signInResult) {
          if (signInResult!['status'] == '200') {
            final session = (signInResult['session']) as LoggingSession;
            _openScreen(session);
          }
        });
        //
      }
      //
    } else {
      isVerified = true;
      Log.i('Not Verified');
    }
  }

  void _removeFreshUser() {
    try {
      if (isVerified == false && openType == 'signup') {
        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            _apiClient.removeFreshUser(userSignup!.id).then((result) {
              if (result['status'] == '200') {}
            });
          }
        });
      }
    } on Error catch (e) {
      Log.e(e);
    }
  }
}
