import 'dart:convert';

ModelLogin userFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String userToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  int status;
  String message;
  ModelData data;

  ModelLogin({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        status: json["status"],
        message: json["message"],
        data: ModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ModelData {
  String token;
  String? divisi;
  String? jabatan;
  ModelUser user;

  ModelData({
    required this.token,
    this.divisi,
    this.jabatan,
    required this.user,
  });

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
        token: json["token"],
        divisi: json["divisi"] ?? "",
        jabatan: json["jabatan"] ?? "",
        user: ModelUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "divisi": divisi,
        "jabatan": jabatan,
        "user": user.toJson(),
      };
}

class ModelUser {
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

  ModelUser({
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

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        id: json["id"],
        email: json["email"],
        avatar: json["avatar"],
        nama: json["nama"],
        tanggalLahir: json["tanggalLahir"] ?? "",
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
