import 'dart:convert';

import 'package:courier_services/models/user.dart';
import 'package:flutter/material.dart';

const CarrierType = {"L": "Lorry", "P": "Pickup", "B": "MotorBike"};

class Carriage {
  int id;
  Driver driver;
  String carrierType;
  String carrierCapacity;
  String vehicleRegistrationNumber;

  String? model;

  Carriage(
      {required this.id,
      required this.driver,
      required this.carrierType,
      required this.carrierCapacity,
      required this.vehicleRegistrationNumber,
      this.model});
  IconData get icon {
    return {
          "B": Icons.two_wheeler,
          "L": Icons.local_shipping,
          "P": Icons.directions_car_filled
        }[carrierType] ??
        Icons.directions_car;
  }

  factory Carriage.fromJson(Map<String, dynamic> json) {
    return Carriage(
      id: json['id'],
      driver: Driver.fromJson(json['driver']),
      carrierType: json['carrier_type'],
      carrierCapacity: json['carrier_capacity'],
      vehicleRegistrationNumber: json['vehicle_registration_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'driver': this.driver.toJson(),
      'carrier_type': this.carrierType,
      'carrier_capacity': this.carrierCapacity,
      'vehicle_registration_number': this.vehicleRegistrationNumber,
      'model': this.model,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
