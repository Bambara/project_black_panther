import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String label;
  final Function(bool) changeStatus;
  final num heightFactor;
  final num widthFactor;
  final bool valveChoose;
  final double? textSize;

  const SwitchWidget({
    Key? key,
    required this.label,
    required this.changeStatus,
    required this.heightFactor,
    required this.widthFactor,
    required this.textSize,
    required this.valveChoose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      height: screenHeight * heightFactor,
      width: screenWidth * widthFactor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: textSize),
          ),
          Switch.adaptive(
            value: valveChoose,
            onChanged: (value) {
              changeStatus(value);
            },
          ),
        ],
      ),
    );
  }
}
