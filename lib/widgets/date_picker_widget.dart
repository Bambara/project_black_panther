import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/constants.dart';

class DatePickerWidget extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;
  final Function(String) getDate;
  final String selectedDate;

  const DatePickerWidget({Key? key, required this.heightFactor, required this.widthFactor, required this.getDate, required this.selectedDate}) : super(key: key);

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
              child: Text(selectedDate, style: TextStyle(fontSize: themeData.textTheme.bodySmall!.fontSize)),
            ),
            MaterialButton(
                minWidth: screenWidth * (widthFactor / 8),
                // height: screenWidth * (widthFactor / 10),
                child: Icon(Icons.calendar_today_outlined, size: screenWidth * (widthFactor / 8)),
                onPressed: () async {
                  await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year), lastDate: DateTime(2030)).then((pickedDate) {
                    if (pickedDate != null) {
                      // getDate(_selectedDate);
                      getDate(DateFormat.yMd().format(pickedDate).toString());
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
