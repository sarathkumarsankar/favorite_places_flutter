import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen(
      {super.key,
      this.place,
      required this.pickLocation,
      this.onGettingCurrentLocation});
  final Place? place;
  final bool pickLocation;
  final Function(PlaceLocation location)? onGettingCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: FlutterLocationPicker(
            initPosition: pickLocation
                ? null
                : LatLong(place!.placeLocation.lat, place!.placeLocation.long),
            selectLocationButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            selectedLocationButtonTextstyle:
                const TextStyle(fontSize: 18, color: Colors.white),
            selectLocationButtonText: 'Set Current Location',
            selectLocationButtonLeadingIcon: const Icon(Icons.check),
            searchBarTextColor: Colors.white,
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 16,
            //Configuralble
            showSearchBar: pickLocation ? true : false,
            showSelectLocationButton: pickLocation ? true : false,
            showLocationController: pickLocation ? true : false,
            trackMyPosition: false,
            onError: (e) => print(e),
            onPicked: (pickedData) {
              final place = PlaceLocation(
                  lat: pickedData.latLong.latitude,
                  long: pickedData.latLong.longitude,
                  address: pickedData.address);
              Navigator.of(context).pop(place);
            },
            onChanged: (pickedData) {
              onGettingCurrentLocation!(PlaceLocation(
                  lat: pickedData.latLong.latitude,
                  long: pickedData.latLong.longitude,
                  address: pickedData.address));
            }));
  }
}
