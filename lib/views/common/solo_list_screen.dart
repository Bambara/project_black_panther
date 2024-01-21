import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/organizer/sls_controller.dart';
import '../../widgets/ltw_solo.dart';
import 'solo_player_add_screen.dart';

class SoloListScreen extends GetView<SLSController> {
  const SoloListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Player List - Solo',
          style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 20),
        ),
        leading: IconButtonWidget(iconData: Icons.arrow_back, function: () {}, imagePath: '', isIcon: true),
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            floating: true,
            snap: true,
            title: Text(
              'Player List - Solo',
              style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 20),
            ),
            centerTitle: true,
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                addAutomaticKeepAlives: false,
                cacheExtent: 100,
                itemCount: controller.soloPlayer.length,
                itemBuilder: (context, index) {
                  return LTWSolo(
                    navigate: () {},
                    soloPlayer: controller.soloPlayer,
                    index: index,
                    function: controller.removePlayer,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Get.toNamed(SoloPlayerAddScreen.routeName, arguments: {}), child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
