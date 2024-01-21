import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/models/tournament/duo_info.dart';
import 'package:project_black_panther/widgets/ltw_squad.dart';

import 'squad_info_screen.dart';

class SquadListScreen extends StatefulWidget {
  const SquadListScreen({Key? key}) : super(key: key);

  static const routeName = '/squad_list_screen';

  @override
  State<SquadListScreen> createState() => _SquadListScreenState();
}

class _SquadListScreenState extends State<SquadListScreen> {
  bool isChecked = false;

  List<DuoInfo> duoTeam = [
    DuoInfo(id: 0, name: 'Squad_01', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Squad_02', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Squad_03', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
    DuoInfo(id: 0, name: 'Squad_04', club: 'No', clan: 'God', point: '', score: '', side: '', leaderIGN: ''),
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
              'Squad List',
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
                  return ListTileWidgetSquad(
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
      floatingActionButton: FloatingActionButton(onPressed: () => Get.toNamed(SquadInfoScreen.routeName, arguments: {}), child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
