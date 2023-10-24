import 'package:flutter/material.dart';
import 'package:flutter_application_1/text_widget.dart';
import 'dart:math';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/dice-images/dice-1.png';

  void rollDice() {
    var integer = random.nextInt(6) + 1;
    setState(() {
      activeDiceImage = 'assets/dice-images/dice-$integer.png';
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
              //   // backgroundColor: Colors.purpleAccent,
              //   // padding: const EdgeInsets.all(15)
              //   padding: const EdgeInsets.only(top: 20),
              ),
          child: const TextWidget('Roll Dice'),
        )
      ],
    );
  }
}
