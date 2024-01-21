import 'package:flutter/material.dart';

import '../core/constants/constants.dart';

class TimePickerWidget extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;
  final Function(String) getTime;
  final String selectedTime;

  const TimePickerWidget({Key? key, required this.heightFactor, required this.widthFactor, required this.getTime, required this.selectedTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
      child: Container(
        width: screenWidth * widthFactor,
        height: screenHeight * heightFactor,
        color: themeData.colorScheme.secondary.withAlpha(25),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.02)),
        //   border: Border.all(color: Colors.black54, width: 0.5),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth * (widthFactor / 1.45),
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              // decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: Text(selectedTime, style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
            ),
            MaterialButton(
                minWidth: screenWidth * (widthFactor / 7),
                child: Icon(Icons.access_time_rounded, size: screenWidth * (widthFactor / 7)),
                onPressed: () async {
                  await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((pickedTime) {
                    if (pickedTime != null) {
                      // getDate(_selectedDate);
                      getTime(pickedTime.format(context));
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
