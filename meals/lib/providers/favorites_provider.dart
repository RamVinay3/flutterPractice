import 'package:meals/models/meals.dart';
import 'package:riverpod/riverpod.dart';

//we will use StateNotifierProvider to
//deal with dynamically changing values.

// to use StateNotifierProvider we have to
//work with another class Noitifier
//which is of generic

class FavMealNotifier extends StateNotifier<List<Meal>> {
  FavMealNotifier() : super([]);

  bool toggleFavMeal(Meal meal) {
    //when using notifier you can't use add or remove
    //methods because you are using memory again.
    // you should alway create new memory`

    //it is best to replace it

    final isMealFavouriteAlready = state.contains(meal);
    if (isMealFavouriteAlready) {
      //we have to remove it but we can't use same memoery so
      //we use where method
      //state is the object which contains our value.
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    } else {
      //use spread operator ṭo add  into array
      state = [...state, meal];
      return true;
    }
    //thus we are creating new memory
  }
}

final favouriteMealProvider =
    StateNotifierProvider<FavMealNotifier, List<Meal>>(
        (ref) => FavMealNotifier());
