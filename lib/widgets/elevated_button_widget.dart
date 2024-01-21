import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({Key? key, required this.function, required this.title, required this.heightFactor, required this.widthFactor}) : super(key: key);

  final VoidCallback function;
  final String title;
  final num heightFactor;
  final num widthFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
        ),
        onPressed: function,
        child: Text(title),
      ),
    );
  }
}
