import 'package:courier_services/constants.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/defultInput/inputField.dart';
import 'package:flutter/material.dart';

class PackageDetail extends StatefulWidget {
  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  final TextEditingController _pickup = TextEditingController();

  final TextEditingController _dropoff = TextEditingController();
  int? _natureOfGoods = 0;
  List<bool> checked = [true, true, false, false, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                DefaultInput(
                  hintText: "pickup",
                  controller: _pickup,
                  validator: requiredValidator,
                  icon: Icons.location_on,
                ),
                DefaultInput(
                  hintText: "dropoff",
                  controller: _dropoff,
                  validator: requiredValidator,
                  icon: Icons.send,
                ),
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
                            if (value != null) {
                              checked[0] = value;
                            }
                          });
                        },
                        // tristate: 1 == 1,
                        value: checked[0],
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
                            if (value != null) {
                              checked[1] = value;
                            }
                          });
                        },
                        // tristate: 1 == 1,
                        value: checked[1],
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
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              checked[1] = value;
                            }
                          });
                        },
                        // tristate: 1 == 1,
                        value: checked[1],
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
                SizedBox(
                  height: 20,
                ),
                _dropDown(),
                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  handlePress: () => Navigator.of(context)
                      .pushNamed(AppRoutes.confirmShipment),
                  text: "Continue",
                )
              ],
            ),
          ),
        ),
      ),
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
                  child: Text("Select issue category"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("Fragile"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("Perishable"),
                ),
              ],
              onChanged: (i) {
                // setState(() {
                //   _natureOfGoods = i;
                // });
              },
            ),
          ),
        );
      },
    );
  }
}
