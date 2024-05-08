class Karyawan {
  String? name;
  String? jabatan;
  String? email;
  String? avatar;
  String? phoneNumber;
  String? cabang;
  String? id;
  String? posisiKaryawan;
  String? namaOrganisasi;

  Karyawan({
    this.name,
    this.jabatan,
    this.email,
    this.avatar,
    this.phoneNumber,
    this.cabang,
    this.id,
    this.posisiKaryawan,
    this.namaOrganisasi,
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
        name: json["name"] ?? "",
        jabatan: json["jabatan"] ?? "",
        email: json["email"] ?? "",
        avatar: json["avatar"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        cabang: json["cabang"] ?? "",
        id: json["idKaryawan"] ?? "",
        posisiKaryawan: json["posisiKaryawan"] ?? "",
        namaOrganisasi: json["namaOrganisasi"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "jabatan": jabatan,
        "email": email,
        "avatar": avatar,
        "phoneNumber": phoneNumber,
        "cabang": cabang,
        "id": id,
        "posisiKaryawan": posisiKaryawan,
        "namaOrganisasi": namaOrganisasi,
      };
}
