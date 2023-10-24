import 'package:meals/data/dummy_data.dart';
import 'package:riverpod/riverpod.dart';

//this is basic type of provider where
// static data is displayed
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
