import 'dart:async';
import 'dart:math';

import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/models/location.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/location_search_bar.dart';
import 'package:courier_services/screens/packageDetail.dart';
import 'package:courier_services/services/place_service.dart';
import 'package:courier_services/services/shipment_service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/defultInput/inputField.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();
  final placeService = PlaceApiProvider(randomString(10));
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();
  List<Carriage> _carriage = [];
  List<Marker> _markers = [];
  ShipmentApiProvider _shipmentApiProvider = ShipmentApiProvider();
  Carriage? _selectedCarriage;
  Place? pickup;
  Place? dropoff;
  bool _showNextButton = false;
  @override
  void initState() {
    super.initState();
    _shipmentApiProvider.carriageList().then(
          (res) => res.fold((carriage) => {_carriage = carriage}, (r) => {}),
        );
  }

  toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  static CameraPosition _initialCameraPosition = CameraPosition(
    tilt: 45,
    target: LatLng(-0.36932651926935073, 35.9313568419356),
    zoom: 10.0,
  );

  Widget buildMap(BuildContext context) {
    return GoogleMap(
      markers: Set.from(_markers),
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
    void _searchLocation(String selected) async {
      // should show search screen here
      final result = await showSearch(
        context: context,
        delegate: AddressSearch(),
      );
      // This will change the text displayed in the TextField
      if (result != null) {
        if (selected == "pickup") {
          _pickupController.text = result.description;
        } else {
          _dropoffController.text = result.description;
        }

        //get selected place details
        placeService
            .getPlaceDetailFromId(result.placeId)
            .then((_res) => _res.fold((_place) {
                  print(_place);
                  if (selected == "pickup") {
                    pickup = _place;
                  } else {
                    dropoff = _place;
                  }
                  //update markers

                  _markers.clear();
                  if (dropoff != null) {
                    _markers.add(
                      Marker(
                          infoWindow: InfoWindow(title: "dropoff"),
                          markerId: MarkerId(
                            randomString(10),
                          ),
                          position: pickup!.latLng!),
                    );
                  }
                  if (pickup != null) {
                    _markers.add(
                      Marker(
                          infoWindow: InfoWindow(
                            title: "pickup",
                          ),
                          markerId: MarkerId(
                            randomString(10),
                          ),
                          position: dropoff!.latLng!),
                    );
                  }
                  CameraPosition update = CameraPosition(
                    target: _place.latLng!,
                    tilt: 45,
                    zoom: 10.0,
                  );
                  _mapController.future.then(
                    (_controller) => _controller
                        .animateCamera(CameraUpdate.newCameraPosition(update)),
                  );
                  setState(() {});
                }, (r) => null));
      }
      if (_pickupController.text.isNotEmpty &&
          _dropoffController.text.isNotEmpty) {
        setState(() {
          _showNextButton = true;
        });
        showBottomSheet(
            context: context,
            builder: (context) {
              return bottomSheet();
            });
      }
    }

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
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  )
                ],
                automaticallyImplyLeading: true,
                leading: IconButton(
                  onPressed: toggleDrawer,
                  icon: Icon(Icons.menu),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.9,
              left: 15,
              top: 80,
              child: Column(
                children: [
                  MapInputField(
                    hintText: 'Select pickup',
                    controller: _pickupController,
                    validator: requiredValidator,
                    icon: Icons.location_on,
                    focusNode: _pickupFocusNode,
                    onTap: () => _searchLocation("pickup"),
                  ),
                  MapInputField(
                    hintText: 'Select dropoff',
                    controller: _dropoffController,
                    validator: requiredValidator,
                    icon: Icons.send_outlined,
                    onTap: () => _searchLocation("dropoff"),
                    focusNode: _dropoffFocusNode,
                  )
                ],
              ),
            ),
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
              onPressed: () => showBottomSheet(
                context: context,
                builder: (context) {
                  return bottomSheet();
                },
              ),
            )
          : null,
    );
  }

  Widget bottomSheet() {
    return StatefulBuilder(builder: (context, bState) {
      return Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .5,
            maxWidth: MediaQuery.of(context).size.width),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: TabBar(
              labelColor: ColorTheme.dark[1],
              tabs: [
                Tab(
                  text: "Small",
                ),
                Tab(text: "Medium"),
                Tab(text: "Large"),
              ],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ..._carriage.where(
                      (element) {
                        return element.carrierType == "P";
                      },
                    ).map(
                      (_element) => carriageTile(_element, bState),
                    ),
                    Expanded(child: Container()),
                    _continue()
                  ],
                ),
                Column(
                  children: [
                    ..._carriage.where(
                      (element) {
                        return element.carrierType == "B";
                      },
                    ).map(
                      (_element) => carriageTile(_element, bState),
                    ),
                    Expanded(child: Container()),
                    _continue()
                  ],
                ),
                Column(
                  children: [
                    ..._carriage.where(
                      (element) {
                        return element.carrierType == "L";
                      },
                    ).map(
                      (_element) => carriageTile(_element, bState),
                    ),
                    Expanded(child: Container()),
                    _continue()
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding _continue() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: DefaultButton(
          handlePress: () {
            if (_selectedCarriage == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Please select carriage before you continue",
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              );
              return;
            }
            Shipment _shipment = Shipment(
              origin: pickup,
              destination: dropoff,
              vehicle: _selectedCarriage?.id,
            );
            //close bottomsheet
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PackageDetail(_shipment)),
            );
          },
          text: "Continue"),
    );
  }

  ListTile carriageTile(Carriage carriage, StateSetter bState) {
    bool selected = _selectedCarriage == carriage;
    return ListTile(
      onTap: () {
        _selectedCarriage = carriage;
        bState(() {});
      },
      selected: selected,
      leading: Container(
        height: 50,
        width: 50,
        child: Icon(carriage.icon),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              color: selected ? ColorTheme.primaryColor : ColorTheme.dark[3],
              width: 2),
        ),
      ),
      trailing: Text("Ksh 700"),
    );
  }
}

//using haversine formular to calculate distance between two geo-coordinates
double calculateDistance(LatLng point1, LatLng point2) {
  double lat1_rad = point1.latitude / (180 / pi);
  double lng1_rad = point1.longitude / (180 / pi);
  double lat2_rad = point2.latitude / (180 / pi);
  double lng2_rad = point2.longitude / (180 / pi);
  //Earth radius in kms
  double earth_radius = 6371;
  return 0;
}
