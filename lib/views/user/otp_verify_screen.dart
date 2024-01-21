import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:project_black_panther/generated/assets.dart';

import '../../controllers/user/otp_verify_controller.dart';
import '../../core/constants/constants.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/flat_button_widget.dart';

class OPTVerifyScreen extends GetView<OPTVerifyController> {
  const OPTVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding.top;
    final themeData = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 66,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondary.withAlpha(25),
        // border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeData.navigationBarTheme.backgroundColor,
        foregroundColor: themeData.textTheme.bodyLarge!.color,
        title: const Text('OTP Verification'),
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Constants.screenCornerRadius),
            bottomRight: Radius.circular(Constants.screenCornerRadius),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.05),
                  AvatarWidget(provider: const AssetImage(Assets.imagesGamer), size: screenWidth * 0.2),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.07),
                  Text('Hello', style: TextStyle(fontSize: screenWidth * 0.08)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.07),
                  Text('Buddhika', style: TextStyle(fontSize: screenWidth * 0.08)),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Text('Enter the received verification code', style: TextStyle(fontSize: screenWidth * 0.035)),
              SizedBox(height: screenHeight * 0.01),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit01Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.2,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //     SizedBox(width: screenWidth * 0.02),
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit02Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.1,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //     SizedBox(width: screenWidth * 0.02),
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit03Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.1,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //     SizedBox(width: screenWidth * 0.02),
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit04Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.1,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //     SizedBox(width: screenWidth * 0.02),
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit05Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.1,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //     SizedBox(width: screenWidth * 0.02),
              //     TextFieldWidget(
              //       hintText: '',
              //       labelText: '',
              //       enableValidate: false,
              //       txtCtrl: controller.digit06Ctrl,
              //       fontSize: 0.08,
              //       secret: false,
              //       heightFactor: 0.1,
              //       widthFactor: 0.12,
              //       inputType: TextInputType.number,
              //       validate: () {},
              //     ),
              //   ],
              // ),
              SizedBox(height: screenHeight * 0.02),
              Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                controller: controller.otpCtrl,
                validator: (s) {
                  return s != '' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: controller.verifyOTP,
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  print('Clicked');
                  controller.auth();
                },
                child: RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Resend Code",
                      style: TextStyle(color: themeData.buttonTheme.colorScheme!.secondary, fontSize: screenWidth * Constants.textFontSize),
                    )
                  ],
                )),
              ),
              SizedBox(height: screenHeight * 0.18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButtonWidget(
                    title: 'Next',
                    function: () {
                      controller.verifyOTP(controller.otpCtrl.text);
                    },
                    heightFactor: 0.065,
                    widthFactor: 0.4,
                    color: themeData.buttonTheme.colorScheme!.secondary,
                  ),
                  SizedBox(width: screenWidth * 0.06),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
