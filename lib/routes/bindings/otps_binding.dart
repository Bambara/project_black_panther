import 'package:get/get.dart';

import '../../controllers/user/otp_verify_controller.dart';
import '../../models/user/user_signup.dart';

/// [OTPScreenBinding - OTP Screen Binding]
class OTPScreenBinding extends Bindings {
  final UserSignup? _userSignup;
  final String _mobileNumber;
  final String _openType;
  final String _userType;

  OTPScreenBinding({required UserSignup? userSignup, required String mobileNumber, required String openType, required String userType})
      : _userSignup = userSignup,
        _mobileNumber = mobileNumber,
        _openType = openType,
        _userType = userType;

  @override
  void dependencies() {
    Get.lazyPut(() => OPTVerifyController(userSignup: _userSignup, mobileNumber: _mobileNumber, openType: _openType, userType: _userType));
  }
}
