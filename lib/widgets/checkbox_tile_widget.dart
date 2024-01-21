import 'package:flutter/material.dart';

class CheckBoxTileWidget extends StatelessWidget {
  CheckBoxTileWidget({Key? key, required this.checkStatus, required this.title, required this.widthFactor}) : super(key: key);

  final bool checkStatus;
  final String title;
  final num widthFactor;

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widthFactor,
      alignment: Alignment.center,

      child: CheckboxListTile(
        title: Text(title),
        activeColor: Colors.blue,
        checkColor: Colors.white,
        value: _isChecked,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (check) {
          if (_isChecked == false) {
            _isChecked = true;
          } else {
            _isChecked = false;
          }
        },
      ), //CheckboxListTile
    );
  }
}
