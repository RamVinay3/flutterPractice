import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 28,
          color: Color.fromARGB(255, 7, 7, 7),
          fontWeight: FontWeight.bold),
    );
  }
}
