import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_black_panther/widgets/loading_dialog.dart';

import '../controllers/init_controller.dart';

class InitScreen extends GetView<InitController> {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: Center(
        child: loadingDialog(context),
      ),
    );
  }
}
