# Favorite Places App


The Favorite Places App is a Flutter application that allows users to save and manage their favorite places. Users can pick locations from the map, add images, and store them locally using SQLite. The app also includes features like geocoding to convert latitude and longitude to human-readable addresses.



https://github.com/sarathkumarsankar/favorite_places_flutter/assets/12977299/0d998047-778f-4be2-80d8-b02d0c9c7f9f



## Following packages are used:

- **Image Picker:** Flutter plugin for selecting images from the Android and iOS image library and taking new pictures with the camera.
  - Dependency: [image_picker](https://pub.dev/packages/image_picker) v1.0.5

- **Location:** Flutter plugin for handling location on Android and iOS. Provides callbacks when the location is changed.
  - Dependency: [location](https://pub.dev/packages/location) v5.0.3

- **Geocoding:** Flutter Geocoding plugin for easy geocoding and reverse-geocoding features. Converts latitude and longitude to human-readable addresses.
  - Dependency: [geocoding](https://pub.dev/packages/geocoding) v2.1.1

- **Path Provider:** Platform-agnostic package to access commonly used locations on the device's file system. Used to move temporary image paths to the system path.
  - Dependency: [path_provider](https://pub.dev/packages/path_provider) v2.1.1

- **Path:** Helps create unique path names to save images.
  - Dependency: [path](https://pub.dev/packages/path) v1.8.3

- **SQLite:** Used for storing picked places locally.
  - Dependency: [sqflite](https://pub.dev/packages/sqflite) v2.3.0

- **Location Picker with Flutter Map:** Allows users to pick locations from the map and shows the current location pointer on the map.
  - Dependency: [location_picker_flutter_map](https://pub.dev/packages/location_picker_flutter_map) v2.1.0


## Getting Started

1. Clone the repository.
2. Ensure you have Flutter and Dart installed.
3. Install dependencies using `flutter pub get`.
4. Run the app using `flutter run`.

Feel free to explore, contribute, and make the app even better!
