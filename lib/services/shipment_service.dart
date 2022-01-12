import 'package:courier_services/constants.dart';
import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/services/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ShipmentApiProvider {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
    ),
  );
  Future<Either<Shipment, ErrorMessage>> create(
      Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "${URL}shipments/",
        data: data,
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      return Left(Shipment.fromJson(response.data["shipment"]));
    } catch (e) {
      return Right(getException(e));
    }
  }

  Future<List<Shipment>> customerShipments() async {
    try {
      final response = await dio.get(
        "${URL}shipments/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return List<Shipment>.from(
        data.map((json) => Shipment.fromJson(json["shipment"])),
      );
    } catch (e) {
      print(e);
      throw getException(e);
    }
  }

  Future<Either<List<Carriage>, ErrorMessage>> carriageList() async {
    try {
      final response = await dio.get(
        "${URL}vehicle/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return Left(
        List<Carriage>.from(
          data.map((json) => Carriage.fromJson(json)),
        ),
      );
    } catch (e) {
      return Right(getException(e));
    }
  }
}
