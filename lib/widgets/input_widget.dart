import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';

class InputWidget extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final bool secret;
  final TextEditingController txtCtrl;

  const InputWidget({Key? key, required this.placeholder, required this.icon, this.secret = false, required this.txtCtrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(12.0), child: Icon(icon, color: ColorConstant.white.withAlpha(75))),
          //Container(width: 1, height: double.infinity, color: ColorConstant.black),
          Expanded(
            child: TextField(
              obscureText: secret,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: ColorConstant.white.withAlpha(75),
                ),
                border: InputBorder.none,
              ),
              controller: txtCtrl,
            ),
          ),
          if (secret) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.remove_red_eye,
                color: ColorConstant.white.withAlpha(75),
              ),
            )
          ],
        ],
      ),
    );
  }
}
