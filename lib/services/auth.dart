import 'dart:convert';

import 'package:courier_services/constants.dart';
import 'package:courier_services/models/user.dart';
import 'package:courier_services/services/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Dio dio = Dio(
    BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
    ),
  );
  static Future<Either<User, ErrorMessage>> loginUser(Map data) async {
    try {
      final response = await dio.post(
        "${URL}auth/login/",
        data: jsonEncode(data),
        options: Options(
          sendTimeout: timeout,
        ),
      );
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("authToken", response.data['token']);
      return Left(User.fromJson(response.data));
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("authToken");
  }

  static Future<Either<User, ErrorMessage>> registerUser(Map data) async {
    try {
      final response = await dio.post("${URL}auth/register",
          data: data, options: Options(sendTimeout: timeout));
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("authToken", response.data['token']);
      return Left(User.fromJson(response.data));
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<Either<User, ErrorMessage>> updateProfile(Map data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String? authToken = _prefs.getString("authToken");
      var _profile = await dio.put("${URL}client/profile",
          options: Options(
            headers: {'Authorization': 'Token $authToken'},
            sendTimeout: timeout,
          ),
          data: jsonEncode(data));
      _prefs.setString("user", jsonEncode(_profile.data));
      return Left(User.fromJson(_profile.data["user"]));
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<Either<Map<String, dynamic>, ErrorMessage>> resetPassword(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await dio.post("${URL}auth/reset/", data: jsonEncode(data));
      return Left(res.data as Map<String, dynamic>);
    } catch (e) {
      return Right(
        getException(e),
      );
    }
  }

  static Future<Either<Map<String, dynamic>, ErrorMessage>> setNewPassword(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await dio.put("${URL}auth/reset/",
          data: data, options: Options(sendTimeout: timeout));
      return Left(res.data as Map<String, dynamic>);
    } catch (e) {
      return Right(
        getException(e),
      );
    }
  }

  static Future<Either<User, ErrorMessage>> getUserProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userData = _prefs.getString("user");
    if (_userData != null) {
      return Left(User.fromJson(jsonDecode(_userData)));
    } else {
      try {
        String? authToken = _prefs.getString("authToken");
        var profile = await dio.get("${URL}client/profile",
            options: Options(
                headers: {'Authorization': 'Token $authToken'},
                sendTimeout: timeout));
        _prefs.setString("user", jsonEncode(profile.data["user"]));
        return Left(User.fromJson(profile.data["user"]));
      } catch (e) {
        return Right(getException(e));
      }
    }
  }
}
