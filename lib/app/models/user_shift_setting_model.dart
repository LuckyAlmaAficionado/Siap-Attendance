import 'dart:convert';

UserShiftSettingModel locationsFromJson(String str) =>
    UserShiftSettingModel.fromJson(json.decode(str));

String locationsToJson(UserShiftSettingModel data) =>
    json.encode(data.toJson());

class UserShiftSettingModel {
  String? id;
  String? shiftName;
  String? scheduleIn;
  String? scheduleOut;
  String? breakStart;
  String? breakEnd;
  String? description;
  int? dayoff;
  int? shiftAllEmployee;
  int? showInRequest;
  String? createdAt;

  UserShiftSettingModel({
    this.id,
    this.shiftName,
    this.scheduleIn,
    this.scheduleOut,
    this.breakStart,
    this.breakEnd,
    this.description,
    this.dayoff,
    this.shiftAllEmployee,
    this.showInRequest,
    this.createdAt,
  });

  factory UserShiftSettingModel.fromJson(Map<String, dynamic> json) =>
      UserShiftSettingModel(
        id: json["id"],
        shiftName: json["shiftName"] ?? "",
        scheduleIn: json["scheduleIn"] ?? "",
        scheduleOut: json["scheduleOut"] ?? "",
        breakStart: json["breakStart"] ?? "",
        breakEnd: json["breakEnd"] ?? "",
        description: json["description"] ?? "",
        dayoff: json["dayoff"],
        shiftAllEmployee: json["shiftAllEmployee"],
        showInRequest: json["showInRequest"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shiftName": shiftName,
        "scheduleIn": scheduleIn,
        "scheduleOut": scheduleOut,
        "breakStart": breakStart,
        "breakEnd": breakEnd,
        "description": description,
        "dayoff": dayoff,
        "shiftAllEmployee": shiftAllEmployee,
        "showInRequest": showInRequest,
        "createdAt": createdAt,
      };
}
