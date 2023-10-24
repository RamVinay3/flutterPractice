import 'package:forms/models/grocery_item.dart';
import 'package:forms/data/categories.dart';
import 'package:forms/models/category.dart';

var groceryItems = [
  GroceryItem(
    id: 'a',
    name: 'Milk',
    quantity: 10000,
    category: categories[Categories.dairy]!,
  ),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 50,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
