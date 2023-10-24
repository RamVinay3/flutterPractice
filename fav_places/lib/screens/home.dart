import 'package:fav_places/providers/places.dart';
import 'package:fav_places/screens/add_place.dart';
import 'package:fav_places/screens/show_place.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<void> placeLoader;

  @override
  void initState() {
    super.initState();
    placeLoader = ref.read(placeprovider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeprovider);

    Widget content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var place in places)
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ShowPlace(
                        place: place,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage: FileImage(place.image),
                        ),
                      ),
                      Text(
                        place.title,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ));
    if (places.isEmpty) {
      content = const Center(
        child: Text(
          'Add your Fav places',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddFavPlace(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: placeLoader,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(child: CircularProgressIndicator())
              : content;
        },
      ),
    );
  }
}
