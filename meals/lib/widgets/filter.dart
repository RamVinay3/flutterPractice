import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:meals/providers/filter_provider.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key});

  @override
  ConsumerState<Filter> createState() {
    return _FilterState();
  }
}

class _FilterState extends ConsumerState<Filter> {
  //we can access widget.anything only in methods not outside
  // methods so we  will call using init method;
  // @override
  // void initState() {
  //   super.initState();
  //   glutten = widget.currentFilters[Filters.glutenFree]!;
  //   lactose = widget.currentFilters[Filters.lactoseFree]!;
  //   vegetarian = widget.currentFilters[Filters.vegetarian]!;
  // }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterProvider.notifier);
    final filterValue = ref.watch(filterProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text('Your Filters')),
          body: Column(
            children: [
              SwitchListTile(
                value: filterValue[Filters.glutenFree]!,
                onChanged: (selected) {
                  filter.setFilter(Filters.glutenFree, selected);
                },
                title: Text(
                  'Glutten-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'glutten free food included...',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: filterValue[Filters.lactoseFree]!,
                onChanged: (selected) {
                  filter.setFilter(Filters.lactoseFree, selected);
                },
                title: Text(
                  'Lactose-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Lactose free food included...',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: filterValue[Filters.vegetarian]!,
                onChanged: (selected) {
                  filter.setFilter(Filters.vegetarian, selected);
                },
                title: Text(
                  'Vegetarian-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Vegetarian free food included...',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: EdgeInsets.only(left: 34, right: 22),
              )
            ],
          )),
    );
  }
}
