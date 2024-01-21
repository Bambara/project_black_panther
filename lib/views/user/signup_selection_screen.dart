import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/user/ss_controller.dart';
import '../../routes/bindings/fss_binding.dart';
import '../../routes/bindings/pss_binding.dart';
import 'free_signup_screen.dart';
import 'premium_signup_screen.dart';

class SignUpSelectionScreen extends GetWidget<SSController> {
  const SignUpSelectionScreen({Key? key, required this.userType}) : super(key: key);

  final String userType;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.textTheme.bodyText1!.color,
            floating: true,
            snap: true,
            title: const Text('Choose Methode'),
            centerTitle: true,
          )
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GFButton(
                  onPressed: () {
                    if (userType == 'Premium') {
                      Get.to(() => const PremiumSignupScreen(), binding: PSSBinding(signupType: 'Google'));
                    } else if (userType == 'Free') {
                      Get.to(() => const FreeSignupScreen(), binding: FSSBinding(signupType: 'Google'));
                    }
                  },
                  //fullWidthButton: true,
                  text: "Continue With Google    ",
                  icon: const Icon(FontAwesomeIcons.google),
                  size: GFSize.LARGE,
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                  blockButton: false,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                GFButton(
                  onPressed: () {},
                  //fullWidthButton: true,
                  text: "Continue With Facebook",
                  icon: const Icon(FontAwesomeIcons.squareFacebook),
                  size: GFSize.LARGE,
                  blockButton: false,
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                GFButton(
                  onPressed: () {
                    if (userType == 'Premium') {
                      Get.to(() => const PremiumSignupScreen(), binding: PSSBinding(signupType: 'Email'));
                    } else if (userType == 'Free') {
                      Get.to(() => const FreeSignupScreen(), binding: FSSBinding(signupType: 'Email'));
                    }
                  },
                  //fullWidthButton: true,
                  text: "Continue With Email       ",
                  icon: const Icon(FontAwesomeIcons.envelope),
                  blockButton: false,
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                GFButton(
                  //fullWidthButton: true,
                  onPressed: () {
                    if (userType == 'Premium') {
                      Get.to(() => const PremiumSignupScreen(), binding: PSSBinding(signupType: 'Mobile'));
                    } else if (userType == 'Free') {
                      Get.to(() => const FreeSignupScreen(), binding: FSSBinding(signupType: 'Mobile'));
                    }
                  },
                  text: "Continue With Mobile    ",
                  icon: const Icon(FontAwesomeIcons.mobileScreenButton),
                  blockButton: false,
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
