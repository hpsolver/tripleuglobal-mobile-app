import 'dart:convert';

AddPostResponse addPostResponseFromJson(String str) => AddPostResponse.fromJson(json.decode(str));

String addPostResponseToJson(AddPostResponse data) => json.encode(data.toJson());

class AddPostResponse {
  AddPostResponse({
    this.response,
  });

  Response? response;

  factory AddPostResponse.fromJson(Map<String, dynamic> json) => AddPostResponse(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response!.toJson(),
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
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.userId,
  });

  String? userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
  };
}
