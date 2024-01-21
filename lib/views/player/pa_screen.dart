import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controllers/player/pas_controller.dart';
import '../../core/constants/constants.dart';
import '../../generated/assets.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/search_text_field_widget.dart';
import '../../widgets/text_field_widget.dart';

class PAScreen extends GetView<PASController> {
  const PAScreen({Key? key}) : super(key: key);

  void _loadAddGameBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.68,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: themeData.primaryColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.1,
                                ),
                                const Text('Add Game', style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  Navigator.pop(context);
                                },
                                iconData: Icons.close,
                                isIcon: true,
                                iconSize: 32,
                                color: themeData.textTheme.bodyLarge?.color,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GFImageOverlay(
                      height: screenHeight * 0.15,
                      width: screenHeight * 0.25,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      boxFit: BoxFit.cover,
                      image:
                          controller.isGameSelected == false ? const NetworkImage('https://images.hdqwalls.com/wallpapers/pubg-mobile-z1.jpg') : NetworkImage(controller.selectedGame.poster.url),
                      // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GetBuilder<PASController>(
                      builder: (controller) => SearchTextFieldWidget(
                        hintText: 'Game',
                        labelText: 'Game',
                        enableValidate: true,
                        txtCtrl: controller.gameNameCtrl,
                        fontSize: 0.03,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        items: controller.gameNames,
                        onItemTap: (gameName) {
                          controller.selectGame(gameName);
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFieldWidget(
                      hintText: 'In Game Name',
                      labelText: 'In Game Name',
                      enableValidate: true,
                      txtCtrl: controller.organizationCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.text,
                      fontSize: 0.03,
                      validate: () {},
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const Text("Play Frequency", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetBuilder<PASController>(
                            builder: (controller) => DropDownButtonWidget(
                                items: const ['Day', 'Week', 'Month'],
                                label: 'Per',
                                isRequired: true,
                                selectData: controller.selectPerType,
                                heightFactor: 0.057,
                                widthFactor: 0.25,
                                valveChoose: controller.perValue),
                          ),
                          GetBuilder<PASController>(
                            builder: (controller) => DropDownButtonWidget(
                                items: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                                label: 'Times',
                                isRequired: true,
                                selectData: controller.selectTimesValue,
                                heightFactor: 0.057,
                                widthFactor: 0.25,
                                valveChoose: controller.perTimes),
                          ),
                          GetBuilder<PASController>(
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
                    SizedBox(height: screenHeight * 0.03),
                    FlatButtonWidget(
                      title: 'Add Game',
                      function: () {
                        controller.createOrganization(bsContext);
                      },
                      heightFactor: 0.065,
                      widthFactor: 0.5,
                      color: themeData.colorScheme.secondary,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      onDrawerChanged: (value) {},
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.textTheme.bodyMedium!.color,
            floating: true,
            snap: true,
            title: const Text('Profile View'),
            centerTitle: true,
          )
        ],
        body: RefreshIndicator(
          displacement: screenHeight * 0.2,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            controller.getUserProfile();
            await Future.delayed(const Duration(milliseconds: 3000));
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth * 0.02),
                      const Text("General Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Divider(color: themeData.primaryColorLight, thickness: 1, indent: screenWidth * 0.01),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => controller.pickUserProfileImage().then((value) => controller.upiFile = value),
                    child: GetBuilder<PASController>(
                      builder: (controller) => controller.upiFile.path.isNotEmpty
                          ? controller.upiFile.path.isEmpty
                              ? GFAvatar(
                                  backgroundColor: themeData.canvasColor,
                                  radius: screenHeight * 0.07,
                                  backgroundImage: const AssetImage(Assets.imagesGamer),
                                  // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                  //backgroundColor: Color.grey.shade600,
                                )
                              : GFAvatar(
                                  backgroundColor: themeData.canvasColor,
                                  radius: screenHeight * 0.07,

                                  backgroundImage: FileImage(controller.upiFile),
                                  // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                  //backgroundColor: Color.grey.shade600,
                                )
                          : controller.loading
                              ? controller.upiNetworkUrl == ''
                                  ? GFAvatar(
                                      backgroundColor: themeData.scaffoldBackgroundColor,
                                      radius: screenHeight * 0.07,
                                      // backgroundImage: const AssetImage(Assets.iconsGamer),

                                      backgroundImage: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1672609164/users/gamer_stlxnd.png'),
                                      //backgroundColor: Color.grey.shade600,
                                    )
                                  : GFAvatar(
                                      backgroundColor: themeData.scaffoldBackgroundColor,
                                      radius: screenHeight * 0.07,
                                      //backgroundImage: const AssetImage(Assets.iconsGamer),
                                      backgroundImage: NetworkImage(controller.upiNetworkUrl),
                                      //backgroundColor: Color.grey.shade600,
                                    )
                              : GFAvatar(
                                  backgroundColor: themeData.scaffoldBackgroundColor,
                                  radius: screenHeight * 0.07,
                                  //backgroundImage: const AssetImage(Assets.iconsGamer),
                                  backgroundImage: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1672609164/users/gamer_stlxnd.png'),
                                  //backgroundColor: Color.grey.shade600,
                                ),
                      id: 'upi',
                      assignId: true,
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
                  TextFieldWidget(
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
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                  // SizedBox(height: screenHeight * 0.02),
                  // TextFieldWidget(
                  //   labelText: "Password",
                  //   hintText: "Password",
                  //   txtCtrl: controller.passwordCtrl,
                  //   fontSize: 0.03,
                  //   enableValidate: true,
                  //   secret: true,
                  //   heightFactor: 0.055,
                  //   widthFactor: 0.9,
                  //   inputType: TextInputType.text,
                  //   validate: () {},
                  // ), //Password
                  // SizedBox(height: screenHeight * 0.02),
                  // TextFieldWidget(
                  //   labelText: "Confirm Password",
                  //   hintText: "Confirm Password",
                  //   txtCtrl: controller.cPasswordCtrl,
                  //   fontSize: 0.03,
                  //   enableValidate: true,
                  //   secret: true,
                  //   heightFactor: 0.055,
                  //   widthFactor: 0.9,
                  //   inputType: TextInputType.text,
                  //   validate: () {},
                  // ), //Conform Password
                  SizedBox(height: screenHeight * 0.02),
                  const Text("Account As", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'Team Leader',
                            checkStatus: controller.isTeamLeader,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedTeamLeader,
                          ),
                          id: 'tl',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'Coordinator',
                            checkStatus: controller.isCoordinator,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedCoordinator,
                          ),
                          id: 'Coordinator',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'Spectator',
                            checkStatus: controller.isSpectator,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedSpectator,
                          ),
                          id: 'Spectator',
                          assignId: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text("Play Frequency", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<PASController>(
                          builder: (controller) => DropDownButtonWidget(
                              items: const ['Day', 'Week', 'Month'],
                              label: 'Per',
                              isRequired: true,
                              selectData: controller.selectPerType,
                              heightFactor: 0.057,
                              widthFactor: 0.25,
                              valveChoose: controller.perValue),
                          id: 'per',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => DropDownButtonWidget(
                              items: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                              label: 'Times',
                              isRequired: true,
                              selectData: controller.selectTimesValue,
                              heightFactor: 0.057,
                              widthFactor: 0.25,
                              valveChoose: controller.perTimes),
                          id: 'times',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => DropDownButtonWidget(
                              items: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                              label: 'Hours',
                              isRequired: true,
                              selectData: controller.selectHoursValue,
                              heightFactor: 0.057,
                              widthFactor: 0.25,
                              valveChoose: controller.perHours),
                          id: 'hours',
                          assignId: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text("Reminder", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'Promotion',
                            checkStatus: controller.isPromotion,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedPromotion,
                          ),
                          id: 'Promotion',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'News',
                            checkStatus: controller.isNews,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedNews,
                          ),
                          id: 'News',
                          assignId: true,
                        ),
                        GetBuilder<PASController>(
                          builder: (controller) => CheckBoxWidget(
                            title: 'Tournament',
                            checkStatus: controller.isTournament,
                            sizeFactor: 0.04,
                            widthFactor: 0.3,
                            onChanged: controller.onChangedTournament,
                          ),
                          id: 'Tournament',
                          assignId: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  FlatButtonWidget(
                    title: 'Update',
                    function: () {
                      // controller.updateUserProfile(context);
                    },
                    heightFactor: 0.065,
                    widthFactor: 0.7,
                    color: themeData.colorScheme.secondary,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth * 0.02),
                      const Text("Player Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Divider(color: themeData.primaryColorLight, thickness: 1, indent: screenWidth * 0.01),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => controller.pickPlayerProfileImage().then((value) => controller.ppiFile = value),
                    child: GetBuilder<PASController>(
                      builder: (controller) => controller.ppiNetworkUrl.isEmpty
                          ? controller.ppiFile.path.isEmpty
                              ? GFAvatar(
                                  backgroundColor: themeData.canvasColor,
                                  radius: screenHeight * 0.07,
                                  backgroundImage: const AssetImage(Assets.imagesGamer),
                                  // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                  //backgroundColor: Color.grey.shade600,
                                )
                              : GFAvatar(
                                  backgroundColor: themeData.canvasColor,
                                  radius: screenHeight * 0.07,

                                  backgroundImage: FileImage(controller.ppiFile),
                                  // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                  //backgroundColor: Color.grey.shade600,
                                )
                          : GFAvatar(
                              backgroundColor: themeData.scaffoldBackgroundColor,
                              radius: screenHeight * 0.07,
                              backgroundImage: NetworkImage(controller.ppiNetworkUrl),
                              //backgroundColor: Color.grey.shade600,
                            ),
                      id: 'ppi',
                      assignId: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFieldWidget(
                    labelText: "Default IGN",
                    hintText: "Default IGN",
                    txtCtrl: controller.defaultIGNCtrl,
                    fontSize: 0.03,
                    enableValidate: true,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    validate: () {},
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<PASController>(
                    builder: (controller) => SearchTextFieldWidget(
                      hintText: 'Club',
                      labelText: 'Club',
                      enableValidate: true,
                      txtCtrl: controller.clubCtrl,
                      fontSize: 0.03,
                      heightFactor: 0.057,
                      widthFactor: 0.9,
                      inputType: TextInputType.text,
                      items: controller.clubNames,
                      onItemTap: (p0) {
                        // controller.getReasonId(p0);
                      },
                    ),
                    assignId: true,
                    id: 'club',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<PASController>(
                    builder: (controller) => SearchTextFieldWidget(
                      hintText: 'Clan',
                      labelText: 'Clan',
                      enableValidate: true,
                      txtCtrl: controller.clanCtrl,
                      fontSize: 0.03,
                      heightFactor: 0.057,
                      widthFactor: 0.9,
                      inputType: TextInputType.text,
                      items: controller.clanNames,
                      onItemTap: (p0) {
                        // controller.getReasonId(p0);
                      },
                    ),
                    assignId: true,
                    id: 'clan',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Game List'),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.001, vertical: screenHeight * 0.001),
                        child: GetBuilder<PASController>(
                          builder: (controller) =>
                              // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                              Container(
                            height: screenHeight * 0.3,
                            width: screenWidth * 0.9,
                            // color: themeData.highlightColor,
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.secondary.withAlpha(25),
                              borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
                            ),
                            child: GridView.builder(
                              addAutomaticKeepAlives: false,
                              cacheExtent: 10,
                              // itemCount: itemList.length,
                              itemCount: 0,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                              itemBuilder: (context, index) {},
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250, childAspectRatio: 3 / 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
                            ),
                          ),
                          // assignId: true,
                          // id: 'attachments',
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.25,
                        left: screenHeight * 0.455,
                        child: IconButtonWidget(
                          imagePath: Assets.iconsAddCircle,
                          function: () {
                            _loadAddGameBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                          iconData: FontAwesomeIcons.circlePlus,
                          // iconData: Icons.add_circle_rounded,
                          isIcon: true,
                          iconSize: screenWidth * 0.06,
                          color: themeData.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  FlatButtonWidget(
                    title: 'Update',
                    function: () {
                      controller.createOrganizerProfile(context);
                    },
                    heightFactor: 0.065,
                    widthFactor: 0.7,
                    color: themeData.colorScheme.secondary,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
