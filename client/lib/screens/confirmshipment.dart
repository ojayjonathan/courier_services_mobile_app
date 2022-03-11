import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/shipment_service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';

import 'package:flutter/material.dart';

class ConfirmShipment extends StatelessWidget {
  final Shipment shipment;
  ConfirmShipment({required this.shipment});
  final ShipmentApiProvider _service = ShipmentApiProvider();

  @override
  Widget build(BuildContext context) {
    void _confirmShipment() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please wait...",
            style: TextStyle(
              color: ColorTheme.successColor,
            ),
          ),
          duration: SNACKBARDURATION,
        ),
      );
      _service
          .create(
            shipment.toJson(),
          )
          .then(
            (
              res,
            ) =>
                res.fold(
              (l) {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
                Navigator.of(context).pushNamed(
                  AppRoutes.shipmentHistory,
                );
              },
              (r) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      r.message,
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    duration: SNACKBARDURATION,
                  ),
                );
              },
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                elevation: 5,
                shadowColor: Colors.grey.shade300,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _circle(),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 10, top: 0, right: 0, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  11,
                                  (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Colors.transparent
                                              : Colors.grey.shade300,
                                          height: 1,
                                          width: 2,
                                        ),
                                      )),
                            ),
                          ),
                          _circle(),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${this.shipment.origin?.city ?? this.shipment.origin?.street}",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${this.shipment.origin?.name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${this.shipment.destination?.city ?? this.shipment.destination?.street}",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${this.shipment.destination?.name}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Size: ${this.shipment.cargo?.size}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nature: ${this.shipment.cargo?.nature}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Driver: ${this.shipment.carriage?.driver.user.userName}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vehicle Registation Number: ${this.shipment.carriage?.vehicleRegistrationNumber}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Driver Phone no: ${this.shipment.carriage?.driver.user.phoneNumber}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Ksh ${this.shipment.price}",
                              style: TextStyle(
                                  color: ColorTheme.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "\t\t Pending",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Packages :",
                            style: TextStyle(
                                color: ColorTheme.dark[2],
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: "\t\t 1",
                              style: TextStyle(color: ColorTheme.dark[2]))
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: DefaultButton(
                        handlePress: _confirmShipment,
                        text: "Proceed to payment",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle() {
    return Container(
      height: 20,
      width: 20,
      child: Icon(
        Icons.circle,
        color: ColorTheme.primary3Color,
        size: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorTheme.primary3Color, width: 2),
      ),
    );
  }
}
