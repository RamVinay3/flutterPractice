import 'package:flutter/material.dart';
import 'package:meals/screens/dish.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals/models/meals.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({
    super.key,
    required this.meal,
  });
  final Meal meal;

  String get upper {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge, //it will cutoff extra things.
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return Dish(
                  meal: meal,
                );
              },
            ),
          );
        },
        child: Stack(children: [
          Hero(
            tag: meal.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover, //to make image not distorted
              height: 200,
              width: double.infinity,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Trait(
                        icon: Icons.schedule,
                        // label: meal.duration.toString(),
                        label: '${meal.duration} min',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Trait(icon: Icons.work, label: upper),
                      const SizedBox(
                        width: 5,
                      ),
                      Trait(icon: Icons.attach_money, label: affordability)
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
