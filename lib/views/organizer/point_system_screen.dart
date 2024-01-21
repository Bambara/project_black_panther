import 'package:flutter/material.dart';

import '../../widgets/drawer_menu_widget.dart';

class PointSystemScreen extends StatelessWidget {
  const PointSystemScreen({Key? key, required this.openDrawer}) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: DrawerMenuWidget(
          onClicked: openDrawer,
        ),
        title: const Text('Point System'),
      ),
    );
  }
}
