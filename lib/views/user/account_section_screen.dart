import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user/ass_controller.dart';
import '../../routes/bindings/suss_binding.dart';
import '../../widgets/flat_button_widget.dart';
import 'signup_selection_screen.dart';

class AccountSelectionScreen extends GetWidget<ASSController> {
  const AccountSelectionScreen({Key? key}) : super(key: key);

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
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Become a Player',
                      style: TextStyle(color: themeData.textTheme.headlineSmall!.color, fontSize: themeData.textTheme.headlineSmall!.fontSize),
                    ),
                  ],
                )),
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                FlatButtonWidget(
                  title: 'Create Account',
                  function: () {
                    Get.to(() => const SignUpSelectionScreen(userType: 'Free'), binding: SUSSBinding());
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.colorScheme.secondary,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Become a Premium User',
                      style: TextStyle(color: themeData.textTheme.headlineSmall!.color, fontSize: themeData.textTheme.headlineSmall!.fontSize),
                    ),
                  ],
                )),
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                FlatButtonWidget(
                  title: 'Create Account',
                  function: () {
                    Get.to(() => const SignUpSelectionScreen(userType: 'Premium'), binding: SUSSBinding());
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
