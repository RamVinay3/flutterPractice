import 'package:flutter/material.dart';
import 'package:quiz/text_widget.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.text, this.onTap, {super.key});
  final String text;
  final void Function() onTap;
  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 128, 1, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
        ),
        child: TextWidget(text),
      ),
    );
  }
}
