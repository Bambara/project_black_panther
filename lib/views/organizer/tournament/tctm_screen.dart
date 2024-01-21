import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../controllers/organizer/tournament/tctms_controller.dart';
import '../../../core/app_export.dart';
import '../../../generated/assets.dart';
import '../../../widgets/dropdown_button_widget.dart';
import '../../../widgets/flat_button_widget.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/ltw_pt_member.dart';
import '../../../widgets/search_text_field_widget.dart';
import '../../../widgets/switch_widget.dart';
import '../../../widgets/text_field_widget.dart';

//TCTMScreen - TournamentCoordinatorTeamManagementScreen
class TCTMScreen extends GetView<TCTMSController> {
  ///Coordinator Team Manage Screen
  ///
  /// Manage and Add Coordinator team to tournaments
  const TCTMScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: controller.playerTeam == null
            ? Text(
                'Add Coordinator Team',
                style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize),
              )
            : Text(
                'Manage Coordinator Team',
                style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize),
              ),
      ),
      body: GetBuilder<TCTMSController>(
        builder: (controller) => SingleChildScrollView(
          child: controller.loading
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<TCTMSController>(
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              controller.pickTeamLogo().then((value) => controller.teamLogoImg = value);
                            },
                            child: controller.isTeamLogoSelected == false
                                ? controller.playerTeam == null
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
                                        // backgroundImage: NetworkImage(controller.playerTeam!.logo.url),
                                        backgroundImage: controller.playerTeam != null ? NetworkImage(controller.playerTeam!.logo.url) : const NetworkImage(''),
                                        //backgroundColor: Color.grey.shade600,
                                      )
                                : GFAvatar(
                                    backgroundColor: themeData.canvasColor,
                                    radius: screenHeight * 0.07,
                                    backgroundImage: FileImage(controller.teamLogo),
                                    // backgroundImage: const AssetImage("assets/images/camera_icon_128.png"),
                                    //backgroundColor: Color.grey.shade600,
                                  ),
                          ),
                          id: 'teamLogo',
                          assignId: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          child: Text('Code : ${controller.teamCode}', style: TextStyle(fontSize: themeData.textTheme.titleMedium!.fontSize)),
                        ),
                        TextFieldWidget(
                          labelText: "Team Name",
                          hintText: "Team Name",
                          enableValidate: true,
                          txtCtrl: controller.teamNameCtrl,
                          fontSize: 0.03,
                          secret: false,
                          heightFactor: 0.055,
                          widthFactor: 0.9,
                          inputType: TextInputType.text,
                          validate: () {},
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        GetBuilder<TCTMSController>(
                          builder: (controller) => DropDownButtonWidget(
                            selectData: controller.selectTeamType,
                            isRequired: true,
                            label: "Role",
                            items: controller.teamTypeList,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            valveChoose: controller.teamType,
                          ),
                          id: 'teamType',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GetBuilder<TCTMSController>(
                              builder: (controller) => SizedBox(
                                width: 0.85 * screenWidth,
                                child: SearchTextFieldWidget(
                                  hintText: 'Member',
                                  labelText: 'Member',
                                  enableValidate: true,
                                  txtCtrl: controller.memberCtrl,
                                  fontSize: 0.03,
                                  heightFactor: 0.057,
                                  widthFactor: 0.8,
                                  inputType: TextInputType.text,
                                  items: controller.memberNames,
                                  onItemTap: (p0) {},
                                ),
                              ),
                            ),
                            IconButtonWidget(
                              imagePath: Assets.iconsAddCircle,
                              function: () {
                                controller.addMember(controller.memberCtrl.text.toString());
                              },
                              iconData: Icons.add_circle,
                              isIcon: false,
                              iconSize: screenWidth * 0.07,
                              color: themeData.textTheme.bodyLarge?.color,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        GetBuilder<TCTMSController>(
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
                            child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              cacheExtent: 10,
                              // itemCount: itemList.length,
                              itemCount: controller.ptMembers.length,
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                              itemBuilder: (context, index) => LTWPTMember(
                                ptMember: controller.ptMembers,
                                // selectedPlayer: controller.selectedPlayer,
                                index: index,
                                removeItem: (index) {
                                  controller.removeMember(index);
                                },
                                function: () {},
                                navigate: () {},
                                rbPosition: index,
                                groupValue: controller.leaderPosition,
                                onChangedLeader: controller.onChangedLeader,
                                onChangeStatus: controller.onChangeMemberStatus,
                                valveChoose: controller.isMemberEnable[index],
                              ),
                            ),
                          ),
                          assignId: true,
                          id: 'ptMember',
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        GetBuilder<TCTMSController>(
                          builder: (controller) => SwitchWidget(
                              label: 'Status',
                              changeStatus: controller.onChangeStatus,
                              heightFactor: 0.057,
                              widthFactor: 0.5,
                              textSize: themeData.textTheme.bodyMedium?.fontSize,
                              valveChoose: controller.isEnable),
                          id: 'ptStatus',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        FlatButtonWidget(
                            title: "Save",
                            function: () {
                              controller.addPlayerTeam(context);
                            },
                            heightFactor: 0.07,
                            widthFactor: 0.55,
                            color: themeData.colorScheme.secondary),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                )
              : loadingDialog(context),
        ),
      ),
    );
  }
}
