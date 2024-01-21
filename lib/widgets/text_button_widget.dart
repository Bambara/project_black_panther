import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({Key? key, required this.title, required this.function}) : super(key: key);

  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(title),
      onPressed: function,
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.teal,
        onSurface: Colors.blue,
      ),
    );
  }
}
