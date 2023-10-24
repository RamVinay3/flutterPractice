import 'package:flutter/material.dart';

import 'package:meals/models/meals.dart';
import 'package:meals/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});
  final String? title;

  final List<Meal> meals;
  @override
  Widget build(context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealsItem(meal: meals[index]);
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text('uh oh ..nothing here',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 20,
            ),
            Text('choose another category',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
          ],
        ),
      );
    }
    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
