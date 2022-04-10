import 'dart:async';

import 'package:courier_services/constants.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/shipment_info.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();
  List<CustomerShipment>? _shipmentRequests;
  final _shipmentApiProvider = DriverShipmentProvider();
  bool _showNextButton = false;

  _initShipment() async {
    await _shipmentApiProvider.driverShipmentRequests().then(
          (res) => res.fold((shipments) {
            _shipmentRequests = shipments;
            setState(() {});
          }, (r) => {}),
        );
  }

  @override
  void initState() {
    super.initState();
    _initShipment();
  }

  toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  static CameraPosition _initialCameraPosition = CameraPosition(
    tilt: 45,
    target: LatLng(-0.36932651926935073, 35.9313568419356),
    zoom: 10.0,
  );

  Widget buildMap(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
      buildingsEnabled: true,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            buildMap(context),
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.notifications);
                    },
                    icon: Icon(Icons.notifications),
                  )
                ],
                automaticallyImplyLeading: true,
                leading: IconButton(
                  onPressed: toggleDrawer,
                  icon: Icon(
                    Icons.menu,
                    color: ColorTheme.dark[1],
                    size: 32,
                  ),
                ),
              ),
            ),
            Positioned(
              child: _shipmentRequests == null
                  ? Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorTheme.primary2Color,
                          ),
                        ),
                      ),
                    )
                  : _shipmentRequests!.isEmpty
                      ? Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Center(
                              child: Text(
                                "No Shipment Request",
                              ),
                            ),
                          ),
                        )
                      : requestList(),
              bottom: 100,
              left: 0,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _showNextButton
          ? TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorTheme.dark[1])),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("next"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.double_arrow_rounded,
                    size: 16,
                  )
                ],
              ),
              onPressed: () => {})
          : null,
    );
  }

  Widget requestList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ..._shipmentRequests!
              .map((shipment) => shipmentRequestCard(shipment)),
        ],
      ),
    );
  }

  Widget shipmentRequestCard(CustomerShipment shipment) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
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
                        color: ColorTheme.dark[2], fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: "\t\t ${shipment.orderNo}",
                      style: TextStyle(color: ColorTheme.dark[2]))
                ]),
              ),
            ),
            SizedBox(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: DefaultButton(
                handlePress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShipmentInfo(shipment: shipment),
                    ),
                  );
                },
                text: "VIEW",
              ),
            ))
          ],
        ),
      ),
    );
  }
}
