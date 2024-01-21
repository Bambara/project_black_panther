import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_black_panther/core/app_export.dart';

import '../../controllers/organizer/eas_controller.dart';
import '../../generated/assets.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_art_work.dart';
import '../../widgets/text_field_widget.dart';

class EventAddScreen extends GetView<EventAddScreenController> {
  const EventAddScreen({Key? key}) : super(key: key);

  void _loadArtWorkBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final TextEditingController nameCtrl = TextEditingController();

    showMaterialModalBottomSheet(
        backgroundColor: themeData.scaffoldBackgroundColor,
        closeProgressThreshold: 10,
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
                          width: screenWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              const Text('Add Art Work', style: TextStyle(fontSize: 16))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                              imagePath: '',
                              function: () {
                                Navigator.of(bsContext).pop();
                                // Get.off(bsContext);
                              },
                              iconData: Icons.close,
                              isIcon: true,
                              iconSize: 32,
                              color: themeData.textTheme.bodyLarge!.color,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  GetBuilder<EventAddScreenController>(
                    builder: (controller) => controller.isArtWorkSelected
                        ? GestureDetector(
                            onTap: () {
                              controller.pickArtWork();
                            },
                            child: GFImageOverlay(
                              image: FileImage(controller.pickedArtWork),
                              boxFit: BoxFit.cover,
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.9,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular((screenHeight / screenWidth) * (Constants.boarderRadius + 3)),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.pickArtWork();
                            },
                            child: GFImageOverlay(
                              image: const NetworkImage('https://res.cloudinary.com/dptexius9/image/upload/v1694398888/assets/07.jpg'),
                              boxFit: BoxFit.cover,
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.9,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular((screenHeight / screenWidth) * (Constants.boarderRadius + 3)),
                            ),
                          ),
                    // id: 'artWork',
                    // assignId: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GetBuilder<EventAddScreenController>(
                    builder: (controller) => DropDownButtonWidget(
                        items: controller.artTypeList,
                        label: 'Type',
                        isRequired: true,
                        selectData: controller.selectArtType,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: controller.artType),
                    // id: 'artType',
                    // assignId: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FlatButtonWidget(
                    title: 'Add',
                    function: () {
                      controller.selectArtWork(bsContext);
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
        title: const Text('Event Add'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              TextFieldWidget(
                labelText: "Event Name",
                hintText: "Event Name",
                enableValidate: true,
                txtCtrl: controller.nameCtrl,
                fontSize: 0.03,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.text,
                validate: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              GetBuilder<EventAddScreenController>(
                builder: (controller) => DropDownButtonWidget(
                  selectData: controller.selectGame,
                  isRequired: true,
                  label: "Game",
                  items: controller.gameNameList,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: controller.gameName,
                ),
                id: 'gameName',
                assignId: true,
              ),
              SizedBox(height: screenHeight * 0.01),
              GetBuilder<EventAddScreenController>(
                builder: (controller) => DropDownButtonWidget(
                  selectData: controller.selectEventType,
                  isRequired: true,
                  label: "Type",
                  items: controller.eventTypeList,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: controller.eventType,
                ),
                id: 'eventType',
                assignId: true,
              ),
              SizedBox(height: screenHeight * 0.01),
              GetBuilder<EventAddScreenController>(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.08),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Art Works',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButtonWidget(
                        imagePath: Assets.iconsAddCircle,
                        function: () {
                          _loadArtWorkBottomSheet(context, screenHeight, screenWidth, themeData);
                        },
                        iconData: Icons.add_circle,
                        isIcon: false,
                        iconSize: screenWidth * 0.07,
                        color: themeData.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<EventAddScreenController>(
                builder: (controller) =>
                    // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                    Container(
                  height: screenHeight * 0.28,
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
                    itemCount: controller.artWorks.length,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                    itemBuilder: (context, index) => ListTileWidgetArtWork(
                      artWorks: controller.artWorks,
                      index: index,
                      removeItem: (index) => controller.removeArtWork(index),
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
                  title: "Save",
                  function: () {
                    controller.createEvent(context);
                  },
                  heightFactor: 0.07,
                  widthFactor: 0.55,
                  color: themeData.colorScheme.secondary),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
      /*floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: ColorConstant.transparentAsh,
        foregroundColor: themeData.colorScheme.secondary,
        spacing: 10,
        elevation: 0,
        children: [
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsTimeTable, sizeFactor: 0.07), label: 'Time Table'),
          SpeedDialChild(
            child: const SVGIconWidget(path: Assets.iconsTeam, sizeFactor: 0.07),
            label: 'Player Team',
            onTap: () {
              if ('value' == "Solo") {
                Get.toNamed(SoloListScreen.routeName, arguments: () {});
              } else if ('value' == "Duo") {
                Get.toNamed(DuoListScreen.routeName, arguments: () {});
              } else if ('value' == "Squad") {
                Get.toNamed(SquadListScreen.routeName, arguments: () {});
              }
            },
          ),
          SpeedDialChild(
              child: const SVGIconWidget(path: Assets.iconsRefTeam, sizeFactor: 0.07),
              label: 'Ref Team',
              onTap: () {
                Get.toNamed(RefListScreen.routeName);
              }),
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsAnnouncement, sizeFactor: 0.07), label: 'Announcements'),
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsRar, sizeFactor: 0.07), label: 'Rules and Regulations'),
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsLocation, sizeFactor: 0.07), label: 'Event Place'),
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsPayments, sizeFactor: 0.07), label: 'Payments'),
          SpeedDialChild(child: const SVGIconWidget(path: Assets.iconsRac, sizeFactor: 0.07), label: 'Reports and Complains'),
        ],
      ),*/
    );
  }
}
