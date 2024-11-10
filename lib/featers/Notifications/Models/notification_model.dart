class NotificationModel {
  final String? id;
  final String? type;
  final Body? title;
  final Body? body;
  final String? recipientType;
  final AdditionalData? additionalData;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isAdmin;

  NotificationModel({
    this.id,
    this.type,
    this.title,
    this.body,
    this.recipientType,
    this.additionalData,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
  });

  NotificationModel copyWith({
    String? id,
    String? type,
    Body? title,
    Body? body,
    String? recipientType,
    AdditionalData? additionalData,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAdmin,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        recipientType: recipientType ?? this.recipientType,
        additionalData: additionalData ?? this.additionalData,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        title: json["title"] == null ? null : Body.fromJson(json["title"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        recipientType: json["recipientType"],
        additionalData: json["additionalData"] == null
            ? null
            : AdditionalData.fromJson(json["additionalData"]),
        isRead: json["isRead"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title?.toJson(),
        "body": body?.toJson(),
        "recipientType": recipientType,
        "additionalData": additionalData?.toJson(),
        "isRead": isRead,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isAdmin": isAdmin,
      };
}

class AdditionalData {
  final Body? newStatus;

  AdditionalData({
    this.newStatus,
  });

  AdditionalData copyWith({
    Body? newStatus,
  }) =>
      AdditionalData(
        newStatus: newStatus ?? this.newStatus,
      );

  factory AdditionalData.fromJson(Map<String, dynamic> json) => AdditionalData(
        newStatus:
            json["newStatus"] == null ? null : Body.fromJson(json["newStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "newStatus": newStatus?.toJson(),
      };
}

class Body {
  final String? ar;
  final String? en;

  Body({
    this.ar,
    this.en,
  });

  Body copyWith({
    String? ar,
    String? en,
  }) =>
      Body(
        ar: ar ?? this.ar,
        en: en ?? this.en,
      );

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        ar: json["ar"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "en": en,
      };
}
