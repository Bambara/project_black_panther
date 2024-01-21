import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key, required this.onClicked}) : super(key: key);

  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return IconButton(
      onPressed: onClicked,
      icon: const FaIcon(FontAwesomeIcons.alignLeft),
      color: themeData.appBarTheme.foregroundColor,
    );
  }
}
