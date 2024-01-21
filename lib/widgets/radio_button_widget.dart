import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/radio/gf_radio.dart';

import '../core/utils/log.dart';

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({Key? key, required this.title, required this.sizeFactor, required this.onChanged, required this.widthFactor, required this.groupValue, required this.position})
      : super(key: key);

  final String title;
  final double sizeFactor;
  final double widthFactor;
  final Function(Object, int) onChanged;
  final int position;
  final int groupValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      width: screenWidth * widthFactor,
      child: Row(
        children: [
          GFRadio(
            size: screenWidth * sizeFactor,
            value: position,
            groupValue: groupValue,
            onChanged: (value) {
              Log.i('$value $position $groupValue');
              onChanged(value!, position);
              Log.i('$value $position $groupValue');
            },
            activeBorderColor: GFColors.SECONDARY,
            radioColor: GFColors.SUCCESS,
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Text(title, style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
        ],
      ),
    );
  }
}
