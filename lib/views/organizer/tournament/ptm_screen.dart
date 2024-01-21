import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_black_panther/core/app_export.dart';
import 'package:project_black_panther/widgets/switch_widget.dart';

import '../../../controllers/ptms_controller.dart';
import '../../../generated/assets.dart';
import '../../../widgets/dropdown_button_widget.dart';
import '../../../widgets/flat_button_widget.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/ltw_assign_event.dart';
import '../../../widgets/ltw_pt_member.dart';
import '../../../widgets/search_text_field_widget.dart';
import '../../../widgets/text_field_widget.dart';

//PTMScreen - PlayerTeamManagementScreen
class PTMScreen extends GetView<PTMSController> {
  ///Player Team Manage Screen
  ///
  /// Manage and Add Player team to tournaments
  ///
  /// Assign player teams to events
  const PTMScreen({Key? key}) : super(key: key);

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
                'Add Player Team',
                style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize),
              )
            : Text(
                'Manage Player Team',
                style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize),
              ),
      ),
      body: GetBuilder<PTMSController>(
        builder: (controller) => SingleChildScrollView(
          child: controller.loading
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTMSController>(
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              controller.pickTeamLogo().then((value) => controller.teamLogoImg = value);
                            },
                            child: controller.isTeamLogoSelected == false
                                ? controller.playerTeam == null
                                    ? GFAvatar(
                                        backgroundColor: themeData.canvasColor,
                                        radius: screenHeight * 0.07,
                                        backgroundImage: const AssetImage(Assets.imagesGamerMobile),
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
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTMSController>(
                          builder: (controller) => DropDownButtonWidget(
                            selectData: controller.selectTeamType,
                            isRequired: true,
                            label: "Team Type",
                            items: controller.teamTypeList,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            valveChoose: controller.teamType,
                          ),
                          id: 'teamType',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTMSController>(
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
                            onItemTap: (p0) {},
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTMSController>(
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
                            onItemTap: (p0) {},
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GetBuilder<PTMSController>(
                              builder: (controller) => SizedBox(
                                width: 0.8 * screenWidth,
                                child: SearchTextFieldWidget(
                                  hintText: 'Member',
                                  labelText: 'Member',
                                  enableValidate: true,
                                  txtCtrl: controller.memberCtrl,
                                  fontSize: 0.03,
                                  heightFactor: 0.057,
                                  widthFactor: 0.7,
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
                        GetBuilder<PTMSController>(
                          builder: (controller) =>
                              // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                              Container(
                            height: screenHeight * 0.3,
                            width: screenWidth * 0.9,
                            // color: themeData.highlightColor,
                            decoration: BoxDecoration(
                              color: themeData.highlightColor,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GetBuilder<PTMSController>(
                              builder: (controller) => SizedBox(
                                width: 0.85 * screenWidth,
                                child: DropDownButtonWidget(
                                  selectData: controller.selectEvent,
                                  isRequired: true,
                                  label: "Event Assign",
                                  items: controller.eventNameList,
                                  heightFactor: 0.057,
                                  widthFactor: 0.8,
                                  valveChoose: controller.eventName,
                                ),
                              ),
                              assignId: true,
                              id: 'events',
                            ),
                            IconButtonWidget(
                              imagePath: Assets.iconsAddCircle,
                              function: () {
                                controller.assignEvent(controller.eventName);
                              },
                              iconData: Icons.add_circle,
                              isIcon: false,
                              iconSize: screenWidth * 0.07,
                              color: themeData.textTheme.bodyLarge?.color,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                        Container(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          // color: themeData.highlightColor,
                          decoration: BoxDecoration(
                            color: themeData.highlightColor,
                            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
                          ),
                          child: GetBuilder<PTMSController>(
                            builder: (controller) => ListView.builder(
                              addAutomaticKeepAlives: false,
                              cacheExtent: 10,
                              // itemCount: itemList.length,
                              itemCount: controller.eventAssignTeams.length,
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                              itemBuilder: (context, index) => LTWAssignEvent(
                                eventAssignTeams: controller.eventAssignTeams,
                                tEvents: controller.tEvents,
                                index: index,
                                removeItem: (index) {
                                  controller.removeEvent(index);
                                },
                                function: () {},
                                navigate: () {},
                                onChangeStatus: controller.onChangeEventStatus,
                                valveChoose: controller.isEventEnable[index],
                              ),
                            ),
                            assignId: true,
                            id: 'assignEvents',
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.01),
                        GetBuilder<PTMSController>(
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
