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
    print(data);
    try {
      final response = await dio.post(
        "${URL}shipment/client",
        data: data,
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      return Left(Shipment.fromJson(response.data["shipment"]));
    } catch (e) {
      print(e);

      return Right(getException(e));
    }
  }

  Future<List<Shipment>> customerShipments() async {
    try {
      final response = await dio.get(
        "${URL}shipment/client",
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
      throw getException(e);
    }
  }

  Future<Either<Shipment, ErrorMessage>> cancelShipment(int id) async {
    try {
      final response = await dio.patch(
        "${URL}shipment/client",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
        data: {"shipment_id": id},
      );
      return Left(
        Shipment.fromJson(response.data["shipment"]),
      );
    } catch (e) {
      return Right(
        getException(e),
      );
    }
  }

  Future<Either<String, ErrorMessage>> rateDelivery(
      int shipmentId, double rating, String? message) async {
    try {
      final response = await dio.post(
        "${URL}feedback/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
        data: {
          "shipment_id": shipmentId,
          "rating": rating,
          "message": message,
        },
      );
      return Left(
        response.data["message"],
      );
    } catch (e) {
      return Right(
        getException(e),
      );
    }
  }

  Future<Either<List<Carriage>, ErrorMessage>> carriageList() async {
    try {
      final response = await dio.get(
        "${URL}client/vehicle",
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
