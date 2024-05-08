import 'dart:convert';

class Jabatan {
  final String? id;
  final String? nama;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Jabatan({
    this.id,
    this.nama,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      id: json['id'],
      nama: json['nama'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static Jabatan? fromJsonString(String jsonString) {
    try {
      final jsonData = jsonDecode(jsonString);
      return Jabatan.fromJson(jsonData);
    } catch (e) {
      print('Error parsing JSON string: $e');
      return null;
    }
  }
}
