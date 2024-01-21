import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.function}) : super(key: key);

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: const Card(
        elevation: 5,
        child: SizedBox(height: 200, width: 150),
      ),
    );
  }
}
