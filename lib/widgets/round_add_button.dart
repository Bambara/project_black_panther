import 'package:flutter/material.dart';

class RoundAddButton extends StatefulWidget {
  const RoundAddButton({Key? key, required this.function, required this.borderRadius}) : super(key: key);

  final Function function;
  final double borderRadius;

  @override
  State<RoundAddButton> createState() => _RoundAddButtonState();
}

class _RoundAddButtonState extends State<RoundAddButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.function.call();
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 50,
        height: 50,
        child: const Icon(Icons.add),
        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),
      ),
    );
  }
}
