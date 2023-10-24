import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian }

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false
        });
  void setFilters(Map<Filters, bool> filters) {
    //you can give whole things here and it will create another memory
    state = filters;
    //in code you simply could have given logic as it is
    //whenever popping you could have called these function and set all values once
    //thus you can keep both local and global variables there.
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
    //this way a new memory is getting created;
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (filters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    } else if (filters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    } else if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
  ;
});
