// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? status;
  String? message;
  ModelUser data;

  User({
    this.status,
    this.message,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        data: ModelUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ModelUser {
  String? id;
  String? email;
  dynamic password;
  String? avatar;
  String? nama;
  dynamic tanggalLahir;
  String? tempatLahir;
  String? telepon;
  String? alamat;
  String? jenisKelamin;
  String? statusPernikahan;
  String? golDarah;
  String? agama;
  String? cabang;
  String? divisi;
  String? jabatan;
  String? status;
  String? superAdmin;
  String? manager;
  String? token;

  ModelUser({
    this.id,
    this.email,
    this.password,
    this.avatar,
    this.nama,
    this.tanggalLahir,
    this.tempatLahir,
    this.telepon,
    this.alamat,
    this.jenisKelamin,
    this.statusPernikahan,
    this.golDarah,
    this.agama,
    this.cabang,
    this.divisi,
    this.jabatan,
    this.status,
    this.superAdmin,
    this.manager,
    this.token,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
        nama: json["nama"],
        tanggalLahir: json["tanggalLahir"],
        tempatLahir: json["tempatLahir"],
        telepon: json["telepon"],
        alamat: json["alamat"],
        jenisKelamin: json["jenisKelamin"],
        statusPernikahan: json["statusPernikahan"],
        golDarah: json["golDarah"],
        agama: json["agama"],
        cabang: json["cabang"],
        divisi: json["divisi"],
        jabatan: json["jabatan"],
        status: json["status"],
        superAdmin: json["superAdmin"],
        manager: json["manager"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "avatar": avatar,
        "nama": nama,
        "tanggalLahir": tanggalLahir,
        "tempatLahir": tempatLahir,
        "telepon": telepon,
        "alamat": alamat,
        "jenisKelamin": jenisKelamin,
        "statusPernikahan": statusPernikahan,
        "golDarah": golDarah,
        "agama": agama,
        "cabang": cabang,
        "divisi": divisi,
        "jabatan": jabatan,
        "status": status,
        "superAdmin": superAdmin,
        "manager": manager,
        "token": token,
      };
}
