import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  Future<void> _call(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: Hero(tag: "page_paint", child: Container())),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/contact.svg", width: 300),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text("Contact Us",
                        style: TextStyle(
                            color: ColorTheme.dark[2],
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                  InkWell(
                    onTap: () => _call("tel:0716539104"),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      elevation: 2,
                      shadowColor: Colors.grey[250],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                                color: ColorTheme.accentColor,
                              ),
                            ),
                            SelectableText("0716539104")
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    elevation: 2,
                    shadowColor: Colors.grey[250],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.email,
                              size: 20,
                              color: ColorTheme.accentColor,
                            ),
                          ),
                          InkWell(
                              onTap: () =>
                                  _call("mailto:matndogo254@gmail.com"),
                              child: Text("matndogo254@gmail.com"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
