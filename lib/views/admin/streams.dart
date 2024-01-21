import 'package:flutter/material.dart';

import '../../widgets/drawer_menu_widget.dart';

class Streams extends StatelessWidget {
  const Streams({Key? key, required this.openDrawer}) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: DrawerMenuWidget(
          onClicked: openDrawer,
        ),
        backgroundColor: Colors.transparent,
        title: const Text('Streams'),
      ),
    );
  }
}
