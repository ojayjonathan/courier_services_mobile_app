import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/shipment_service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/RideHistoryCard/card.dart';
import 'package:flutter/material.dart';

class RideHistory extends StatelessWidget {
  RideHistory({Key? key}) : super(key: key);
  final _apiProvider = ShipmentApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Shipment History'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.notifications);
            },
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
                'Showing Recent Shipments',
                style: TextStyle(
                    color: ColorTheme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder(
                  future: _apiProvider.customerShipments(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<Shipment> shipments =
                          snapshot.data as List<Shipment>;
                      if (shipments.isEmpty)
                        return Text("You have not made any shipment");
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
