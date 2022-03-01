import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final _apiProvider = DriverShipmentProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Vehicle Information",
            style: TextStyle(color: ColorTheme.dark[1]),
          ),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: _apiProvider.shipments(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Carriage> carriage = snapshot.data as List<Carriage>;
                return ListView.builder(
                    itemBuilder: (_, index) => _carriageCard(carriage[index]),
                    itemCount: carriage.length);
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
        ));
  }

  Widget _carriageCard(Carriage c) {
    return Container();
  }
}
