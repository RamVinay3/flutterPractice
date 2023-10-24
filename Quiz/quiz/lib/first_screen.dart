import 'package:flutter/material.dart';
import 'package:quiz/text_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen(
    this.jump, {
    super.key,
  });
  final void Function() jump;
  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 50),
        Image.asset(
          'assets/quiz-logo.png',
          width: 250,
          color: const Color.fromARGB(67, 242, 242, 242),
        ),
        const SizedBox(height: 50),
        const TextWidget('Learn flutter in a funny way'),
        const SizedBox(height: 40),
        OutlinedButton.icon(
            onPressed: jump,
            icon: const Icon(Icons.quiz),
            label: const TextWidget(
              'start quiz',
              fontsize: 20,
            ))
      ],
    );
  }
}
