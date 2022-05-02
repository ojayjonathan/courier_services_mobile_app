import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';

import 'package:flutter/material.dart';

class ShipmentInfo extends StatelessWidget {
  //Shipment infor for driver
  final CustomerShipment shipment;
  ShipmentInfo({required this.shipment});
  final DriverShipmentProvider _service = DriverShipmentProvider();

  @override
  Widget build(BuildContext context) {
    void _acceptShipment() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please wait..",
            style: TextStyle(
              color: ColorTheme.successColor,
            ),
          ),
          duration: SNACKBARDURATION,
        ),
      );
      _service.acceptSipmentRequest(shipment.id).then((res) => res.fold((l) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushNamed(AppRoutes.shipmentHistory);
          }, (r) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  r.message,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
                duration: SNACKBARDURATION,
              ),
            );
          }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipment Information",
          style: TextStyle(color: ColorTheme.dark[1]),
        ),
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
                              "${this.shipment.shipment.origin?.city ?? this.shipment.shipment.origin?.street}",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${this.shipment.shipment.origin?.name}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${this.shipment.shipment.destination?.city ?? this.shipment.shipment.destination?.street}",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${this.shipment.shipment.destination?.name}",
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
                          "Size: ${this.shipment.shipment.cargo?.size}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nature: ${this.shipment.shipment.cargo?.nature}",
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
                          "Client Name: ${this.shipment.user.userName}",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Contact: ${this.shipment.user.phoneNumber}",
                          style: TextStyle(
                            color: ColorTheme.dark[2],
                          ),
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Price:",
                              style: TextStyle(
                                  color: ColorTheme.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "\t\t Ksh ${shipment.shipment.price}",
                            style: TextStyle(color: ColorTheme.primaryColor),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Order No:",
                            style: TextStyle(
                                color: ColorTheme.dark[2],
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: "\t\t ${shipment.orderNo}",
                              style: TextStyle(color: ColorTheme.dark[2]))
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: shipment.shipment.status == "Pending"
                          ? DefaultButton(
                              handlePress: _acceptShipment,
                              text: "Accept Request",
                            )
                          : Text(
                              shipment.shipment.status,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: shipment.shipment.status == "Active"
                                      ? Colors.amber
                                      : shipment.shipment.status == "Fulfilled"
                                          ? ColorTheme.successColor
                                          : Colors.red),
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
