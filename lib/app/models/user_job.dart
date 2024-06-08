// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

UserJobModel locationsFromJson(String str) =>
    UserJobModel.fromJson(json.decode(str));

String locationsToJson(UserJobModel data) => json.encode(data.toJson());

class UserJobModel {
  String? usersId;
  String? idKaryawan;
  dynamic levelPekerjaanId;
  String? statusPekerjaan;
  DateTime? tglBergabung;
  DateTime? tglBerakhir;
  String? approvalAbsensi;
  String? approvalShift;
  String? approvalLembur;
  String? approvalIzinKembali;
  String? approvalIstirahatTelat;
  DateTime? createdAt;
  String? createdBy;

  UserJobModel({
    this.usersId,
    this.idKaryawan,
    this.levelPekerjaanId,
    this.statusPekerjaan,
    this.tglBergabung,
    this.tglBerakhir,
    this.approvalAbsensi,
    this.approvalShift,
    this.approvalLembur,
    this.approvalIzinKembali,
    this.approvalIstirahatTelat,
    this.createdAt,
    this.createdBy,
  });

  factory UserJobModel.fromJson(Map<String, dynamic> json) => UserJobModel(
        usersId: json["usersId"],
        idKaryawan: json["idKaryawan"],
        levelPekerjaanId: json["levelPekerjaanId"],
        statusPekerjaan: json["statusPekerjaan"],
        tglBergabung: DateTime.parse(json["tglBergabung"]),
        tglBerakhir: DateTime.parse(json["tglBerakhir"]),
        approvalAbsensi: json["approvalAbsensi"],
        approvalShift: json["approvalShift"],
        approvalLembur: json["approvalLembur"],
        approvalIzinKembali: json["approvalIzinKembali"],
        approvalIstirahatTelat: json["approvalIstirahatTelat"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "usersId": usersId,
        "idKaryawan": idKaryawan,
        "levelPekerjaanId": levelPekerjaanId,
        "statusPekerjaan": statusPekerjaan,
        "tglBergabung": tglBergabung!.toIso8601String(),
        "tglBerakhir": tglBerakhir!.toIso8601String(),
        "approvalAbsensi": approvalAbsensi,
        "approvalShift": approvalShift,
        "approvalLembur": approvalLembur,
        "approvalIzinKembali": approvalIzinKembali,
        "approvalIstirahatTelat": approvalIstirahatTelat,
        "createdAt": createdAt!.toIso8601String(),
        "createdBy": createdBy,
      };
}
