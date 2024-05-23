// To parse this JSON data, do
//
//     final izin = izinFromJson(jsonString);

import 'dart:convert';

Izin izinFromJson(String str) => Izin.fromJson(json.decode(str));

String izinToJson(Izin data) => json.encode(data.toJson());

class Izin {
  int status;
  String message;
  List<ModelIzin>? data;

  Izin({
    required this.status,
    required this.message,
    this.data,
  });

  factory Izin.fromJson(Map<String, dynamic> json) => Izin(
        status: json["status"],
        message: json["message"],
        data: List<ModelIzin>.from(
            json["data"].map((x) => ModelIzin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ModelIzin {
  int id;
  String userId;
  int status;
  String alasan;
  String imageKeluar;
  String? imageMasuk;
  DateTime jamKeluar;
  DateTime? jamMasuk;
  String? latKeluar;
  String? longKeluar;
  String? latMasuk;
  String? longMasuk;

  ModelIzin({
    required this.id,
    required this.userId,
    required this.status,
    required this.alasan,
    required this.imageKeluar,
    required this.imageMasuk,
    required this.jamKeluar,
    required this.jamMasuk,
    required this.latKeluar,
    required this.longKeluar,
    required this.latMasuk,
    required this.longMasuk,
  });

  factory ModelIzin.fromJson(Map<String, dynamic> json) => ModelIzin(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
        alasan: json["alasan"],
        imageKeluar: json["imageKeluar"],
        imageMasuk: json["imageMasuk"],
        jamKeluar: DateTime.parse(json["jamKeluar"]),
        jamMasuk:
            json["jamMasuk"] == null ? null : DateTime.parse(json["jamMasuk"]),
        latKeluar: json["latKeluar"],
        longKeluar: json["longKeluar"],
        latMasuk: json["latMasuk"],
        longMasuk: json["longMasuk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
        "alasan": alasan,
        "imageKeluar": imageKeluar,
        "imageMasuk": imageMasuk,
        "jamKeluar": jamKeluar.toIso8601String(),
        "jamMasuk": jamMasuk?.toIso8601String(),
        "latKeluar": latKeluar,
        "longKeluar": longKeluar,
        "latMasuk": latMasuk,
        "longMasuk": longMasuk,
      };
}
