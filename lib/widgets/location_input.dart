import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onGettingCurrentLocation});

  final Function(PlaceLocation location)? onGettingCurrentLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? selectedLocation;
  bool isLocationFetching = false;
  String? currentAddress;
  TextEditingController addressController = TextEditingController();

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isLocationFetching = true;
    });

    try {
      selectedLocation = await location.getLocation();
      final address = await addressFromLatLan(
          selectedLocation!.latitude!, selectedLocation!.longitude!);
      currentAddress = address;
      addressController.text = address;
    } catch (e) {
      print('Error getting location: $e');
    }
    setState(() {
      isLocationFetching = false;
    });
    widget.onGettingCurrentLocation!(PlaceLocation(
        lat: selectedLocation!.latitude!,
        long: selectedLocation!.longitude!,
        address: currentAddress!));
    // print('Location received: $selectedLocation');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
              controller: addressController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onEditingComplete: () {
                widget.onGettingCurrentLocation!(PlaceLocation(
                    lat: selectedLocation?.latitude ?? 0,
                    long: selectedLocation?.longitude ?? 0,
                    address: addressController.text));
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            if (isLocationFetching)
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                getCurrentLocation();
              },
              label: const Text('Get current location'),
              icon: const Icon(Icons.location_on),
              clipBehavior: Clip.antiAlias,
            ),
            TextButton.icon(
              onPressed: () {
                goToMap();
              },
              label: const Text('Pick from map'),
              icon: const Icon(CupertinoIcons.map),
              clipBehavior: Clip.antiAlias,
            )
          ],
        ),
      ],
    );
  }

  void goToMap() async {
    final PlaceLocation? pickedPlace = await Navigator.of(context)
        .push<PlaceLocation>(MaterialPageRoute(builder: (ctx) {
      return const MapScreen(
        pickLocation: true,
      );
    }));

    if (pickedPlace != null) {
      // Data received from MapScreen (Place object)
      addressController.text = pickedPlace.address;
      print('Received data from MapScreen: ${pickedPlace}');
      widget.onGettingCurrentLocation!(PlaceLocation(
          lat: pickedPlace.lat,
          long: pickedPlace.long,
          address: pickedPlace.address));
    } else {
      // User might have canceled or closed the MapScreen without selecting a location
      print('MapScreen was closed without selecting a location.');
    }
  }
}
