import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late Future<List<Place>> _placesFuture;

  @override
  void initState() {
    super.initState();
        _placesFuture = context.read<UserPlaceProvider>().loadPlaces();

  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = context.watch<UserPlaceProvider>().places;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            print(snapshot.data);
            return PlacesList(places: snapshot.data!);
          }
        },
      ),
    );
  }
}
