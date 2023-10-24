import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class Dish extends ConsumerWidget {
  const Dish({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fav = ref.watch(favouriteMealProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              //inside function never use watch
              final added =
                  ref.read(favouriteMealProvider.notifier).toggleFavMeal(meal);
              ScaffoldMessenger.of(context).clearSnackBars();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(added
                      ? 'added to favourites.'
                      : 'removed from favourites.'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  // turns: animation,
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                fav.contains(meal) ? Icons.star : Icons.star_border_outlined,
                key: ValueKey(fav.contains(meal)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, //to make image not distorted
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            for (var ingredients in meal.ingredients)
              Text(
                ingredients,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            Text(
              'Making Process',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            for (var ingredients in meal.steps)
              Text(
                ingredients,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
// ;y