import 'package:courier_services/constants.dart';
import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/confirmshipment.dart';
import 'package:courier_services/services/shipment_service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';

class PackageDetail extends StatefulWidget {
  @override
  State<PackageDetail> createState() => _PackageDetailState();
  final Shipment shipment;
  PackageDetail(this.shipment);
}

class _PackageDetailState extends State<PackageDetail> {
  List<Carriage> _carriage = [];
  ShipmentApiProvider _shipmentApiProvider = ShipmentApiProvider();
  Carriage? _selectedCarriage;
  @override
  void initState() {
    super.initState();
  }

  Future<List<Carriage>> getCarriage() async {
    late List<Carriage> carriage;
    await _shipmentApiProvider.carriageList().then(
          (res) => res.fold((data) {
            carriage = data;
          }, (r) => throw (r)),
        );
    return carriage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Select Vehicle",
          style: TextStyle(color: ColorTheme.dark[1], fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getCarriage(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final carriage = snapshot.data as List<Carriage>;
                _carriage = carriage;
                return Column(
                  children: [
                    Container(
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
                                    (_element) => carriageTile(_element),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ..._carriage.where(
                                    (element) {
                                      return element.carrierType == "B";
                                    },
                                  ).map(
                                    (_element) => carriageTile(_element),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ..._carriage.where(
                                    (element) {
                                      return element.carrierType == "L";
                                    },
                                  ).map(
                                    (_element) => carriageTile(_element),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Total Price\t\t\t",
                            ),
                            TextSpan(
                              text: "${widget.shipment.price ?? 0}",
                            ),
                          ],
                          style: TextStyle(
                              color: ColorTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    _continue()
                  ],
                );
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
        ),
      ),
    );
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
                    duration: SNACKBARDURATION),
              );
              return;
            }
            widget.shipment.vehicle = _selectedCarriage!.id;
            widget.shipment.carriage = _selectedCarriage;

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ConfirmShipment(
                  shipment: widget.shipment,
                ),
              ),
            );
          },
          text: "Continue"),
    );
  }

  ListTile carriageTile(Carriage carriage) {
    bool selected = _selectedCarriage == carriage;
    return ListTile(
      onTap: () {
        _selectedCarriage = carriage;
        widget.shipment.price_ = widget.shipment.distance != null
            ? carriage.chargeRate * widget.shipment.distance!
            : 0.0;
        setState(() {});
      },
      selected: selected,
      leading: Container(
        height: 50,
        width: 50,
        child: Icon(carriage.icon),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
              color: selected ? ColorTheme.primaryColor : ColorTheme.dark[3],
              width: 2),
        ),
      ),
      trailing: Text(
        "Ksh ${carriage.chargeRate} per km",
      ),
    );
  }
}
