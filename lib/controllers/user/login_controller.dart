import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../api/rest/api_client.dart';
import '../../core/utils/log.dart';
import '../../core/utils/pref_utils.dart';
import '../../models/user/generic_login.dart';
import '../../models/user/logging_session.dart';
import '../../routes/bindings/ods_binding.dart';
import '../../routes/bindings/otps_binding.dart';
import '../../routes/bindings/pds_binding.dart';
import '../../views/organizer/organizer_drawer_screen.dart';
import '../../views/player/player_drawer_screen.dart';
import '../../views/user/otp_verify_screen.dart';
import '../init_controller.dart';

class LoginController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();
  final _initCtrl = Get.find<InitController>();
  final _apiClient = Get.find<ApiClient>();

  final _userNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _isLogged = false;

  late final LoggingSession _session;

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
                  Text("Logging..."),
                ],
              ),
            ),
          );
        },
      ),
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void logViaSession() {
    try {
      _prefUtils.getLoggingSession().then((session) {
        if (session.id.isEmpty) {
          _isLogged = false;
        } else {
          _isLogged = true;
          FlutterNativeSplash.remove();
          // _openScreen(session);
        }
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void getLogin(BuildContext context) {
    try {
      _showLoaderDialog(context);

      if (!_isLogged) {
        final gLogin = GenericLogin(_userNameCtrl.text, _passwordCtrl.text);

        _apiClient.isConnect().then((connect) {
          if (connect == true) {
            const String mobilePattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
            const String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

            if (RegExp(emailPattern).hasMatch(_userNameCtrl.text) == true && _passwordCtrl.text != '') {
              //
              _apiClient.userSignIn(gLogin).then((statusLogin) {
                if (statusLogin!['status'].toString() == '200') {
                  _session = (statusLogin['session']) as LoggingSession;
                  _initCtrl.signInUserWithEmailAndPass(_session.email, gLogin.password, _session.role).then((isLogIn) {
                    if (isLogIn == true) {
                      _openScreen(_session, context);
                    }
                  });
                } else if (statusLogin['status'].toString() == '401') {
                  Log.w('User Name or Password is Invalid');
                }
              });
              //
            } else if (RegExp(mobilePattern).hasMatch(_userNameCtrl.text) == true && _passwordCtrl.text == '') {
              // Log.i(WidgetsBinding.instance.window.locale.countryCode);

              Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: null, mobileNumber: _userNameCtrl.text.trim(), openType: 'signing', userType: ''));

              /*Map<String, String> countyCode = {'code': WidgetsBinding.instance.window.locale.countryCode.toString()};

              var dialCode = Countries.allCountries
                  .where((team) {
                    final id = team['code'];
                    final input = countyCode['code'];

                    return id == (input);
                  })
                  .toList()
                  .first['dial_code'];

              if (_userNameCtrl.text.trim().substring(0, 1) == '+') {
                Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: null, mobileNumber: _userNameCtrl.text.trim(), openType: 'signing'));
              } else if (_userNameCtrl.text.trim().substring(0, 1) == '0') {
                String rawMobile = _userNameCtrl.text.trim().substring(1, 10);
                // var fullMobile = dialCode!+rawMobile;
                // Log.i(fullMobile);
                Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: null, mobileNumber: dialCode! + rawMobile.trim(), openType: 'signing'));
              } else {
                Get.to(() => const OPTVerifyScreen(), binding: OTPScreenBinding(userSignup: null, mobileNumber: (dialCode! + _userNameCtrl.text).trim(), openType: 'signing'));
              }*/
            } else if (_userNameCtrl.text != '' && _passwordCtrl.text != '') {
            } else if (_userNameCtrl.text == '' && _passwordCtrl.text == '') {}
            //
          }
        });
      }
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

  void getGoogleLogin(BuildContext context) {
    try {
      _initCtrl.signInWithGoogle().then((uc) {
        if (uc.user != null) {
          // Log.i(signup.toJson());

          _apiClient.userSignIn(GenericLogin(uc.user!.email!, uc.user!.uid)).then((signInResult) {
            if (signInResult!['status'] == '200') {
              final session = (signInResult['session']) as LoggingSession;
              _openScreen(session, context);
            }
          });

          // Get.offAll(() => const LoginScreen());
        } else {
          Log.e('User not created !');
        }
      }).onError((error, stackTrace) {
        Log.e(error.toString());
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void _openScreen(LoggingSession loggingSession, BuildContext context) {
    if (loggingSession.role == 'FREE') {
      Log.i('Player Login');
      Get.offAll(() => const PlayerDrawerScreen(), binding: PDSBinding());
    } else if (loggingSession.role == 'PREMIUM') {
      Navigator.pop(context, 0);
      Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
    }
  }

  get userNameCtrl => _userNameCtrl;

  get passwordCtrl => _passwordCtrl;
}
