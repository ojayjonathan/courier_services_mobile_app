import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/shipment_info.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatefulWidget {
  final CustomerShipment shipment;
  const HistoryCard({Key? key, required this.shipment}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  final _shipmentProvider = DriverShipmentProvider();
  String shipment_status = "";
  @override
  void initState() {
    shipment_status = widget.shipment.shipment.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewShipment() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ShipmentInfo(shipment: widget.shipment),
        ),
      );
    }

    _confirmDelivery() {
      _shipmentProvider.confirmShpmentDelivery(widget.shipment.id).then(
            (res) => res.fold(
              (shipment) {
                setState(() {
                  shipment_status = "Fullfiled";
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Shipment Confirmed",
                    style: TextStyle(color: ColorTheme.successColor),
                  ),
                ));
              },
              (r) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    r.message,
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              ),
            ),
          );
    }

    Widget _card() {
      if (shipment_status == "Active")
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          shadowColor: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Price:",
                        style: TextStyle(
                            color: ColorTheme.primaryColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "\t\t Ksh ${widget.shipment.shipment.price}",
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
                        text: "\t\t ${widget.shipment.orderNo}",
                        style: TextStyle(color: ColorTheme.dark[2]))
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: DefaultButton(
                  handlePress: _confirmDelivery,
                  text: "Confirm Delivery",
                ),
              )
            ],
          ),
        );

      if (shipment_status == "Pending")
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          shadowColor: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Price:",
                        style: TextStyle(
                            color: ColorTheme.primaryColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "\t\t Ksh ${widget.shipment.shipment.price}",
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
                        text: "\t\t ${widget.shipment.orderNo}",
                        style: TextStyle(color: ColorTheme.dark[2]))
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: DefaultButton(
                  handlePress: _viewShipment,
                  text: "View Request",
                ),
              )
            ],
          ),
        );
      return Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        shadowColor: Colors.grey.shade300,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${widget.shipment.shipment.origin?.city ?? widget.shipment.shipment.origin?.street}"),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
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
                    Row(
                      children: [
                        Transform.rotate(
                          angle: -45,
                          child: Icon(Icons.send_outlined,
                              color: ColorTheme.primaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${widget.shipment.shipment.destination?.city ?? widget.shipment.shipment.destination?.street}"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${widget.shipment.shipment.shipmentDate}"),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.shipment.shipment.status,
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.shipment.shipment.status == "Active"
                            ? Colors.amber
                            : widget.shipment.shipment.status == "Fulfilled"
                                ? ColorTheme.successColor
                                : Colors.red),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Ksh ${widget.shipment.shipment.price}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      child: _card(),
      onTap: _viewShipment,
    );
  }
}
