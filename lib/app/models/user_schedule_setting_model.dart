class UserScheduleSettingModel {
  final String? id;
  final String? schName;
  final DateTime? effectiveDate;
  final String? shiftPattern;
  final String? description;
  final DateTime? createdAt;
  final String? createdBy;

  UserScheduleSettingModel({
    this.id,
    this.schName,
    this.effectiveDate,
    this.shiftPattern,
    this.description,
    this.createdAt,
    this.createdBy,
  });

  factory UserScheduleSettingModel.fromJson(Map<String, dynamic> json) {
    return UserScheduleSettingModel(
      id: json['id'] as String?,
      schName: json['schName'] as String?,
      effectiveDate: json['effectiveDate'] != null
          ? DateTime.parse(json['effectiveDate'])
          : null,
      shiftPattern: json['shiftPattern'] != null ? json['shiftPattern'] : null,
      description: json['description'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      createdBy: json['createdBy'] as String?,
    );
  }
}
