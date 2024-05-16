class ModelAbsensi {
  int? id;
  String? userAbsensiId;
  String? type;
  String? lang;
  String? lat;
  String? address;
  String? image;
  String? urlImage;
  String? catatan;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelAbsensi({
    this.id,
    this.userAbsensiId,
    this.type,
    this.lang,
    this.lat,
    this.address,
    this.image,
    this.urlImage,
    this.catatan,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelAbsensi.fromJson(Map<String, dynamic> json) => ModelAbsensi(
        id: json["id"],
        userAbsensiId: json["userAbsensiId"],
        type: json["type"],
        lang: json["lang"],
        lat: json["lat"],
        address: json["address"],
        image: json["image"],
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
        "image": image,
        "urlImage": urlImage,
        "catatan": catatan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
