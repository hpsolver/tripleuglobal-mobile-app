import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    this.response,
  });

  Response? response;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
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
  });

  String? message;
  int? status;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}