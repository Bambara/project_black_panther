import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

loadingDialog(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final safeArea = MediaQuery.of(context).padding.top;
  final themeData = Theme.of(context);

  return Center(
    child: SizedBox(
      height: screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*SpinKitRing(
            color: ColorConstant.red,
            lineWidth: screenHeight * 0.005,
            size: screenHeight * 0.1,
          ),*/
          SpinKitFadingCircle(color: Colors.greenAccent, size: screenHeight * 0.05),
          SizedBox(height: screenHeight * 0.01),
          const Text("Loading..."),
        ],
      ),
    ),
  );
}
