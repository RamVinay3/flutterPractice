import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key, required this.onSelectScreen});

  final void Function(String) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.74)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(children: [
              Icon(Icons.fastfood,
                  size: 24, color: Theme.of(context).colorScheme.primary),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Cooking up....',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            ]),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              onSelectScreen('Meals');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              onSelectScreen('Filters');
            },
          )
        ],
      ),
    );
  }
}
