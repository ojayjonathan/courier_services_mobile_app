import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:flutter/material.dart';

class ConfirmShipment extends StatelessWidget {
  const ConfirmShipment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                elevation: 5,
                shadowColor: Colors.grey.shade300,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _circle(),
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(
                                left: 10, top: 0, right: 0, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  11,
                                  (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Colors.transparent
                                              : Colors.grey.shade300,
                                          height: 1,
                                          width: 2,
                                        ),
                                      )),
                            ),
                          ),
                          _circle(),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Njoro",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text("Cbd street 1"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Nakuru",
                              style: TextStyle(
                                  color: ColorTheme.dark[1],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text("Cbd street 1"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Size: Small ",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nature: Fragile",
                          style: TextStyle(color: ColorTheme.dark[2]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "KES 3000",
                              style: TextStyle(color: ColorTheme.primaryColor)),
                          TextSpan(
                            text: "\t\t Pending",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Packages :",
                            style: TextStyle(color: ColorTheme.dark[2]),
                          ),
                          TextSpan(
                              text: "\t\t 1",
                              style: TextStyle(color: ColorTheme.dark[2]))
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: DefaultButton(
                        handlePress: () {},
                        text: "I CONFIRM",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Widget _circle() {
    return Container(
      height: 20,
      width: 20,
      child: Icon(
        Icons.circle,
        color: ColorTheme.primary3Color,
        size: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorTheme.primary3Color, width: 2),
      ),
    );
  }
}
