import 'package:meals/models/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.onTap});
  final Category category;
  final void Function(BuildContext, Category) onTap;
  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        onTap(context, category);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.45),
            category.color.withOpacity(0.92),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
