import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import '../../controllers/user/fss_controller.dart';
import '../../generated/assets.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class FreeSignupScreen extends GetView<FSSController> {
  const FreeSignupScreen({Key? key}) : super(key: key);

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
            title: const Text('Player Signup'),
            centerTitle: true,
          )
        ],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () => controller.pickProfileImage().then((value) => controller.profileImage = value),
                  child: GetBuilder<FSSController>(
                    builder: (controller) => controller.profileImage.path.isEmpty
                        ? GFAvatar(
                            backgroundColor: themeData.canvasColor,
                            radius: screenHeight * 0.08,
                            backgroundImage: const AssetImage(Assets.imagesGamer),
                            //backgroundColor: Color.grey.shade600,
                          )
                        : GFAvatar(
                            backgroundColor: themeData.canvasColor,
                            radius: screenHeight * 0.08,
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
                      GetBuilder<FSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Team Leader',
                          checkStatus: controller.isTeamLeader,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedTeamLeader,
                        ),
                      ),
                      GetBuilder<FSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Coordinator',
                          checkStatus: controller.isCoordinator,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedCoordinator,
                        ),
                      ),
                      GetBuilder<FSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Spectator',
                          checkStatus: controller.isSpectator,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedSpectator,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                /*SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        TextFieldWidget(
                            label: "Player IGN",
                            hintText: "Player IGN",
                            txtCtrl: controller.userNameCtrl,
                            isRequired: true,
                            secret: false,
                            heightFactor: 0.055,
                            widthFactor: 0.9,
                            inputType: TextInputType.text),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        ListViewWidget(heightFactor: 0.15, widthFactor: 0.9, itemList: const [''], removeItem: (int) {}),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),*/
                const Text("Play Frequency", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<FSSController>(
                        builder: (controller) => DropDownButtonWidget(
                            items: const ['Day', 'Week', 'Month'],
                            label: 'Per',
                            isRequired: true,
                            selectData: controller.selectPerType,
                            heightFactor: 0.057,
                            widthFactor: 0.25,
                            valveChoose: controller.perValue),
                      ),
                      GetBuilder<FSSController>(
                        builder: (controller) => DropDownButtonWidget(
                            items: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                            label: 'Times',
                            isRequired: true,
                            selectData: controller.selectTimesValue,
                            heightFactor: 0.057,
                            widthFactor: 0.25,
                            valveChoose: controller.perTimes),
                      ),
                      GetBuilder<FSSController>(
                        builder: (controller) => DropDownButtonWidget(
                            items: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                            label: 'Hours',
                            isRequired: true,
                            selectData: controller.selectHoursValue,
                            heightFactor: 0.057,
                            widthFactor: 0.25,
                            valveChoose: controller.perHours),
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
                      GetBuilder<FSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Promotion',
                          checkStatus: controller.isPromotion,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedPromotion,
                        ),
                      ),
                      GetBuilder<FSSController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'News',
                          checkStatus: controller.isNews,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedNews,
                        ),
                      ),
                      GetBuilder<FSSController>(
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
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                FlatButtonWidget(
                  title: 'SignUp',
                  function: () {
                    controller.signUpUser(context);
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.colorScheme.secondary,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
