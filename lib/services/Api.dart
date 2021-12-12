import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripleuglobal/constants/api_constants.dart';
import 'package:tripleuglobal/models/add_post_response.dart';
import 'package:tripleuglobal/models/login_response.dart';
import 'package:tripleuglobal/models/notification_response.dart';
import 'package:tripleuglobal/models/post_list_response.dart';
import 'package:tripleuglobal/models/signup_response.dart';
import 'package:tripleuglobal/models/update_profile.dart';
import '../locator.dart';
import 'FetchDataException.dart';
import 'package:path/path.dart' as p;

class Api {
  Dio dio = locator<Dio>();

  Future<LoginResponse> login(
      BuildContext context, String email, String password,
      [String? fcmToken]) async {
    var map = {
      "email": email,
      "password": password,
      "device_type": "A",
      "device_token": fcmToken,
      "fcm_token": fcmToken,
      "device_id": "1"
    };
    try {
      var response = await dio.post(ApiConstants.BASE_URL + ApiConstants.LOGIN,
          queryParameters: map);
      return LoginResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<SignUpResponse> signUp(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      String userType,
      [String? fcmToken]) async {
    var map = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "contact": phoneNumber,
      "user_type": userType,
      "device_type": "A",
      "device_token": fcmToken,
      "fcm_token": fcmToken,
      "device_id": "1"
    };
    try {
      var response = await dio.get(
          ApiConstants.BASE_URL + ApiConstants.REGISTER,
          queryParameters: map);
      return SignUpResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateProfile> updateProfile(BuildContext context, String firstName,
      String lastName, String email, String phoneNumber, String userId) async {
    var map = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "contact": phoneNumber,
      "user_id": userId
    };
    try {
      var response = await dio.get(
          ApiConstants.BASE_URL + ApiConstants.UPDATE_PROFILE,
          queryParameters: map);
      return UpdateProfile.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<AddPostResponse> addJobPost(
      BuildContext context,
      String userId,
      String fullname,
      String email,
      String qualification,
      File document,
      String experience,
      String contact,
      String age,
      String userType,
      String preferredArea) async {

    final extension = p.extension(document.path);

    var map = FormData.fromMap({
      "user_id": userId,
      "fullname": fullname,
      "email": email,
      "qualification": qualification,
      "document": await MultipartFile.fromFile(document.path,
          filename: userId+"_"+DateTime.now().microsecondsSinceEpoch.toString()+extension),
      "experience": experience,
      "contact": contact,
      "age": age,
      "user_type": userType,
      "preferred_area": preferredArea,
    });

    try {
      var response = await dio
          .post(ApiConstants.BASE_URL + ApiConstants.JOB_POST, data: map);
      return AddPostResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<AddPostResponse> addEmployerPost(
      BuildContext context,
      String userId,
      String fullname,
      String email,
      File document,
      String experience,
      String contact,
      String typeOfEmployer,
      String userType,
      String preferredArea) async {


    final extension = p.extension(document.path);

    var map = FormData.fromMap({
      "user_id": userId,
      "fullname": fullname,
      "email": email,
      "document": await MultipartFile.fromFile(document.path,
          filename: userId+"_"+DateTime.now().microsecondsSinceEpoch.toString()+extension),
      "experience": experience,
      "contact": contact,
      "user_type": userType,
      "employer_type": typeOfEmployer,
      "experience_level": experience,
      "qualification": "",
      "age": "",
      "preferred_area": preferredArea,
    });
    try {
      var response = await dio
          .post(ApiConstants.BASE_URL + ApiConstants.JOB_POST, data: map);
      return AddPostResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<PostListResponse> getPost(BuildContext context, String userId) async {
    var map = {"user_id": userId};
    try {
      var response = await dio.get(
          ApiConstants.BASE_URL + ApiConstants.GET_JOB_POST,
          queryParameters: map);
      return PostListResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<NotificationResponse> getNotification(
      BuildContext context, String userId) async {
    var map = {"user_id": userId};
    try {
      var response = await dio.get(
          ApiConstants.BASE_URL + ApiConstants.GET_NOTIFICATION,
          queryParameters: map);
      return NotificationResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }
}
