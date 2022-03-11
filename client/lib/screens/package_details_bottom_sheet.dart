import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/screens/confirmshipment.dart';
import 'package:courier_services/screens/shipment_pricing.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/defultInput/inputField.dart';
import 'package:flutter/material.dart';

class PackageDetailBottomSheet extends StatefulWidget {
  @override
  State<PackageDetailBottomSheet> createState() =>
      _PackageDetailBottomSheetState();
  final Shipment shipment;
  PackageDetailBottomSheet(this.shipment);
}

class _PackageDetailBottomSheetState extends State<PackageDetailBottomSheet> {
  final TextEditingController _pickup = TextEditingController();

  final TextEditingController _dropoff = TextEditingController();
  int? _natureOfGoods = 0;
  List<bool> checked = [true, true, false, false, true];
  String size = "S";
  @override
  void initState() {
    _pickup.text = "${widget.shipment.origin?.name}";
    _dropoff.text = "${widget.shipment.destination?.name}";
    super.initState();
  }

  void _toNextScreen() {
    widget.shipment.cargo = Cargo(
      size,
      _natureOfGoods == 1 ? "F" : "NF",
    );
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PackageDetail(widget.shipment)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                DefaultInput(
                    hintText: "pickup",
                    controller: _pickup,
                    validator: requiredValidator,
                    icon: Icons.location_on,
                    readOnly: true),
                DefaultInput(
                    hintText: "dropoff",
                    controller: _dropoff,
                    validator: requiredValidator,
                    icon: Icons.send,
                    readOnly: true),
                SizedBox(
                  height: 20,
                ),
                Text("What is the size your package?"),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              size = "S";
                            }
                          });
                        },
                        value: size == "S",
                        activeColor: ColorTheme.primaryColor,
                      ),
                      Text(
                        'Small ${"\t" * 5} (Bellow  100kg)',
                        style: TextStyle(color: ColorTheme.dark[2]),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              size = "M";
                            }
                          });
                        },
                        // tristate: 1 == 1,
                        value: size == "M",
                        activeColor: ColorTheme.primaryColor,
                      ),
                      Text(
                        'Medium ${"\t" * 5} (101kg - 3 tones)',
                        style: TextStyle(color: ColorTheme.dark[2]),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              size = "L";
                            }
                          });
                        },
                        value: size == "L",
                        activeColor: ColorTheme.primaryColor,
                      ),
                      Text(
                        'Large ${"\t" * 5} (Above 3 tones)',
                        style: TextStyle(color: ColorTheme.dark[2]),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _dropDown(),
                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  handlePress: _toNextScreen,
                  text: "Continue",
                )
              ],
            ),
          ),
        ),
      ],
    );
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
          isEmpty: _natureOfGoods == 0,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _natureOfGoods,
              isDense: true,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text("Select package nature"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("Fragile"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("Not Fragile"),
                ),
              ],
              onChanged: (i) {
                setState(() {
                  _natureOfGoods = i;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
