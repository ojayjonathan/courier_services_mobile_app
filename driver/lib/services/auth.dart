import 'dart:convert';

import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
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
      _prefs.setString("driver_authToken", response.data['token']);
      return Left(User.fromJson(response.data));
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<Either<String, ErrorMessage>> resetPassword(
      String email) async {
    try {
      final response = await dio.post(
        "${URL}auth/reset/",
        data: {"email": email},
        options: Options(
          sendTimeout: timeout,
        ),
      );

      return Left(response.data["message"]);
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("driver_authToken");
  }

  static Future<Either<User, ErrorMessage>> registerUser(Map data) async {
    try {
      final response = await dio.post("${URL}auth/register/",
          data: data, options: Options(sendTimeout: timeout));
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("driver_authToken", response.data['token']);
      return Left(User.fromJson(response.data));
    } catch (e) {
      return Right(getException(e));
    }
  }

  static Future<Either<Driver, ErrorMessage>> updateProfile(Map data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String? authToken = _prefs.getString("driver_authToken");
      var _profile = await dio.put("${URL}driver/profile/",
          options: Options(
            headers: {'Authorization': 'Token $authToken'},
            sendTimeout: timeout,
          ),
          data: jsonEncode(data));
      _prefs.setString("driver", jsonEncode(_profile.data));
      return Left(Driver.fromJson(_profile.data));
    } catch (e) {
      return Right(getException(e));
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

  static Future<Either<Driver, ErrorMessage>> getUserProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userData = _prefs.getString("driver");
    if (_userData != null) {
      return Left(Driver.fromJson(jsonDecode(_userData)));
    } else {
      try {
        String? authToken = _prefs.getString("driver_authToken");
        var profile = await dio.get("${URL}driver/profile/",
            options: Options(
                headers: {'Authorization': 'Token $authToken'},
                sendTimeout: timeout));
        _prefs.setString("driver", jsonEncode(profile.data));
        return Left(Driver.fromJson(profile.data));
      } catch (e) {
        return Right(getException(e));
      }
    }
  }

  static Future<List<UserNotification>> notification() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String? authToken = _prefs.getString("driver_authToken");
      var res = await dio.get("${URL}notification/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout));
      Iterable data = res.data;
      return List<UserNotification>.from(
        data.map((e) => UserNotification.fromJson(e)),
      );
    } catch (e) {
      throw getException(e);
    }
  }
}
