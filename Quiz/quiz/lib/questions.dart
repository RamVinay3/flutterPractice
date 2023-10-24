import 'package:flutter/material.dart';
import 'package:quiz/answer_button.dart';

import 'package:quiz/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  const Question(this.answer, {super.key});
  final void Function(String answer) answer;
  @override
  State<Question> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<Question> {
  var index = 0;
  void changeIndex(item) {
    setState(() {
      widget.answer(item);
      if (index < questions.length - 1) index += 1;
      //index++;
    });
  }

  @override
  Widget build(context) {
    var currentQuestion = questions[index];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            currentQuestion.question,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ...currentQuestion.shuffleList().map((item) {
            return AnswerButton(item, () {
              changeIndex(item);
            });
          }),
          //  OutlinedButton.icon(
          //   onPressed: changeIndex,
          //   icon: const Icon(Icons.arrow_right),
          //   label: const TextWidget(
          //     'start quiz',
          //     fontsize: 20,
          //   ))
          // AnswerButton(currentQuestion.answer[0], () {}),
          // AnswerButton(currentQuestion.answer[1], () {}),
          // AnswerButton(currentQuestion.answer[2], () {}),
          // AnswerButton(currentQuestion.answer[3], () {}),
        ],
      ),
    );
  }
}
