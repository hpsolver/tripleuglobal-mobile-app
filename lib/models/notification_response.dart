import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.response,
  });

  Response? response;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response!.toJson(),
  };
}

class Response {
  Response({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  int? status;
  List<Datum>? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.fromUser,
    this.title,
    this.description,
  });

  String? id;
  String? userId;
  String? fromUser;
  String? title;
  String? description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    fromUser: json["from_user"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "from_user": fromUser,
    "title": title,
    "description": description,
  };
}
