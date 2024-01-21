import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/app_export.dart';
import '../routes/bindings/ls_binding.dart';
import '../routes/bindings/ods_binding.dart';
import '../routes/bindings/pds_binding.dart';
import '../views/organizer/organizer_drawer_screen.dart';
import '../views/player/player_drawer_screen.dart';
import '../views/user/login_screen.dart';

class InitController extends GetxController {
  final _prefUtils = Get.find<PrefUtils>();
  bool _isLogged = true;

  final _firebaseAuth = FirebaseAuth.instance;

  // late final Rx<User?> firebaseUser;
  late final User? firebaseUser;
  var verifyId = ''.obs;

  @override
  void onReady() {
    // firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    firebaseUser = _firebaseAuth.currentUser;
    // firebaseUser.bindStream(_firebaseAuth.userChanges());
    // ever(firebaseUser, _logViaSession);
    _logViaSession(firebaseUser);
  }

  // void _getAction(User? user) {
  //   user == null ? Get.offAll(() => const LoginScreen(), binding: LSBinding()) : Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
  // }

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

  Future<bool> createUserWithEmailAndPass(String email, String pass) async {
    bool isSignup = false;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass).then((uc) {
        Log.i(uc.toString());
        isSignup = true;
      }).onError((error, stackTrace) {
        isSignup = false;
      });
      // firebaseUser.value == null ? Get.offAll(() => const LoginScreen(), binding: LSBinding()) : Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
      isSignup = false;
    }
    return isSignup;
  }

  Future<bool> signInUserWithEmailAndPass(String email, String pass, String role) async {
    bool isLogIn = false;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((value) {
        // Log.i(value.credential!.accessToken);
        Log.i(value.user!.uid);
        isLogIn = true;
      }).onError((error, stackTrace) {
        isLogIn = false;
        Log.e(error);
        Toaster.showErrorToast(error.toString());
      });

      // if (loggingSession.role == 'Player') {
      // } else if (loggingSession.role == 'PREMIUM') {
      //   Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
      // }
      //
      // firebaseUser.value == null ? Get.offAll(() => const LoginScreen(), binding: LSBinding()) : Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
    } catch (e) {
      isLogIn = false;
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
    return isLogIn;
  }

  void authViaMobile(String mobileNum) async {
    try {
      Log.w(mobileNum);
      await _firebaseAuth
          .verifyPhoneNumber(
            phoneNumber: mobileNum,
            timeout: const Duration(seconds: 120),
            verificationCompleted: (phoneAuthCredential) async {
              Log.w(jsonDecode(phoneAuthCredential.toString()));
              await _firebaseAuth.signInWithCredential(phoneAuthCredential);
            },
            verificationFailed: (error) {
              Log.e(error);
              Toaster.showErrorToast(error.toString());
            },
            codeSent: (verificationId, forceResendingToken) {
              Log.w(' Code Sent : $verificationId + $forceResendingToken');

              verifyId.value = verificationId;
            },
            codeAutoRetrievalTimeout: (verificationId) {
              Log.w('Time out : $verificationId');
              verifyId.value = verificationId;
            },
          )
          .then((value) {})
          .onError((error, stackTrace) {});
    } catch (e) {
      Log.e(e);
      Toaster.showErrorToast(e.toString());
    }
  }

  Future<UserCredential> verifyOTP(String otp) async {
    final credentials = await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verifyId.value, smsCode: otp));
    return credentials;
  }

  Future<UserCredential> signInWithGoogle() async {
    late final OAuthCredential credential;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    } catch (e) {
      Log.e(e);
    }
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // Log.i(userCredential.user);
    // Once signed in, return the UserCredential
    return userCredential;
  }

  void _logViaSession(User? user) {
    try {
      _prefUtils.getLoggingSession().then((session) {
        if (session.id.isEmpty || user == null) {
          _isLogged = false;
          FlutterNativeSplash.remove();
          Get.offAll(() => const LoginScreen(), binding: LSBinding());
        } else {
          _isLogged = true;
          FlutterNativeSplash.remove();
          _openScreen(session);
        }
      });
    } catch (e) {
      Log.e(e);
    }
  }

  void _openScreen(loggingSession) {
    if (loggingSession.role == 'FREE') {
      // Log.i('Open Player');
      Get.offAll(() => const PlayerDrawerScreen(), binding: PDSBinding());
    } else if (loggingSession.role == 'PREMIUM') {
      Get.offAll(() => const OrganizerDrawerScreen(), binding: ODSBinding());
    }
  }
}
