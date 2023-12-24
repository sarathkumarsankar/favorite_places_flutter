import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as systempath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlaceProvider extends ChangeNotifier {
   List<Place> places = [];

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<List<Place>> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final placesList = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            placeLocation: PlaceLocation(
              lat: row['lat'] as double,
              long: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
        places = placesList;
        return placesList;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await systempath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newPlace =
        Place(title: title, image: copiedImage, placeLocation: location);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.placeLocation.lat,
      'lng': newPlace.placeLocation.long,
      'address': newPlace.placeLocation.address,
    });

    places.add(newPlace);
    notifyListeners();
  }

}
