import 'package:flutter/material.dart';

import '../core/app_export.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({Key? key, required this.title, required this.function, required this.heightFactor, required this.widthFactor, required this.color}) : super(key: key);

  final String title;
  final VoidCallback function;
  final num heightFactor;
  final num widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      width: screenWidth * widthFactor,
      height: screenHeight * heightFactor,
      child: MaterialButton(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius),
          ),
        ),
        onPressed: function,
        child: Center(
          child: Text(title,
              style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize, fontStyle: themeData.textTheme.titleMedium!.fontStyle, color: themeData.textTheme.titleMedium!.color)),
        ),
      ),
    );
  }
}
