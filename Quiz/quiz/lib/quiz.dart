import 'package:flutter/material.dart';
import 'package:quiz/first_screen.dart';
import 'package:quiz/questions.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //this question marks allow variable to have null value.
  Widget? activeScreen;
  List<String> answers = [];

  void selectedAnswer(answer) {
    answers.add(answer);

    if (answers.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(answers, intialScreen);
      });
    }
  }

//you can write following code
//? var activeScreen='start-screen';
  @override
  void initState() {
    //this method will be called when object was created and before build was
    //getting called.
    activeScreen = FirstScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      //activeScreen='question-screen';
      activeScreen = Question(selectedAnswer);
    });
  }

  void intialScreen() {
    setState(() {
      answers = [];
      activeScreen = FirstScreen(switchScreen);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Center(
            child: activeScreen,
            //child:(activeScreen=='start-screen')?StartScreen():Question()
          ),
        ),
      ),
    );
  }
}
