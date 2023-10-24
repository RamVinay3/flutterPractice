import 'package:flutter/material.dart';
//except function definitions everywhere semicolon is added
import 'package:flutter_application_1/gradientcontainer.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
          body: GradientContainer(
              colors: [Colors.deepOrangeAccent, Colors.amberAccent])),
    ),
  );
}

//that extension will add a more logic to this class
//without writing anything
