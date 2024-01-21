import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controllers/organizer/oas_controller.dart';
import '../../core/constants/constants.dart';
import '../../generated/assets.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class OAScreen extends GetView<OASController> {
  const OAScreen({Key? key}) : super(key: key);

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
        /*body: Column(
          children: [
            Expanded(
              child: GetBuilder<OASController>(
                builder: (controller) => GridView.builder(
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  itemCount: controller.profileCount.length,
                  itemBuilder: (context, index) {
                    return GTWProfile(
                      navigate: () {},
                      profileList: const [],
                      index: index,
                      removeItem: (index) {},
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 25, childAspectRatio: 2 / 2.2),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),*/
        body: RefreshIndicator(
          displacement: screenHeight * 0.2,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            controller.getUserProfile();
            await Future.delayed(const Duration(milliseconds: 3000));
          },
          child: SingleChildScrollView(
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
                  onTap: () => controller.pickUserProfileImage().then((value) => controller.userProfileImage = value),
                  child: GetBuilder<OASController>(
                    builder: (controller) => controller.userProfileImage.path.isNotEmpty
                        ? controller.userProfileImage.path.isEmpty
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

                                backgroundImage: FileImage(controller.userProfileImage),
                                // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                //backgroundColor: Color.grey.shade600,
                              )
                        : controller.loading
                            ? GFAvatar(
                                backgroundColor: themeData.scaffoldBackgroundColor,
                                radius: screenHeight * 0.07,
                                // backgroundImage: const AssetImage(Assets.iconsGamer),
                                backgroundImage: NetworkImage(controller.networkUserProfileImage),
                                //backgroundColor: Color.grey.shade600,
                              )
                            : GFAvatar(
                                backgroundColor: themeData.scaffoldBackgroundColor,
                                radius: screenHeight * 0.07,
                                //backgroundImage: const AssetImage(Assets.iconsGamer),
                                backgroundImage: NetworkImage(controller.networkUserProfileImage),
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
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
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
                ), //Password
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
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
                ), //Conform Password
                SizedBox(height: screenHeight * 0.02),
                const Text("Account As", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<OASController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Organizer',
                          checkStatus: controller.isOrganizer,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedOrganizer,
                        ),
                      ),
                      GetBuilder<OASController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Sponsor',
                          checkStatus: controller.isSponsor,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedSponsor,
                        ),
                      ),
                      GetBuilder<OASController>(
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
                SizedBox(height: screenHeight * 0.03),
                const Text("Reminder", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<OASController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'Promotion',
                          checkStatus: controller.isPromotion,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedPromotion,
                        ),
                      ),
                      GetBuilder<OASController>(
                        builder: (controller) => CheckBoxWidget(
                          title: 'News',
                          checkStatus: controller.isNews,
                          sizeFactor: 0.04,
                          widthFactor: 0.3,
                          onChanged: controller.onChangedNews,
                        ),
                      ),
                      GetBuilder<OASController>(
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
                  title: 'Update',
                  function: () {
                    controller.updateUserProfile(context);
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
                    const Text("Organizer Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Divider(color: themeData.primaryColorLight, thickness: 1, indent: screenWidth * 0.01),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () => controller.pickOrganizerProfileImage().then((value) => controller.organizerProfileImage = value),
                  child: GetBuilder<OASController>(
                    builder: (controller) => controller.networkOrganizerProfileImage.isEmpty
                        ? controller.organizerProfileImage.path.isEmpty
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

                                backgroundImage: FileImage(controller.organizerProfileImage),
                                // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                //backgroundColor: Color.grey.shade600,
                              )
                        : GFAvatar(
                            backgroundColor: themeData.scaffoldBackgroundColor,
                            radius: screenHeight * 0.07,
                            backgroundImage: NetworkImage(controller.networkOrganizerProfileImage),
                            //backgroundColor: Color.grey.shade600,
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  labelText: "Name",
                  hintText: "Name",
                  txtCtrl: controller.organizerNameCtrl,
                  fontSize: 0.03,
                  enableValidate: true,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.text,
                  validate: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                GetBuilder<OASController>(
                  builder: (controller) => DropDownButtonWidget(
                      items: controller.organizerTypes,
                      label: 'Type',
                      isRequired: true,
                      selectData: controller.selectOrganizerType,
                      heightFactor: 0.057,
                      widthFactor: 0.9,
                      valveChoose: controller.organizerType),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GetBuilder<OASController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.organizationNames,
                          label: 'Organization',
                          isRequired: true,
                          selectData: controller.selectOrganization,
                          heightFactor: 0.057,
                          widthFactor: 0.8,
                          valveChoose: controller.organizationName),
                    ),
                    IconButtonWidget(
                      imagePath: Assets.iconsAddCircle,
                      function: () {
                        _loadAddOrganizationBottomSheet(context, screenHeight, screenWidth, themeData);
                      },
                      iconData: Icons.add_circle,
                      isIcon: false,
                      iconSize: screenWidth * 0.07,
                      color: themeData.colorScheme.secondary,
                    )
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
    );
  }

  void _loadAddOrganizationBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.55,
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
                              const Text('Add Organization', style: TextStyle(fontSize: 16))
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
                  GestureDetector(
                    onTap: () => controller.pickOrganizationProfileImage().then((value) => controller.organizationProfileImage = value),
                    child: GetBuilder<OASController>(
                      builder: (controller) => controller.networkOrganizationProfileImage.isEmpty
                          ? controller.organizationProfileImage.path.isEmpty
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

                                  backgroundImage: FileImage(controller.organizationProfileImage),
                                  // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                  //backgroundColor: Color.grey.shade600,
                                )
                          : GFAvatar(
                              backgroundColor: themeData.scaffoldBackgroundColor,
                              radius: screenHeight * 0.07,
                              backgroundImage: NetworkImage(controller.networkOrganizationProfileImage),
                              //backgroundColor: Color.grey.shade600,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  TextFieldWidget(
                    hintText: 'Name',
                    labelText: 'Name',
                    enableValidate: true,
                    txtCtrl: controller.organizationCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    fontSize: 0.03,
                    validate: () {},
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<OASController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.organizationTypes,
                        label: 'Type',
                        isRequired: true,
                        selectData: controller.selectOrganizationType,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.organizationType),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  FlatButtonWidget(
                    title: 'Save',
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
          );
        });
  }
}
