class Divisi {
  int status;
  String message;
  Data data;

  Divisi({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Divisi.fromJson(Map<String, dynamic> json) => Divisi(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  DivisiClass divisi;

  Data({
    required this.divisi,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        divisi: DivisiClass.fromJson(json["divisi"]),
      );

  get user => null;

  Map<String, dynamic> toJson() => {
        "divisi": divisi.toJson(),
      };
}

class DivisiClass {
  String nama;

  DivisiClass({
    required this.nama,
  });

  factory DivisiClass.fromJson(Map<String, dynamic> json) => DivisiClass(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
      };
}
