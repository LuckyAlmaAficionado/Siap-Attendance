class UserAbsensi {
  int? id;
  String? userAbsensiId;
  String? type;
  String? lang;
  String? lat;
  String? address;
  String? imageData;
  String? urlImage;
  String? catatan;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserAbsensi({
    this.id,
    this.userAbsensiId,
    this.type,
    this.lang,
    this.lat,
    this.address,
    this.imageData,
    this.urlImage,
    this.catatan,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAbsensi.fromJson(Map<String, dynamic> json) => UserAbsensi(
        id: json["id"],
        userAbsensiId: json["userAbsensiId"],
        type: json["type"],
        lang: json["lang"],
        lat: json["lat"],
        address: json["address"],
        imageData: json["imageData"],
        urlImage: json["urlImage"],
        catatan: json["catatan"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userAbsensiId": userAbsensiId,
        "type": type,
        "lang": lang,
        "lat": lat,
        "address": address,
        "imageData": imageData,
        "urlImage": urlImage,
        "catatan": catatan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
