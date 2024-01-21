import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/widgets/text_field_widget.dart';

import '../../models/solo_player_info.dart';
import '../../widgets/player_card_widget.dart';
import 'solo_player_add_screen.dart';

class DuoInfoScreen extends StatefulWidget {
  const DuoInfoScreen({Key? key}) : super(key: key);

  static const routeName = '/player_list_duo_screen';

  @override
  State<DuoInfoScreen> createState() => _DuoInfoScreenState();
}

class _DuoInfoScreenState extends State<DuoInfoScreen> {
  bool isChecked = false;

  List<SoloPlayerInfo> soloPlayer = [
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 0, ign: 'Bambara', name: 'Buddhika', club: 'No', clan: 'God'),
    SoloPlayerInfo(id: 1, ign: 'Ronnie', name: 'Uditha', club: 'No', clan: 'God')
  ];

  final TextEditingController _nameCtrl = TextEditingController();

  void addData(BuildContext context) {
    setState(() {
      soloPlayer.add(SoloPlayerInfo(id: 2, ign: 'Sanju', name: 'Sanjaya', club: 'No', clan: 'God'));
    });
  }

  void removePlayer() {
    setState(() {
      soloPlayer.remove(soloPlayer.elementAt(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            floating: true,
            snap: true,
            title: Text(
              'Duo Information',
              style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 20),
            ),
            centerTitle: true,
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFieldWidget(
              hintText: 'Duo Name',
              labelText: 'Duo Name',
              txtCtrl: _nameCtrl,
              fontSize: 0.03,
              enableValidate: true,
              secret: false,
              heightFactor: 0.055,
              widthFactor: 0.9,
              inputType: TextInputType.text,
              validate: () {},
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              hintText: 'Leader IGN',
              labelText: 'Leader IGN',
              txtCtrl: _nameCtrl,
              fontSize: 0.03,
              enableValidate: true,
              secret: false,
              heightFactor: 0.055,
              widthFactor: 0.9,
              inputType: TextInputType.text,
              validate: () {},
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              hintText: 'Clan',
              labelText: 'Clan',
              txtCtrl: _nameCtrl,
              fontSize: 0.03,
              enableValidate: true,
              secret: false,
              heightFactor: 0.055,
              widthFactor: 0.9,
              inputType: TextInputType.text,
              validate: () {},
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              hintText: 'Club',
              labelText: 'Club',
              txtCtrl: _nameCtrl,
              fontSize: 0.03,
              enableValidate: true,
              secret: false,
              heightFactor: 0.055,
              widthFactor: 0.9,
              inputType: TextInputType.text,
              validate: () {},
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlayerCard(
                  function: () => Get.toNamed(SoloPlayerAddScreen.routeName, arguments: {}),
                ),
                PlayerCard(
                  function: () => Get.toNamed(SoloPlayerAddScreen.routeName, arguments: {}),
                ),
              ],
            ),
            /*Expanded(
              child: GridView.builder(
                addAutomaticKeepAlives: false,
                cacheExtent: 10,
                itemCount: soloPlayer.length,
                itemBuilder: (context, index) {
                  return PlayerTileWidget(
                    navigate: () {},
                    soloPlayer: soloPlayer,
                    index: index,
                    function: removePlayer,
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  childAspectRatio: 1 / 1,
                  //crossAxisSpacing: 5,
                  //mainAxisSpacing: 5,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
