import 'package:flutter/material.dart';

class TileTextFieldWidget extends StatelessWidget {
  const TileTextFieldWidget({Key? key, required this.hintText, required this.widthFactor, required this.heightFactor, required this.inputType, required this.getText, required this.textController})
      : super(key: key);

  final String hintText;
  final num widthFactor;
  final num heightFactor;
  final TextEditingController textController;
  final TextInputType inputType;
  final Function(String value) getText;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtCtrl = TextEditingController();

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * widthFactor,
          height: MediaQuery.of(context).size.height * heightFactor,
          child: TextField(
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              getText(value);
            },
            controller: txtCtrl,
            obscureText: false,
            keyboardType: inputType,
            decoration: InputDecoration(
                hintText: hintText,
                //labelText: hintText,
                labelStyle: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
