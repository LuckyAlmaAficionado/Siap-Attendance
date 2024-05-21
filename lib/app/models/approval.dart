import 'dart:convert';

List<Approval> approvalFromJson(String str) =>
    List<Approval>.from(json.decode(str).map((x) => Approval.fromJson(x)));

String approvalToJson(List<Approval> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Approval {
  String id;
  String userId;
  String? description;
  bool approved;
  List<ApprovalElement> approvals;
  bool fullyApproved;

  Approval({
    required this.id,
    required this.userId,
    this.description,
    required this.approved,
    required this.approvals,
    required this.fullyApproved,
  });

  factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        id: json["id"],
        userId: json["userId"],
        description: json["description"] ?? "",
        approved: json["approved"],
        approvals: List<ApprovalElement>.from(
            json["approvals"].map((x) => ApprovalElement.fromJson(x))),
        fullyApproved: json["fullyApproved"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "approved": approved,
        "approvals": List<dynamic>.from(approvals.map((x) => x.toJson())),
        "fullyApproved": fullyApproved,
      };
}

class ApprovalElement {
  String approver;
  bool approved;
  int approverOrder;

  ApprovalElement({
    required this.approver,
    required this.approved,
    required this.approverOrder,
  });

  factory ApprovalElement.fromJson(Map<String, dynamic> json) =>
      ApprovalElement(
          approver: json["approver"],
          approved: json["approved"],
          approverOrder: json["approverOrder"]);

  Map<String, dynamic> toJson() => {
        "approver": approver,
        "approved": approved,
        "approverOrder": approverOrder,
      };
}
