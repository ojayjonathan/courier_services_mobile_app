import 'package:courier_services/constants.dart';
import 'package:courier_services/models/carriage.dart';
import 'package:courier_services/services/driver_shipment.service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/defultInput/inputField.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final _apiProvider = DriverShipmentProvider();
  int? _carriageType = 0;
  List<Carriage> carriage = [];
  TextEditingController _chargeRate = TextEditingController();
  TextEditingController _vehicleRegistartionNumber = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // carriage_capacity

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
          future: _apiProvider.carriageList(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              carriage = snapshot.data as List<Carriage>;
              if (carriage.isEmpty) return Text("There is nothing here");
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: ColorTheme.primaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_context) {
                return _createCarriage();
              });
        },
      ),
    );
  }

  Widget _carriageCard(Carriage carriage) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: ColorTheme.dark[2]),
                  children: [
                    TextSpan(
                        text: "Vehicle reg No: \t",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "${carriage.vehicleRegistrationNumber}",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: ColorTheme.dark[2]),
                  children: [
                    TextSpan(
                        text: "CarriageType: \t",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "${carriage.carrierType}",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: ColorTheme.dark[2]),
                  children: [
                    TextSpan(
                        text: "Charge rate: \t",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: " Ksh ${carriage.chargeRate}",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: ColorTheme.dark[2]),
                  children: [
                    TextSpan(
                        text: "Capacity: \t",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "${carriage.carrierCapacity}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createCarriage() {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Form(
          key: _formKey,
          child: Column(children: [
            DefaultInput(
              hintText: "Vehicle Registration",
              controller: _vehicleRegistartionNumber,
              validator: requiredValidator,
              icon: Icons.text_fields,
            ),
            DefaultInput(
                hintText: "Charge Rate",
                controller: _chargeRate,
                validator: numberValidator,
                icon: Icons.text_fields),
            _dropDown(),
            SizedBox(
              height: 20,
            ),
            DefaultButton(
                handlePress: () {
                  Navigator.of(context).pop();
                  if (_formKey.currentState!.validate()) {
                    final data = {
                      "carrier_type": _carriageType == null
                          ? "L"
                          : [null, "L", "P", "B"][_carriageType!],
                      "charge_rate": _chargeRate.text,
                      "vehicle_registration_number":
                          _vehicleRegistartionNumber.text,
                      "carrier_capacity": "M",
                    };
                    _apiProvider.createcarriage(data).then(
                          (value) => value.fold(
                            (c) {
                              carriage.add(c);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Vehicle Created",
                                    style: TextStyle(
                                        color: ColorTheme.successColor),
                                  ),
                                ),
                              );
                            },
                            (r) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  r.message,
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                                duration: SNACKBARDURATION,
                              ),
                            ),
                          ),
                        );
                  }
                },
                text: "Submit")
          ]),
        ),
      ),
    ]);
  }

  Widget _dropDown() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  const BorderSide(color: Color(0X55CED0D2), width: 0.0),
            ),
            // hintText: 'Select issue category',
          ),
          isEmpty: _carriageType == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _carriageType,
              isDense: true,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text("Select Carriage Type"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("Lorry"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("PickUp"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("Motor bike"),
                ),
              ],
              onChanged: (i) {
                setState(() {
                  if (i != null) {
                    _carriageType = i;
                    setState(() {});
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }
}
