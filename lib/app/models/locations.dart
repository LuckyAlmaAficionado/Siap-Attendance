// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

ModelLocations locationsFromJson(String str) =>
    ModelLocations.fromJson(json.decode(str));

String locationsToJson(ModelLocations data) => json.encode(data.toJson());

class ModelLocations {
  String locName;
  int flexible;
  int radius;
  String address;
  String coordinate;
  String lng;
  String lat;
  String createdAt;
  String? updatedAt;

  ModelLocations({
    required this.locName,
    required this.flexible,
    required this.radius,
    required this.address,
    required this.coordinate,
    required this.lng,
    required this.lat,
    required this.createdAt,
    this.updatedAt,
  });

  factory ModelLocations.fromJson(Map<String?, dynamic> json) => ModelLocations(
        locName: json["locName"],
        flexible: json["flexible"],
        radius: json["radius"],
        address: json["address"],
        coordinate: json["coordinate"],
        lng: json["lng"],
        lat: json["lat"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "locName": locName,
        "flexible": flexible,
        "radius": radius,
        "address": address,
        "coordinate": coordinate,
        "lng": lng,
        "lat": lat,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
