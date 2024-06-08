import 'dart:math' show sin, cos, sqrt, atan2;

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  askingPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return true;
  }

  Future<Position> getCurrentLocation() async {
    bool result = await askingPermissions();

    if (result) {
      // ... mendapatkan value dari location
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // ... mengembalikan position
    }

    return Future.error("Error location error");
  }

  // Fungsi untuk mengonversi derajat ke radian
  double toRadians(double degree) {
    return degree * (3.14 / 180);
  }

// Fungsi untuk menghitung jarak antara dua koordinat dalam meter menggunakan rumus Haversine
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000.0; // Radius bumi dalam meter
    double dLat = toRadians(lat2 - lat1);
    double dLon = toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(toRadians(lat1)) *
            cos(toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;
    return distance;
  }

// Fungsi untuk memeriksa apakah pengguna berada dalam jarak maksimum yang diizinkan dari titik referensi
  bool isWithinRange(double userLatitude, double userLongitude,
      double targetLatitude, double targetLongitude, double maxDistance) {
    double distance = calculateDistance(
      userLatitude,
      userLongitude,
      targetLatitude,
      targetLongitude,
    );

    return distance <= maxDistance;
  }
}
