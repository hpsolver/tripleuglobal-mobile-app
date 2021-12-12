import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.response,
  });

  Response? response;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
  String? status;
  Data? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.userType,
    this.username,
  });

  String? userId;
  String? userType;
  String? username;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    userType: json["user_type"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_type": userType,
    "username": username,
  };
}
