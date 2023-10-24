import 'package:fav_places/Models/place.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as systempath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

//different o.s give you different paths to store your data /
//this path_provider makes it easy to know that path

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]); //defines intial state

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'create table fav_places(id Text primary key, title Text,image Text)');
    }, version: 1);
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('fav_places');

    final places = data
        .map(
          (row) => Place(
              title: row['title'] as String,
              image: File(row['image'] as String),
              id: row['id'] as String
              // image: File(row['image'].toString()),
              ),
        )
        .toList();
    state = places;
  }

  void addPlace({required String title, required File image}) async {
    final appDir = await systempath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final Place place = Place(title: title, image: copiedImage);
    print("iam going to get access to db");
    final db = await _getDatabase();
    print(db);

    db.insert(
      'fav_places',
      {'id': place.id, 'title': place.title, 'image': place.image.path},
    );

    state = [...state, place];
  }

  void removePlace(Place item) {
    state = state.where((place) => item.title != place.title).toList();
  }
}

final placeprovider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
