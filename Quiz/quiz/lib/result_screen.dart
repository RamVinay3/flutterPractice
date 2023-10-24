import 'package:flutter/material.dart';
import 'package:quiz/summary.dart';
import 'package:quiz/text_widget.dart';
import 'package:quiz/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.selectedAnswers, this.reset, {super.key});
  final List<String> selectedAnswers;
  final void Function() reset;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < questions.length; i++) {
      summary.add(
        {
          'index': i,
          'question': questions[i].question,
          'answer': questions[i].answer[0],
          'selectedAnswer': selectedAnswers[i],
        },
      );
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summarydata = getSummaryData();
    final correctAnswers = summarydata.where((data) {
      return data['answer'] == data['selectedAnswer'];
    }); //this will return a list to correct answers
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
              'you answered ${correctAnswers.length} out of ${questions.length} questions correctly'),
          const SizedBox(
            height: 30,
          ),
          Summary(summarydata),
          const SizedBox(
            height: 40,
          ),
          TextButton.icon(
            label: const Text('reset'),
            icon: const Icon(Icons.restart_alt_outlined),
            onPressed: reset,
          )
        ],
      ),
    );
  }
}
