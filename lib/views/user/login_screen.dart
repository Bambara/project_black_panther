import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

import '../../controllers/user/login_controller.dart';
import '../../core/utils/log.dart';
import '../../generated/assets.dart';
import '../../routes/bindings/ass_binding.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/image_button_widget.dart';
import '../../widgets/text_field_widget.dart';
import 'account_section_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: themeData.colorScheme.primary.withAlpha(30),
            height: screenHeight,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight * 0.7,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694400034/assets/07.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipPath(
                    clipper: WaveClipperTwo(reverse: true),
                    child: Container(
                      width: screenWidth,
                      color: themeData.scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.08),
                          TextFieldWidget(
                            hintText: 'Email or Phone Number',
                            labelText: 'Email or Phone Number',
                            enableValidate: true,
                            txtCtrl: controller.userNameCtrl,
                            fontSize: 0.03,
                            secret: false,
                            heightFactor: 0.055,
                            widthFactor: 0.9,
                            inputType: TextInputType.emailAddress,
                            validate: () {},
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextFieldWidget(
                            hintText: 'Password',
                            labelText: 'Password',
                            enableValidate: true,
                            txtCtrl: controller.passwordCtrl,
                            fontSize: 0.03,
                            secret: true,
                            heightFactor: 0.055,
                            widthFactor: 0.9,
                            inputType: TextInputType.text,
                            validate: () {},
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          FlatButtonWidget(
                            title: 'Sign in',
                            function: () {
                              controller.getLogin(context);
                            },
                            heightFactor: 0.065,
                            widthFactor: 0.7,
                            color: themeData.colorScheme.secondary,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Forgot the password ?',
                                  style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary, fontSize: themeData.textTheme.bodyLarge!.fontSize),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => ForgotPasswordScreen());
                                    }),
                            ],
                          )),
                          SizedBox(height: screenHeight * 0.02),
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'OR',
                                style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary),
                              ),
                            ],
                          )),
                          // SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageButtonWidget(
                                  imagePath: Assets.iconsGoogle,
                                  function: () {
                                    controller.getGoogleLogin(context);
                                  },
                                  iconData: Icons.abc,
                                  isIcon: false,
                                  iconSize: 50,
                                  color: Colors.black),
                              ImageButtonWidget(
                                  imagePath: Assets.iconsFacebook,
                                  function: () {
                                    Log.i('Ok');
                                  },
                                  iconData: Icons.abc,
                                  isIcon: false,
                                  iconSize: 50,
                                  color: Colors.black),
                              ImageButtonWidget(
                                  imagePath: Assets.iconsTwitch,
                                  function: () {
                                    Log.i('Ok');
                                  },
                                  iconData: Icons.abc,
                                  isIcon: false,
                                  iconSize: 48,
                                  color: Colors.black),
                              ImageButtonWidget(
                                  imagePath: Assets.iconsDiscord,
                                  function: () {
                                    Log.i('Ok');
                                  },
                                  iconData: Icons.abc,
                                  isIcon: false,
                                  iconSize: 48,
                                  color: Colors.black)
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Don't have an account?", style: TextStyle(color: themeData.textTheme.bodyLarge!.color, fontSize: themeData.textTheme.bodyLarge!.fontSize)),
                                TextSpan(
                                    text: "   Sing up",
                                    style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary, fontSize: themeData.textTheme.bodyLarge!.fontSize),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => const AccountSelectionScreen(), binding: ASSBinding());
                                      }),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
