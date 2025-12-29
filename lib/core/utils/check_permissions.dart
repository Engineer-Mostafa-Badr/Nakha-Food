// import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckAppPermissions {
  // check microphone permission ====>>>
  Future<bool> checkMicrophonePermission() async {
    final PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // check camera permission ====>>>
  Future<bool> checkCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // check storage permission ====>>>
  Future<bool> checkStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // check photos permission ====>>>
  Future<bool> checkPhotosPermission() async {
    final PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // // enable location permission ====>>>
  // static Future<bool> enableLocationPermission() async {
  //   final PermissionStatus status = await Permission.location.request();
  //   final PermissionStatus status2 = await Permission.locationAlways.request();
  //   final PermissionStatus status3 =
  //       await Permission.locationWhenInUse.request();
  //   if (!await Geolocator.isLocationServiceEnabled()) {
  //     // enable location service
  //     await Geolocator.openLocationSettings();
  //   }
  //   if (status.isGranted || status2.isGranted || status3.isGranted) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<Position?> getCurrentLocation() async {
  //   Position? position;
  //   try {
  //     final locationStatus = await enableLocationPermission();
  //     if (locationStatus) {
  //       position = await Geolocator.getCurrentPosition();
  //     }
  //     return position;
  //   } catch (e) {
  //     MostUsedFunctions.printFullText('getCurrentLocation: $e');
  //     return position;
  //   }
  // }
  Future<void> requestPermissions() async {
    await Permission.phone.request();
    await Permission.contacts.request();
  }
}
