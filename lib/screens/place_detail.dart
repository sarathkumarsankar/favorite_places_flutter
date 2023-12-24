import 'package:favorite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) {
                           return MapScreen(place: place,pickLocation: false,);
                          })
                        );
                      },
                      child: CircleAvatar(
                        radius: 70,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/map.png',
                            fit: BoxFit
                                .cover, // This will ensure that the image covers the entire circle
                            width:
                                140, // Adjust the width and height according to your needs
                            height: 140,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        place.placeLocation.address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ), textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
