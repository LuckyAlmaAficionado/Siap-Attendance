// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int status;
  String message;
  Data data;

  User({
    required this.status,
    required this.message,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  String token;
  String divisi;
  String jabatan;
  UserData user;

  Data({
    required this.token,
    required this.divisi,
    required this.jabatan,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        divisi: json["divisi"],
        jabatan: json["jabatan"],
        user: UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "divisi": divisi,
        "jabatan": jabatan,
        "user": user.toJson(),
      };
}

class UserData {
  String? id;
  String? email;
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
  String? cabangId;
  String? divisiId;
  String? jabatanId;
  String? status;
  String? superAdmin;
  String? manager;
  String? username;

  UserData({
    this.id,
    this.email,
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
    this.cabangId,
    this.divisiId,
    this.jabatanId,
    this.status,
    this.superAdmin,
    this.manager,
    this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
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
        cabangId: json["cabangId"],
        divisiId: json["divisiId"],
        jabatanId: json["jabatanId"],
        status: json["status"],
        superAdmin: json["superAdmin"],
        manager: json["manager"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
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
        "cabangId": cabangId,
        "divisiId": divisiId,
        "jabatanId": jabatanId,
        "status": status,
        "superAdmin": superAdmin,
        "manager": manager,
        "username": username,
      };
}
