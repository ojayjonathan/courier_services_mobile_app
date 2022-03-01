import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

class MakeShipmentScreen extends StatefulWidget {
  MakeShipmentScreen({Key? key}) : super(key: key);

  @override
  State<MakeShipmentScreen> createState() => _MakeShipmentScreenState();
}

class _MakeShipmentScreenState extends State<MakeShipmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomSheet: bottomSheet(),
        drawer: AppDrawer(),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
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
                ),
              ),
              Positioned(
                left: 15,
                top: 80,
                right: 15,
                child: Card(
                  child: Column(
                    children: [
                      bottomSheet(),
                      ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        title: Text("Njoro"),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: ColorTheme.dark[3],
                          ),
                          onPressed: () {},
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.send),
                        title: Text("Nakuru"),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: ColorTheme.dark[3],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
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
              labelColor: ColorTheme.dark[2],
              tabs: [
                Tab(
                  text: "Small",
                ),
                Tab(text: "Medium"),
                Tab(text: "Larg"),
              ],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pedal_bike_sharp),
                      trailing: Text("Ksh 700"),
                    ),
                    DefaultButton(handlePress: () {}, text: "Continue")
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pedal_bike_sharp),
                      trailing: Text("Ksh 700"),
                    ),
                    DefaultButton(handlePress: () {}, text: "Continue")
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pedal_bike_sharp),
                      trailing: Text("Ksh 700"),
                    ),
                    DefaultButton(handlePress: () {}, text: "Continue")
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
