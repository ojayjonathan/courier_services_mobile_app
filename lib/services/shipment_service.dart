import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/services/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ShipmentApiProvider {
  static Dio dio = Dio(
    BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
    ),
  );
  static Future<Either<Shipment, ErrorMessage>> create(
      Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "${URL}shipment/",
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

  static Future<Either<List<Shipment>, ErrorMessage>> allShipments() async {
    try {
      final response = await dio.get(
        "${URL}shipment/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return Left(
        List<Shipment>.from(
          data.map((json) => Shipment.fromJson(json["shipment"])),
        ),
      );
    } catch (e) {
      return Right(getException(e));
    }
  }
}
