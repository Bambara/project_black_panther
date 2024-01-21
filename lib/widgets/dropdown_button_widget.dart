import 'package:flutter/material.dart';

import '../core/app_export.dart';

class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget(
      {Key? key, required this.items, required this.label, required this.isRequired, required this.selectData, required this.heightFactor, required this.widthFactor, required this.valveChoose})
      : super(key: key);

  final List items;
  final String label;
  final bool isRequired;
  final Function(String) selectData;
  final num heightFactor;
  final num widthFactor;
  final String valveChoose;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * (widthFactor - 0.05),
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: screenHeight * 0.005, top: screenHeight * 0.01),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize, color: themeData.textTheme.bodyMedium!.color),
              ),
              SizedBox(width: screenWidth * 0.002),
              isRequired
                  ? Text(
                      " *",
                      style: TextStyle(fontSize: themeData.textTheme.bodySmall?.fontSize, color: themeData.colorScheme.error),
                    )
                  : const Text(""),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            color: themeData.colorScheme.secondary.withAlpha(25),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
            //   border: Border.all(color: Colors.black54, width: 0.5),
            // ),
            width: MediaQuery.of(context).size.width * widthFactor,
            height: MediaQuery.of(context).size.height * heightFactor,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                style: TextStyle(fontSize: themeData.textTheme.bodyMedium!.fontSize, color: themeData.textTheme.bodySmall!.color!.withAlpha(200)),
                hint: const Text('Select'),
                iconSize: 30,
                autofocus: true,
                enableFeedback: true,
                isExpanded: true,
                value: valveChoose,
                items: items.map((valueItem) {
                  return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                }).toList(),
                onChanged: (valve) {
                  selectData(valve.toString());
                },
                dropdownColor: themeData.scaffoldBackgroundColor,
                focusColor: themeData.scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
