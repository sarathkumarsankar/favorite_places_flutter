import 'dart:io';
import 'package:geocoding/geocoding.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double lat;
  final double long;
  final String address;
  PlaceLocation({required this.lat, required this.long, required this.address});
}

class Place {
  Place(
      {required this.title,
      required this.image,
      required this.placeLocation,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;
}

Future<String> addressFromLatLan(double lat, double long) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  final placemark = placemarks[0];
  return "${placemark.street}, ${placemark.country}, ${placemark.postalCode}";
}
