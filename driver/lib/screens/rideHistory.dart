import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/RideHistoryCard/card.dart';
import 'package:flutter/material.dart';

class RideHistory extends StatelessWidget {
  RideHistory({Key? key}) : super(key: key);
  final _apiProvider = DriverShipmentProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Ride History'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Showing Recent Rides',
                style: TextStyle(
                    color: ColorTheme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder(
                  future: _apiProvider.shipments(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<CustomerShipment> shipments =
                          snapshot.data as List<CustomerShipment>;
                      return ListView.builder(
                          itemBuilder: (_, index) =>
                              HistoryCard(shipment: shipments[index]),
                          itemCount: shipments.length);
                    }
                    return snapshot.hasError
                        ? Text(snapshot.error.toString())
                        : Center(
                            child: CircularProgressIndicator(
                              color: ColorTheme.primaryColor,
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
