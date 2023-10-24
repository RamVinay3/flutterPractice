import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kDarkScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 95, 125));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkScheme),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          // scaffoldBackgroundColor: Color.fromARGB(255, 210, 154, 236),
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            margin: const EdgeInsets.all(20),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kColorScheme.onSecondaryContainer,
                ),
              )),
      // themeMode: ThemeMode.dark,
      //this will decide which theme must be
      //follow,if you do not set it will take system settings.
      home: const Expenses(),
    ),
  );
  // });
}
