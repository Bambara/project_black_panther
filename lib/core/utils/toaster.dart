import 'package:fluttertoast/fluttertoast.dart';

import '../app_export.dart';

class Toaster {
  static void showErrorToast(String error) {
    try {
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.errorRed,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    } catch (e) {
      Log.e(e);
    }
  }

  static void showInfoToast(String info) {
    try {
      Fluttertoast.showToast(
          msg: info,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.greenTransparent,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    } catch (e) {
      Log.e(e);
    }
  }

  static void showWarnToast(String warn) {
    try {
      Fluttertoast.showToast(
          msg: warn,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstant.yellow700,
          textColor: ColorConstant.darkBlack,
          fontSize: 14);
    } catch (e) {
      Log.e(e);
    }
  }
}
