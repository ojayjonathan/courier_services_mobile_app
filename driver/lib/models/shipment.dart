import 'dart:convert';

import 'package:courier_services/models/location.dart';
import 'package:courier_services/models/user.dart';
import 'package:flutter/scheduler.dart';

class Shipment {
  int? id;
  Cargo? cargo;
  Place? origin;
  Place? destination;
  int? vehicle;
  double? price_;
  String? status_;
  String? shipmentDate;
  double? rating;
  double? distance;
  double? get price => price_ != null
      ? double.parse(
          price_!.toStringAsFixed(2),
        )
      : null;
  String get status {
    return {
          "A": "Active",
          "P": "Pending",
          "C": "Canceled",
          "F": "Fulfilled"
        }[status_] ??
        "Pending";
  }

  Shipment(
      {this.id,
      this.cargo,
      this.origin,
      this.destination,
      this.vehicle,
      this.price_,
      this.status_,
      this.shipmentDate,
      this.rating,
      this.distance});

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
        id: json['id'],
        cargo: Cargo.fromJson(json['cargo']),
        origin: Place.fromJson(json['origin']),
        destination: Place.fromJson(json['destination']),
        vehicle: json['vehicle'],
        price_: double.parse("${json['price']}"),
        status_: json['status'],
        shipmentDate: json['date'],
        rating: json["rating"],
        distance: json["distance"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "cargo": cargo?.toJson(),
      'vehicle': this.vehicle,
      'price': this.price ?? 0.0,
      'status': this.status_ ?? "P",
      'date': this.shipmentDate,
      "origin": this.origin?.toJson(),
      "destination": this.destination?.toJson(),
      "distance": this.distance,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}

Map<String, String> sizes = {"S": "Small", "M": "Medium", "L": "Large"};

class Cargo {
  String size_;
  String nature_;

  Cargo(this.size_, this.nature_);
  String get size {
    return sizes[size_.toUpperCase()]!;
  }

  String get nature => nature_ == "F" ? "Fragile" : "Not Fragile";
  factory Cargo.fromJson(Map<String, dynamic> json) {
    return Cargo(
      json['size'],
      json['nature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "size": this.size_,
      "nature": this.nature_,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}

class CustomerShipment {
  Shipment shipment;
  User user;
  int id;
  String? orderNo;
  CustomerShipment(
      {required this.id,
      required this.user,
      required this.shipment,
      required this.orderNo});

  factory CustomerShipment.fromJson(Map json) {
    print(json);
    return CustomerShipment(
        orderNo: json["order_number"],
        id: json["id"],
        user: User.fromJson(json["customer"]),
        shipment: Shipment.fromJson(json["shipment"]));
  }
}

class UserNotification {
  String message;
  String date;
 UserNotification(this.message, this.date);
  factory UserNotification.fromJson(Map json) {
    return UserNotification(json["message"], json["date"]);
  }
}
