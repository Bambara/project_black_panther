import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/solo_player_info.dart';
import 'text_button_widget.dart';

class PlayerTileWidget extends StatelessWidget {
  const PlayerTileWidget({Key? key, required this.soloPlayer, required this.index, required this.function, required this.navigate}) : super(key: key);

  final List<SoloPlayerInfo> soloPlayer;
  final int index;
  final VoidCallback function;
  final VoidCallback navigate;

  void get() {
    Logger().i("Call");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(width: 100, height: 100, image: AssetImage("assets/images/user.png"), fit: BoxFit.fill),
            const SizedBox(height: 5),
            const Text('Player IGN'),
            const Text('Club Name'),
            const Text('Clan Name'),
            /*SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButtonWidget(imagePath: 'imagePath', function: () {}, iconData: Icons.remove, isIcon: true),
                  const SizedBox(width: 30, height: 20, child: TextField()),
                  IconButtonWidget(imagePath: 'imagePath', function: () {}, iconData: Icons.add, isIcon: true),
                ],
              ),
            ),*/
            const Spacer(),
            TextButtonWidget(title: 'Add', function: function)
          ],
        ),
      ),
    );
  }
}
