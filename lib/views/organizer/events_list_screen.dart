import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/organizer/els_controller.dart';
import '../../core/app_export.dart';
import '../../generated/assets.dart';
import '../../routes/bindings/oes_binding.dart';
import '../../widgets/ltw_event.dart';
import 'event_add_screen.dart';

class EventsListScreen extends GetWidget<ELSController> {
  const EventsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
/*      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Event List',
            style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 25),
          ),
          leading: IconButtonWidget(iconData: Icons.arrow_back, function: () {}, imagePath: '', isIcon: true)),*/
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            //backgroundColor: Colors.transparent,
            floating: true,
            snap: true,
            title: Text('Event List'),
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
                itemBuilder: (context, index) => LTWEvent(
                  tEvents: const [],
                  index: index,
                  openEvent: (index) {},
                  editItem: (index) {},
                  openPlayerList: (index) {},
                  openEventList: (index) {},
                  openTimeTable: (index) {},
                  openScoreBoard: (index) {},
                  removeItem: (index) {},
                  organizers: ['', '', ''],
                  sponsors: ['', '', ''],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const EventAddScreen(), binding: OEASBinding(tournament: null)),
        elevation: 0,
        backgroundColor: ColorConstant.transparentAsh,
        child: SvgPicture.asset(Assets.iconsAdd, fit: BoxFit.scaleDown, height: screenWidth * 0.08, width: screenWidth * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
