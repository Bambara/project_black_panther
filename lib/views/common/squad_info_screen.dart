import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/widgets/text_field_widget.dart';

import '../../models/solo_player_info.dart';
import '../../widgets/player_card_widget.dart';
import 'solo_player_add_screen.dart';

class SquadInfoScreen extends StatefulWidget {
  const SquadInfoScreen({Key? key}) : super(key: key);

  static const routeName = '/player_list_squad_screen';

  @override
  State<SquadInfoScreen> createState() => _SquadInfoScreenState();
}

class _SquadInfoScreenState extends State<SquadInfoScreen> {
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
              'Squad Information',
              style: TextStyle(fontFamily: 'Roboto-Light', fontSize: 20),
            ),
            centerTitle: true,
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFieldWidget(
                hintText: 'Duo Name',
                labelText: 'Duo Name',
                enableValidate: true,
                txtCtrl: _nameCtrl,
                fontSize: 0.03,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.name,
                validate: () {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                hintText: 'Leader IGN',
                labelText: 'Leader IGN',
                enableValidate: true,
                txtCtrl: _nameCtrl,
                fontSize: 0.03,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.name,
                validate: () {},
              ),
              const SizedBox(height: 10),
              /*const FormTextFieldWidget(hintText: 'Clan', label: 'Clan', isRequired: true),
              const SizedBox(height: 10),
              const FormTextFieldWidget(hintText: 'Club', label: 'Club', isRequired: true),
              const SizedBox(height: 10),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                ],
              )
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
      ),
    );
  }
}
