import 'package:flutter/material.dart';

import '../core/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool enableValidate;
  final bool secret;
  final TextEditingController txtCtrl;
  final double fontSize;
  final double heightFactor;
  final double widthFactor;
  final TextInputType inputType;
  final VoidCallback validate;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.enableValidate,
    required this.txtCtrl,
    required this.fontSize,
    required this.secret,
    required this.heightFactor,
    required this.widthFactor,
    required this.inputType,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      width: screenWidth * widthFactor,
      height: screenHeight * heightFactor,
      child: TextField(
        controller: txtCtrl,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        obscureText: secret,
        onTapOutside: (event) {
          if (enableValidate) {
            validate;
          }
        },
        onEditingComplete: () {
          if (enableValidate) {
            validate();
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          fillColor: themeData.colorScheme.secondary.withAlpha(25),
          constraints: const BoxConstraints.expand(),
          filled: true,
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius))),
          focusedBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
        ),
        // decoration: InputDecoration(
        //   labelText: label,
        //   hintText: hint,
        //   fillColor: themeData.colorScheme.secondary.withAlpha(25),
        //   constraints: const BoxConstraints.tightFor(),
        //   filled: true,
        //   border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius))),
        // ),
      ),
    );
  }
}
