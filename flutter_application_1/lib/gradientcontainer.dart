import 'package:flutter/material.dart';
import 'package:flutter_application_1/image_roller.dart';

var left = Alignment.topLeft;
var right = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.colors});
  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: left, end: right),
      ),
      child: const Center(child: DiceRoller()),
    );
  }
}
