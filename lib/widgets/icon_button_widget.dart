import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({Key? key, required this.imagePath, required this.function, required this.iconData, required this.isIcon, required this.iconSize, required this.color}) : super(key: key);

  final String imagePath;
  final VoidCallback function;
  final IconData iconData;
  final bool isIcon;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // color: Theme.of(context).iconTheme.color,
      iconSize: iconSize,
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
              color: color,
            ),
      onPressed: () => function.call(),
    );
  }
}
