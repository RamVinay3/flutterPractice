import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(this.text, {super.key, this.fontsize = 20});
  final String text;
  final double fontsize;
  @override
  Widget build(context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontsize, color: Colors.white, fontWeight: FontWeight.w500),
    );
  }
}
