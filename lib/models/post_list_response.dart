import 'dart:convert';

PostListResponse postListResponseFromJson(String str) => PostListResponse.fromJson(json.decode(str));

String postListResponseToJson(PostListResponse data) => json.encode(data.toJson());

class PostListResponse {
  PostListResponse({
    this.response,
  });

  Response? response;

  factory PostListResponse.fromJson(Map<String, dynamic> json) => PostListResponse(
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
  List<Datum>? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.fullname,
    this.age,
    this.qualification,
    this.experience,
    this.email,
    this.phone,
    this.document,
    this.isConnect,
  });

  String? id;
  String? userId;
  String? fullname;
  String? age;
  String? qualification;
  String? experience;
  String? email;
  String? phone;
  String? document;
  String? isConnect;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    age: json["age"] == null ? null : json["age"],
    qualification: json["qualification"] == null ? null : json["qualification"],
    experience: json["experience"] == null ? null : json["experience"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    document: json["document"] == null ? null : json["document"],
    isConnect: json["is_connect"] == null ? null : json["is_connect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "fullname": fullname == null ? null : fullname,
    "age": age == null ? null : age,
    "qualification": qualification == null ? null : qualification,
    "experience": experience == null ? null : experience,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "document": document == null ? null : document,
    "is_connect": isConnect == null ? null : isConnect,
  };
}
