import 'package:courier_services/constants.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../widgets/defultInput/inputField.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _originFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot query a null value';
    }
    return null;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void selectLocation(latlong.LatLng? latLng) {
    if (latLng != null) {
      if (_originFocusNode.hasFocus) {
        _originController.text =
            "lat:${latLng.latitude} lng:${latLng.longitude}";
      } else if (_destinationFocusNode.hasFocus) {
        _destinationController.text =
            "lat:${latLng.latitude} lng:${latLng.longitude}";
      }
    }
    if (_originController.text.isNotEmpty &&
        _destinationController.text.isNotEmpty) {
      showBottomSheet(
          context: context,
          builder: (context) {
            return bottomSheet();
          });
    }
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
              FlutterMap(
                options: MapOptions(
                  onTap: selectLocation,
                  center: latlong.LatLng(-1.2921, 36.8219),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/brianomondi/cksboxzm1boar17q6p3y0ezfb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYnJpYW5vbW9uZGkiLCJhIjoiY2tzYm8zcW05MDhxbjJvcWsyMnlra244bCJ9.TDxC8cAZEvsIy_JXQFDQlA",
                      additionalOptions: {
                        'accesstoken':
                            'pk.eyJ1IjoiYnJpYW5vbW9uZGkiLCJhIjoiY2tzYm8zcW05MDhxbjJvcWsyMnlra244bCJ9.TDxC8cAZEvsIy_JXQFDQlA',
                        'id': 'mapbox.mapbox-streets-v8'
                      }),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: latlong.LatLng(-1.2921, 36.8219),
                        builder: (ctx) => Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                    DefaultInput(
                      hintText: 'Select origin...',
                      controller: _originController,
                      validator: validator,
                      icon: Icons.location_on,
                      readOnly: true,
                      focusNode: _originFocusNode,
                    ),
                    DefaultInput(
                      hintText: 'Select destination...',
                      controller: _destinationController,
                      validator: validator,
                      icon: Icons.send_outlined,
                      readOnly: true,
                      focusNode: _destinationFocusNode,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget bottomSheet() {
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
                    ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.pedal_bike_sharp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                              color: ColorTheme.primary3Color, width: 2),
                        ),
                      ),
                      trailing: Text("Ksh 700"),
                    ),
                    ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.car_rental),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                        ),
                      ),
                      trailing: Text("Ksh 1700"),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: DefaultButton(
                          handlePress: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.packageDetail);
                          },
                          text: "Continue"),
                    )
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pedal_bike_sharp),
                      trailing: Text("Ksh 700"),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: DefaultButton(
                          handlePress: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.packageDetail);
                          },
                          text: "Continue"),
                    )
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pedal_bike_sharp),
                      trailing: Text("Ksh 700"),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: DefaultButton(
                          handlePress: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.packageDetail);
                          },
                          text: "Continue"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
