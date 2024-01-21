import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class CheckBoxWidget extends StatelessWidget {
  CheckBoxWidget({Key? key, required this.checkStatus, required this.title, required this.sizeFactor, required this.onChanged, required this.widthFactor}) : super(key: key);

  final bool checkStatus;
  final String title;
  final double sizeFactor;
  final double widthFactor;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      width: screenWidth * widthFactor,
      child: Row(
        children: [
          GFCheckbox(
            activeBgColor: GFColors.SUCCESS,
            onChanged: (value) {
              onChanged(value);
            },
            // size: screenWidth * sizeFactor,
            size: screenWidth * sizeFactor,
            value: checkStatus,
          ),
          Text(title),
        ],
      ),
    );
  }
}
