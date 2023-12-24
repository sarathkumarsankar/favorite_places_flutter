# Favorite Places App


The Favorite Places App is a Flutter application that allows users to save and manage their favorite places. Users can pick locations from the map, add images, and store them locally using SQLite. The app also includes features like geocoding to convert latitude and longitude to human-readable addresses.



https://github.com/sarathkumarsankar/favorite_places_flutter/assets/12977299/0d998047-778f-4be2-80d8-b02d0c9c7f9f



## Following packages are used:

1. **Image Picker:**
   - [image_picker](https://pub.dev/packages/image_picker) v1.0.5
   - Flutter plugin for selecting images from the Android and iOS image library, and taking new pictures with the camera.

2. **Location Handling:**
   - [location](https://pub.dev/packages/location) v5.0.3
   - This Flutter plugin to get the device current location.

3. **Geocoding:**
   - [geocoding](https://pub.dev/packages/geocoding) v2.1.1
   - Used to convert latitude and longitude to human-readable addresses.

4. **Path Provider:**
   - [path_provider](https://pub.dev/packages/path_provider) v2.1.1
   - The package provides a platform-agnostic way to access commonly used locations on the device's file system. Used to move temporary image paths to the system path.

5. **Path:**
   - [path](https://pub.dev/packages/path) v1.8.3
   - Helps to create a unique path name to save images.

6. **SQLite:**
   - [sqflite](https://pub.dev/packages/sqflite) v2.3.0
   - Used to store picked places locally.

7. **Location Picker with Flutter Map:**
   - [location_picker_flutter_map](https://pub.dev/packages/location_picker_flutter_map) v2.1.0
   - Used to pick locations from the map and show the given location pointer on the map.
     
## Getting Started

1. Clone the repository.
2. Ensure you have Flutter and Dart installed.
3. Install dependencies using `flutter pub get`.
4. Run the app using `flutter run`.

Feel free to explore, contribute, and make the app even better!
