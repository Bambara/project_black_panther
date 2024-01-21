import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/generated/assets.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/image_button_widget.dart';

class SoloPlayerAddScreen extends StatelessWidget {
  static const routeName = '/solo_player_add_screen';

  const SoloPlayerAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            'Add Solo Player',
            style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 20),
          ),
          leading: ImageButtonWidget(
            iconData: Icons.arrow_back,
            function: () => Get.back(),
            imagePath: '',
            isIcon: true,
            iconSize: 16,
            color: themeData.textTheme.bodySmall!.color!,
          )),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10),
            child: Column(children: [
              Container(
                //padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    print("Tap");
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.07,
                    backgroundImage: const AssetImage(Assets.iconsCamera),
                    backgroundColor: Colors.grey.shade600,
                  ),
                ),
              ),
              DropDownButtonWidget(
                selectData: (value) {},
                isRequired: true,
                label: "Player IGN",
                items: const ["None", "Player"],
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: '',
              ),
              const SizedBox(height: 10),
              DropDownButtonWidget(
                selectData: (value) {},
                isRequired: true,
                label: "Player Name",
                items: const ["None", "Name"],
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: '',
              ),
              const SizedBox(height: 10),
              DropDownButtonWidget(
                selectData: (value) {},
                isRequired: true,
                label: "Club",
                items: const ["None", 'Club'],
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: '',
              ),
              const SizedBox(height: 10),
              DropDownButtonWidget(
                selectData: (value) {},
                isRequired: true,
                label: "Clan",
                items: const ["None", 'Clan'],
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: '',
              ),
              const SizedBox(height: 10),
            ]),
          ),
          Column(
            children: [
              FlatButtonWidget(title: "Add Player", function: () => Get.back(), heightFactor: 0.07, widthFactor: 0.9, color: ColorConstant.buttonBlue),
              const SizedBox(height: 20),
            ],
          ),
        ]),
      ),
    );
  }
}
