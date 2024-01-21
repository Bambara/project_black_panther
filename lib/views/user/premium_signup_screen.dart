import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import '../../controllers/user/pss_controller.dart';
import '../../generated/assets.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class PremiumSignupScreen extends GetWidget<PSSController> {
  const PremiumSignupScreen({Key? key}) : super(key: key);

  // final controller = Get.put(PSSController());

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
            title: const Text('Premium Sign Up'),
            centerTitle: true,
          )
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () => controller.pickProfileImage().then((value) => controller.profileImage = value),
                  child: GetBuilder<PSSController>(
                    builder: (controller) => controller.profileImage.path.isEmpty
                        ? GFAvatar(
                            backgroundColor: themeData.scaffoldBackgroundColor,
                            radius: screenHeight * 0.07,
                            backgroundImage: const AssetImage(Assets.imagesGamer),
                            //backgroundColor: Color.grey.shade600,
                          )
                        : GFAvatar(
                            backgroundColor: themeData.canvasColor,
                            radius: screenHeight * 0.07,
                            backgroundImage: FileImage(controller.profileImage),
                            // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                            //backgroundColor: Color.grey.shade600,
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  labelText: "First Name",
                  hintText: "First Name",
                  txtCtrl: controller.fNameCtrl,
                  fontSize: 0.03,
                  enableValidate: true,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.name,
                  validate: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  labelText: "Last Name",
                  hintText: "Last Name",
                  txtCtrl: controller.lNameCtrl,
                  fontSize: 0.03,
                  enableValidate: true,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.name,
                  validate: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  labelText: "User Name",
                  hintText: "User Name",
                  txtCtrl: controller.userNameCtrl,
                  fontSize: 0.03,
                  enableValidate: true,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.text,
                  validate: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                controller.signupType != 'Google'
                    ? TextFieldWidget(
                        labelText: "Email",
                        hintText: "Email",
                        txtCtrl: controller.emailCtrl,
                        fontSize: 0.03,
                        enableValidate: true,
                        secret: false,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.emailAddress,
                        validate: () {},
                      )
                    : Container(width: 0),
                controller.signupType != 'Google' ? SizedBox(height: screenHeight * 0.02) : Container(width: 0),
                TextFieldWidget(
                  labelText: "Mobile",
                  hintText: "Mobile",
                  txtCtrl: controller.mobileCtrl,
                  fontSize: 0.03,
                  enableValidate: true,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.phone,
                  validate: () {},
                ), //Mobile Number//Email
                SizedBox(height: screenHeight * 0.02),
                controller.signupType == 'Email'
                    ? TextFieldWidget(
                        labelText: "Password",
                        hintText: "Password",
                        txtCtrl: controller.passwordCtrl,
                        fontSize: 0.03,
                        enableValidate: true,
                        secret: true,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        validate: () {},
                      )
                    : Container(width: 0), //Password
                controller.signupType == 'Email' ? SizedBox(height: screenHeight * 0.02) : Container(width: 0),
                controller.signupType == 'Email'
                    ? TextFieldWidget(
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                        txtCtrl: controller.cPasswordCtrl,
                        fontSize: 0.03,
                        enableValidate: true,
                        secret: true,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        validate: () {},
                      )
                    : Container(width: 0), //Conform Password
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text("Account As", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Organizer',
                          checkStatus: controller.isOrganizer,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedOrganizer,
                        ),
                      ),
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Sponsor',
                          checkStatus: controller.isSponsor,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedSponsor,
                        ),
                      ),
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Club Owner',
                          checkStatus: controller.isClubOwner,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedClubOwner,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                const Text("Reminder", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Promotion',
                          checkStatus: controller.isPromotion,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedPromotion,
                        ),
                      ),
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'News',
                          checkStatus: controller.isNews,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedNews,
                        ),
                      ),
                      GetBuilder<PSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Tournament',
                          checkStatus: controller.isTournament,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedTournament,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                FlatButtonWidget(
                  title: 'Signup',
                  function: () {
                    controller.signUpUser(context);
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.7,
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
