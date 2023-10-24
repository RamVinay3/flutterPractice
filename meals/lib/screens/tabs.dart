import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:meals/screens/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/filter.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filter_provider.dart';

//stateful widget will be changed to consumerStateful widget
//which will give some options to do things

//for stateless we could have used ConsumerWidget directly
class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _Tabs();
  }
}

class _Tabs extends ConsumerState<Tabs> {
  //now we can use ref because of consumer state
  //ref.read() to get values from provider
  //ref.watch() to reload build whenever the values are changed
  //you should use ref.watch as much as possible.
  int _selectedPage = 0;
  // final List<Meal> fav = [];

  void _selectPage(index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void setScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'Filters') {
      final result = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const Filter()));
      // .push<Map<Filters, bool>>(MaterialPageRoute(
      //     builder: (ctx) => Filter(
      //           currentFilters: selectedFilters,
      //         )));
      // .pushReplacement(MaterialPageRoute(builder: (ctx) => Filter()));
      // setState(() {
      //   selectedFilters = result ?? kIntialFilters;

      //   //?? is a special key which allows us to fall back to certain value
      //   //if given value  or assigned value is null;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favObj = ref.watch(favouriteMealProvider);

    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoryScreen(availableMeals: availableMeals);
    String activePageTitle = 'Category';
    if (_selectedPage == 1) {
      activePage = MealsScreen(
        meals: favObj,
      );
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      drawer: SideDrawer(
        onSelectScreen: setScreen,
      ),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Your Favourites')
        ],
      ),
    );
  }
}
