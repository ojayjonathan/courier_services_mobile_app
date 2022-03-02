import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/rating.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final Shipment shipment;
  const HistoryCard({Key? key, required this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RatingScreen(
            shipment: this.shipment,
          ),
        ),
      ),
      child: Card(
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
                              "${shipment.origin?.city ?? shipment.origin?.street}"),
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
                              "${shipment.destination?.city ?? shipment.destination?.street}"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${this.shipment.shipmentDate}"),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    this.shipment.status,
                    style: TextStyle(
                        fontSize: 15,
                        color: shipment.status == "Active"
                            ? Colors.amber
                            : shipment.status == "Fulfilled"
                                ? ColorTheme.successColor
                                : Colors.red),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Ksh ${this.shipment.price}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
