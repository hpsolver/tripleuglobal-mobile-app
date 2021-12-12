import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.response,
  });

  Response? response;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
    this.firstName,
    this.lastName,
    this.email,
    this.userType,
    this.contact,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? userType;
  String? contact;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    userType: json["user_type"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "user_type": userType,
    "contact": contact,
  };
}
