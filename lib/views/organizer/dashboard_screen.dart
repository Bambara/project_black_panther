import 'package:flutter/material.dart';

import '../../widgets/drawer_menu_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key, required this.openDrawer}) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.appBarTheme.backgroundColor,
            foregroundColor: themeData.appBarTheme.foregroundColor,
            floating: true,
            snap: true,
            title: const Text('Dashboard'),
            centerTitle: true,
            leading: DrawerMenuWidget(
              onClicked: openDrawer,
            ),
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
