import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageButtonWidget extends StatelessWidget {
  final String imagePath;

  // final Function function;
  final VoidCallback function;
  final IconData iconData;
  final bool isIcon;
  final double iconSize;
  final Color color;

  const ImageButtonWidget({Key? key, required this.imagePath, required this.function, required this.iconData, required this.isIcon, required this.iconSize, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isIcon
          ? Icon(
              iconData,
              color: color,
            )
          : SvgPicture.asset(
              imagePath,
              fit: BoxFit.scaleDown,
              height: iconSize,
              width: iconSize,
              // color: color,
            ),
      iconSize: iconSize,
      // onPressed: () {
      //   function.call();
      // },
      onPressed: function,
    );
  }
}
