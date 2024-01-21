import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/tournament/duo_info.dart';
import '../../widgets/ltw_duo.dart';
import 'duo_info_screen.dart';

class DuoListScreen extends StatefulWidget {
  const DuoListScreen({Key? key}) : super(key: key);

  static const routeName = '/duo_list_screen';

  @override
  State<DuoListScreen> createState() => _DuoListviewstate();
}

class _DuoListviewstate extends State<DuoListScreen> {
  bool isChecked = false;

  List<DuoInfo> duoTeam = [
    DuoInfo(id: 0, name: 'Duo_01', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Duo_02', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Duo_03', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Duo_04', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
  ];

  void addData(BuildContext context) {
    setState(() {
      duoTeam.add(DuoInfo(id: 0, name: 'Duo_05', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''));
    });
  }

  void removePlayer() {
    setState(() {
      duoTeam.remove(duoTeam.elementAt(1));
    });
  }

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
              'Duo List',
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
                itemCount: duoTeam.length,
                itemBuilder: (context, index) {
                  return ListTileWidgetDuo(
                    navigate: () {},
                    duoTeam: duoTeam,
                    index: index,
                    function: removePlayer,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Get.offNamed(DuoInfoScreen.routeName, arguments: {}), child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
