import 'package:courier_services/constants.dart';
import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/services/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DriverShipmentProvider {
  /// Provide shipment api services
  static Dio dio = Dio(
    BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
    ),
  );
  Future<List<CustomerShipment>> shipments() async {
    try {
      final response = await dio.get(
        "${URL}shipment/driver-history",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return List<CustomerShipment>.from(
        data.map((json) => CustomerShipment.fromJson(json)),
      );
    } catch (e) {
      print(e);
      throw (getException(e));
    }
  }

  Future<Either<List<CustomerShipment>, ErrorMessage>>
      driverShipmentRequests() async {
    try {
      final response = await dio.get(
        "${URL}shipment/driver",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return Left(List<CustomerShipment>.from(
        data.map((json) => CustomerShipment.fromJson(json)),
      ));
    } catch (e) {
      return Right(getException(e));
    }
  }

  Future<Either<CustomerShipment, ErrorMessage>> acceptSipmentRequest(
      int shipmentId) async {
    try {
      final response = await dio.put(
        "${URL}shipment/driver/",
        data: {"shipment_id": shipmentId},
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      return Left(CustomerShipment.fromJson(response.data));
    } catch (e) {
      print(e);
      return Right(getException(e));
    }
  }

  Future<Either<CustomerShipment, ErrorMessage>> confirmShpmentDelivery(
      int shipmentId) async {
    try {
      final response = await dio.patch(
        "${URL}shipment/driver/",
        data: {"shipment_id": shipmentId},
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      return Left(CustomerShipment.fromJson(response.data));
    } catch (e) {
      return Right(getException(e));
    }
  }

  Future<List<Carriage>> carriageList() async {
    try {
      final response = await dio.get(
        "${URL}driver/vehicle/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
      );
      Iterable data = response.data;
      return List<Carriage>.from(
        data.map((json) => Carriage.fromJson(json)),
      );
    } catch (e) {
      throw getException(e);
    }
  }

  Future<Either<Carriage, ErrorMessage>> createcarriage(Map data) async {
    try {
      final res = await dio.post(
        "${URL}driver/vehicle/",
        options: Options(
          headers: {'Authorization': 'Token ${await Auth.getAuthToken()}'},
          sendTimeout: timeout,
        ),
        data: data,
      );
      return Left(Carriage.fromJson(res.data));
    } catch (e) {
      return Right(getException(e));
    }
  }
}
