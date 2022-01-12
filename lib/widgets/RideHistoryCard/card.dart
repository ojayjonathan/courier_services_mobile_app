import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/ratingBar/ratingBar.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final Shipment shipment;
  const HistoryCard({Key? key, required this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        shadowColor: Colors.grey.shade300,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ratingBar(rating: 5, size: 15),
                  SizedBox(
                    height: 12,
                  ),
                  Text("${this.shipment.price}")
                ],
              )
            ],
          ),
        ));
  }
}
