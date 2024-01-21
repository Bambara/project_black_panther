import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../controllers/organizer/ta_controller.dart';
import '../../../core/app_export.dart';
import '../../../generated/assets.dart';
import '../../../widgets/date_picker_widget.dart';
import '../../../widgets/dropdown_button_widget.dart';
import '../../../widgets/flat_button_widget.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/listview_widget.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/ltw_tfd.dart';
import '../../../widgets/radio_button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../../widgets/time_picker_widget.dart';

class TournamentAddScreen extends GetView<TournamentAddController> {
  // static const routeName = '/tournament_add_screen';

  const TournamentAddScreen({Key? key}) : super(key: key);

  // final TournamentAddController _trC = Get.put(TournamentAddController());

  void _loadCreateOrganizationBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.57,
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
                          width: screenWidth * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              const Text('Create Organization', style: TextStyle(fontSize: 16))
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
                    child: GetBuilder<TournamentAddController>(
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
                  GetBuilder<TournamentAddController>(
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

  void _loadAddOrganizerBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.56,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: themeData.primaryColor,
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.8,
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
                  Text(
                    controller.organizationName,
                    style: GoogleFonts.lato(fontSize: screenHeight * 0.03, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<TournamentAddController>(
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
                  GetBuilder<TournamentAddController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.organizerRoles,
                        label: 'Role',
                        isRequired: true,
                        selectData: controller.selectOrganizerRole,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.organizerRole),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<TournamentAddController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.status,
                        label: 'Status',
                        isRequired: true,
                        selectData: controller.selectOrganizationStatus,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.organizationStatus),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FlatButtonWidget(
                    title: 'Add',
                    function: () {
                      controller.addOrganizer(bsContext);
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

  void _loadAddSponsorBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.56,
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
                          width: screenWidth * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              const Text('Add Sponsor', style: TextStyle(fontSize: 16))
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
                  Text(
                    controller.organizationName,
                    style: GoogleFonts.lato(fontSize: screenHeight * 0.03, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<TournamentAddController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.sponsorTypes,
                        label: 'Type',
                        isRequired: true,
                        selectData: controller.selectSponsorType,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.sponsorType),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<TournamentAddController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.sponsorCoverages,
                        label: 'Coverage',
                        isRequired: true,
                        selectData: controller.selectSponsorCoverage,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.sponsorCoverage),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<TournamentAddController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.status,
                        label: 'Status',
                        isRequired: true,
                        selectData: controller.selectSponsorStatus,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.sponsorStatus),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FlatButtonWidget(
                    title: 'Add',
                    function: () {
                      controller.addSponsor(bsContext);
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

  void _loadAddTeamGroupBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.40,
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
                              const Text('Add Team Group', style: TextStyle(fontSize: 16))
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
                  TextFieldWidget(
                    hintText: 'Code',
                    labelText: 'Code',
                    enableValidate: true,
                    txtCtrl: controller.ttgCodeCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    fontSize: 0.03,
                    validate: () {},
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFieldWidget(
                    hintText: 'Name',
                    labelText: 'Name',
                    enableValidate: true,
                    txtCtrl: controller.ttgNameCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    fontSize: 0.03,
                    validate: () {},
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  FlatButtonWidget(
                    title: 'Add',
                    function: () {
                      controller.addTeamGroup(context);
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

  void _loadAddTeamSideBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.40,
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
                              const Text('Add Team Group', style: TextStyle(fontSize: 16))
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
                  TextFieldWidget(
                    hintText: 'Side',
                    labelText: 'Side',
                    enableValidate: true,
                    txtCtrl: controller.ttsSideCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    fontSize: 0.03,
                    validate: () {},
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFieldWidget(
                    hintText: 'Name',
                    labelText: 'Name',
                    enableValidate: true,
                    txtCtrl: controller.ttsNameCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text,
                    fontSize: 0.03,
                    validate: () {},
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  FlatButtonWidget(
                    title: 'Add',
                    function: () {
                      controller.addTeamSide(context);
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

  void _loadAddFinanceDetailsBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.74,
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
                                const Text('Add Finance Details', style: TextStyle(fontSize: 16))
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
                    GetBuilder<TournamentAddController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.financeTypes,
                          label: 'Type',
                          isRequired: true,
                          selectData: controller.selectFinanceType,
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: controller.financeType),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GetBuilder<TournamentAddController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.bankNames, label: 'Bank', isRequired: true, selectData: controller.selectBank, heightFactor: 0.057, widthFactor: 0.9, valveChoose: controller.bankName),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GetBuilder<TournamentAddController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.branchNames,
                          label: 'Branch',
                          isRequired: true,
                          selectData: controller.selectBranch,
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: controller.branchName),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFieldWidget(
                      hintText: 'Account Number',
                      labelText: 'Account Number',
                      enableValidate: true,
                      txtCtrl: controller.tBankAccNumberCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.number,
                      fontSize: 0.03,
                      validate: () {},
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFieldWidget(
                      hintText: 'Account Holder',
                      labelText: 'Account Holder',
                      enableValidate: true,
                      txtCtrl: controller.tAccHolderCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.text,
                      fontSize: 0.03,
                      validate: () {},
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    FlatButtonWidget(
                      title: 'Add',
                      function: () {
                        controller.addFinanceDetails(context);
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

  /*void _loadAddTCTsBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.boarderRadius)),
        context: context,
        builder: (bsContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.74,
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
                                const Text('Add Coordinate Teams', style: TextStyle(fontSize: 16))
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
                                  iconSize: 32),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () => controller.pickOrganizationProfileImage().then((value) => controller.organizationProfileImage = value),
                      child: GetBuilder<TournamentAddController>(
                        builder: (controller) => controller.networkOrganizationProfileImage.isEmpty
                            ? controller.organizationProfileImage.path.isEmpty
                                ? GFAvatar(
                                    backgroundColor: themeData.canvasColor,
                                    radius: screenHeight * 0.07,
                                    backgroundImage: const AssetImage(Assets.iconsGamer),
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
                    SizedBox(height: screenHeight * 0.04),
                    TextFieldWidget(
                        hintText: 'Code',
                        label: 'Code',
                        isRequired: true,
                        txtCtrl: controller.tBankAccNumberCtrl,
                        secret: false,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        fontSize: 0.03),
                    SizedBox(height: screenHeight * 0.02),
                    TextFieldWidget(
                        hintText: 'Name',
                        label: 'Name',
                        isRequired: true,
                        txtCtrl: controller.tBankAccNumberCtrl,
                        secret: false,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        fontSize: 0.03),
                    SizedBox(height: screenHeight * 0.02),
                    GetBuilder<TournamentAddController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.branchNames,
                          label: 'Role',
                          isRequired: true,
                          selectData: controller.selectBranch,
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: controller.branchName),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GetBuilder<TournamentAddController>(
                      builder: (controller) => DropDownButtonWidget(
                          items: controller.branchNames,
                          label: 'Status',
                          isRequired: true,
                          selectData: controller.selectBranch,
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: controller.branchName),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    FlatButtonWidget(
                      title: 'Add',
                      function: () {
                        controller.addFinanceDetails(context);
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
  }*/

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
            expandedHeight: screenHeight * 0.2,
            floating: true,
            snap: true,
            title: Text('Tournament Registration', style: TextStyle(color: themeData.textTheme.titleLarge!.color)),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () => controller.pickWallArt().then((value) => controller.wallArt = value),
                child: GetBuilder<TournamentAddController>(
                  builder: (controller) => controller.isWallArtSelected == false
                      ? controller.tournamentLoaded != null
                          ? controller.tournamentLoaded!.artWorks.first.url == ''
                              ? const GFImageOverlay(
                                  image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398886/assets/01.jpg'),
                                  boxFit: BoxFit.cover,
                                )
                              : GFImageOverlay(
                                  image: NetworkImage(controller.tournamentLoaded!.artWorks.first.url),
                                  boxFit: BoxFit.cover,
                                )
                          : const GFImageOverlay(
                    image: NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398886/assets/01.jpg'),
                              boxFit: BoxFit.cover,
                            )
                      : GFImageOverlay(
                          image: FileImage(controller.wallArt),
                          boxFit: BoxFit.cover,
                        ),
                  assignId: true,
                  id: 'wallArt',
                ),
              ),
            ),
          )
        ],
        body: GetBuilder<TournamentAddController>(
          builder: (controller) => SingleChildScrollView(
            child: controller.loading
                ? Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      TextFieldWidget(
                        labelText: "Tournament Name",
                        hintText: "Tournament Name",
                        enableValidate: true,
                        txtCtrl: controller.nameCtrl,
                        fontSize: 0.03,
                        secret: false,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text,
                        validate: () {},
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const Text("Type", style: TextStyle(fontWeight: FontWeight.normal)),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetBuilder<TournamentAddController>(
                              builder: (controller) => RadioButtonWidget(
                                title: 'Single',
                                sizeFactor: 0.05,
                                widthFactor: 0.2,
                                onChanged: controller.onChangeType,
                                groupValue: controller.type,
                                position: 0,
                              ),
                              assignId: true,
                              id: 'type',
                            ),
                            GetBuilder<TournamentAddController>(
                              builder: (controller) => RadioButtonWidget(
                                title: 'Series',
                                sizeFactor: 0.05,
                                widthFactor: 0.2,
                                onChanged: controller.onChangeType,
                                groupValue: controller.type,
                                position: 1,
                              ),
                              assignId: true,
                              id: 'type',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      const Text('Participant Type', style: TextStyle(fontWeight: FontWeight.normal)),
                      SizedBox(height: screenHeight * 0.01),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetBuilder<TournamentAddController>(
                              builder: (controller) => RadioButtonWidget(
                                title: 'Solo',
                                sizeFactor: 0.05,
                                widthFactor: 0.2,
                                onChanged: controller.onChangePType,
                                groupValue: controller.participantType,
                                position: 0,
                              ),
                              assignId: true,
                              id: 'pType',
                            ),
                            GetBuilder<TournamentAddController>(
                              builder: (controller) => RadioButtonWidget(
                                title: 'Duo',
                                sizeFactor: 0.05,
                                widthFactor: 0.2,
                                onChanged: controller.onChangePType,
                                groupValue: controller.participantType,
                                position: 1,
                              ),
                              assignId: true,
                              id: 'pType',
                            ),
                            GetBuilder<TournamentAddController>(
                              builder: (controller) => RadioButtonWidget(
                                title: 'Squad',
                                sizeFactor: 0.05,
                                widthFactor: 0.2,
                                onChanged: controller.onChangePType,
                                groupValue: controller.participantType,
                                position: 2,
                              ),
                              assignId: true,
                              id: 'pType',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start Date", style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                            Row(
                              children: [
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => DatePickerWidget(heightFactor: 0.055, widthFactor: 0.3, getDate: controller.getStartDate, selectedDate: controller.startDate),
                                  assignId: true,
                                  id: 'startDate',
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => TimePickerWidget(heightFactor: 0.055, widthFactor: 0.28, getTime: controller.getStartTime, selectedTime: controller.startTime),
                                  assignId: true,
                                  id: 'startTime',
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("End Date", style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                            Row(
                              children: [
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => DatePickerWidget(heightFactor: 0.055, widthFactor: 0.3, getDate: controller.getEndDate, selectedDate: controller.endDate),
                                  assignId: true,
                                  id: 'endDate',
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => TimePickerWidget(heightFactor: 0.055, widthFactor: 0.28, getTime: controller.getEndTime, selectedTime: controller.endTime),
                                  assignId: true,
                                  id: 'endTime',
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("Register Open Date", style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                          Row(
                            children: [
                              GetBuilder<TournamentAddController>(
                                builder: (controller) => DatePickerWidget(heightFactor: 0.055, widthFactor: 0.3, getDate: controller.getRegOpenDate, selectedDate: controller.regOpenDate),
                                assignId: true,
                                id: 'regOpenDate',
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              GetBuilder<TournamentAddController>(
                                builder: (controller) => TimePickerWidget(heightFactor: 0.055, widthFactor: 0.28, getTime: controller.getRegOpenTime, selectedTime: controller.regOpenTime),
                                assignId: true,
                                id: 'regOpenTime',
                              )
                            ],
                          )
                        ]),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Register Close Date", style: TextStyle(fontSize: themeData.textTheme.labelMedium!.fontSize)),
                            Row(
                              children: [
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => DatePickerWidget(heightFactor: 0.055, widthFactor: 0.3, getDate: controller.getRegCloseDate, selectedDate: controller.regCloseDate),
                                  assignId: true,
                                  id: 'regCloseDate',
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                GetBuilder<TournamentAddController>(
                                  builder: (controller) => TimePickerWidget(heightFactor: 0.055, widthFactor: 0.28, getTime: controller.getRegCloseTime, selectedTime: controller.regCloseTime),
                                  assignId: true,
                                  id: 'regCloseTime',
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GetBuilder<TournamentAddController>(
                            builder: (controller) => DropDownButtonWidget(
                                items: controller.organizationNames,
                                label: 'Organizer',
                                isRequired: true,
                                selectData: (value) {
                                  controller.selectOrganization(value);
                                  _loadAddOrganizerBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                heightFactor: 0.057,
                                widthFactor: 0.8,
                                valveChoose: controller.organizationName),
                            assignId: true,
                            id: 'organizationName',
                          ),
                          IconButtonWidget(
                            imagePath: Assets.iconsAddCircle,
                            function: () {
                              _loadCreateOrganizationBottomSheet(context, screenHeight, screenWidth, themeData);
                            },
                            iconData: Icons.add_circle,
                            isIcon: false,
                            iconSize: screenWidth * 0.07,
                            color: themeData.textTheme.bodyLarge?.color,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      GetBuilder<TournamentAddController>(
                        builder: (controller) =>
                            ListViewWidget(heightFactor: 0.15, widthFactor: 0.9, itemList: controller.organizerNames, removeItem: (index) => controller.removeOrganizer = index),
                        assignId: true,
                        id: 'tOrg',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GetBuilder<TournamentAddController>(
                            builder: (controller) => DropDownButtonWidget(
                              selectData: (name) {
                                controller.selectSponsor(name);
                                _loadAddSponsorBottomSheet(context, screenHeight, screenWidth, themeData);
                              },
                              isRequired: true,
                              label: "Sponsor",
                              items: controller.sponsorNames,
                              heightFactor: 0.057,
                              widthFactor: 0.8,
                              valveChoose: controller.sponsorName,
                            ),
                            assignId: true,
                            id: 'sponsorName',
                          ),
                          IconButtonWidget(
                            imagePath: Assets.iconsAddCircle,
                            function: () {
                              // _loadAddSponsorBottomSheet(context, screenHeight, screenWidth, themeData);
                            },
                            iconData: Icons.add_circle,
                            isIcon: false,
                            iconSize: screenWidth * 0.07,
                            color: themeData.textTheme.bodyLarge?.color,
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      GetBuilder<TournamentAddController>(
                        builder: (controller) =>
                            ListViewWidget(heightFactor: 0.15, widthFactor: 0.9, itemList: controller.sponsorNameList, removeItem: (index) => controller.removeSponsor = index),
                        assignId: true,
                        id: 'tSponsors',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      GetBuilder<TournamentAddController>(
                        builder: (controller) => DropDownButtonWidget(
                          selectData: controller.selectGame,
                          isRequired: true,
                          label: "Game",
                          items: controller.gameNames,
                          heightFactor: 0.057,
                          widthFactor: 0.9,
                          valveChoose: controller.gameName,
                        ),
                        assignId: true,
                        id: 'gameName',
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      GetBuilder<TournamentAddController>(
                        builder: (controller) => ListViewWidget(heightFactor: 0.15, widthFactor: 0.9, itemList: controller.gameNameList, removeItem: (index) => controller.removeGame = index),
                        assignId: true,
                        id: 'gameName',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: screenWidth * 0.02, bottom: screenWidth * 0.01),
                                child: const Text(
                                  'Team Groups',
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                              ),
                              GetBuilder<TournamentAddController>(
                                builder: (controller) =>
                                    ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamGroupNames, removeItem: (index) => controller.removeTeamGroup = index),
                                assignId: true,
                                id: 'teamGroupNames',
                              ),
                            ],
                          ),
                          IconButtonWidget(
                              imagePath: Assets.iconsAddCircle,
                              function: () {
                                _loadAddTeamGroupBottomSheet(context, screenHeight, screenWidth, themeData);
                              },
                              iconData: Icons.add_circle,
                              isIcon: false,
                              iconSize: screenWidth * 0.07,
                              color: themeData.colorScheme.secondary),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: screenWidth * 0.02, bottom: screenWidth * 0.01),
                                child: const Text(
                                  'Team Sides',
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                              ),
                              GetBuilder<TournamentAddController>(
                                builder: (controller) =>
                                    ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                                assignId: true,
                                id: 'teamSideNames',
                              ),
                            ],
                          ),
                          IconButtonWidget(
                              imagePath: Assets.iconsAddCircle,
                              function: () {
                                _loadAddTeamSideBottomSheet(context, screenHeight, screenWidth, themeData);
                              },
                              iconData: Icons.add_circle,
                              isIcon: false,
                              iconSize: screenWidth * 0.07,
                              color: themeData.colorScheme.secondary),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.02, bottom: screenWidth * 0.01),
                              child: const Text(
                                'Finance Details',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                            IconButtonWidget(
                                imagePath: Assets.iconsAddCircle,
                                function: () {
                                  _loadAddFinanceDetailsBottomSheet(context, screenHeight, screenWidth, themeData);
                                },
                                iconData: Icons.add_circle,
                                isIcon: false,
                                iconSize: screenWidth * 0.07,
                                color: themeData.colorScheme.secondary),
                          ],
                        ),
                      ),
                      Divider(thickness: screenHeight * 0.001, color: Colors.black45, indent: screenWidth * 0.06, endIndent: screenWidth * 0.06),
                      GetBuilder<TournamentAddController>(
                        builder: (controller) =>
                            // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                            SizedBox(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          /* decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(screenWidth * Constants.boarderRadius)),
                          ),*/
                          child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            cacheExtent: 10,
                            // itemCount: itemList.length,
                            itemCount: controller.tFDs.length,
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                            itemBuilder: (context, index) => ListTileWidgetTFD(
                              index: index,
                              removeItem: (index) => controller.removeFinanceDetails = index,
                              tFD: controller.tFDs,
                              function: () {},
                              navigate: () {},
                            ),
                          ),
                        ),
                        assignId: true,
                        id: 'tFDs',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      FlatButtonWidget(
                          title: 'Submit',
                          function: () {
                            controller.createTournament(context);
                            // Get.to(() => EventsListScreen());
                          },
                          heightFactor: 0.065,
                          widthFactor: 0.9,
                          color: themeData.colorScheme.secondary),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  )
                : loadingDialog(context),
          ),
        ),
      ),
    );
  }
}
