class GoogleCalendarModel {
  String kind;
  String etag;
  String id;
  String status;
  String htmlLink;
  DateTime created;
  DateTime updated;
  String summary;
  String description;
  Creator creator;
  Creator organizer;
  End start;
  End end;
  String transparency;
  String visibility;
  String iCalUid;
  int sequence;
  String eventType;

  GoogleCalendarModel({
    required this.kind,
    required this.etag,
    required this.id,
    required this.status,
    required this.htmlLink,
    required this.created,
    required this.updated,
    required this.summary,
    required this.description,
    required this.creator,
    required this.organizer,
    required this.start,
    required this.end,
    required this.transparency,
    required this.visibility,
    required this.iCalUid,
    required this.sequence,
    required this.eventType,
  });

  factory GoogleCalendarModel.fromJson(Map<String, dynamic> json) =>
      GoogleCalendarModel(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        status: json["status"],
        htmlLink: json["htmlLink"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        summary: json["summary"],
        description: json["description"],
        creator: Creator.fromJson(json["creator"]),
        organizer: Creator.fromJson(json["organizer"]),
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
        transparency: json["transparency"],
        visibility: json["visibility"],
        iCalUid: json["iCalUID"],
        sequence: json["sequence"],
        eventType: json["eventType"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "status": status,
        "htmlLink": htmlLink,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "summary": summary,
        "description": description,
        "creator": creator.toJson(),
        "organizer": organizer.toJson(),
        "start": start.toJson(),
        "end": end.toJson(),
        "transparency": transparency,
        "visibility": visibility,
        "iCalUID": iCalUid,
        "sequence": sequence,
        "eventType": eventType,
      };
}

class Creator {
  String email;
  String displayName;
  bool self;

  Creator({
    required this.email,
    required this.displayName,
    required this.self,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        email: json["email"],
        displayName: json["displayName"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "displayName": displayName,
        "self": self,
      };
}

class End {
  DateTime date;

  End({
    required this.date,
  });

  factory End.fromJson(Map<String, dynamic> json) => End(
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
