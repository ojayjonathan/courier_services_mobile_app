import 'package:courier_services/constants.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/paints/welcomePagePaint.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cargo delivery services",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Text(
          "Courier Services",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(height: height * 0.6, child: WelcomePagePaint()),
                  Container(
                    height: height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: _title(),
                          width: width * 0.75,
                          padding: EdgeInsets.only(top: 50),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              "assets/images/truck.png",
                              width: width * 0.75,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: DefaultButton(
                  handlePress: () =>
                      Navigator.of(context).pushNamed(AppRoutes.signin),
                  text: "Login",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: _signup(),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup() {
    return SizedBox(
      width: 395,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.signup),
        child: Text(
          "Register",
          style: TextStyle(color: ColorTheme.dark[2]),
        ),
        style: Styles.buttonStyle.copyWith(
          backgroundColor:
              MaterialStateProperty.all(ColorTheme.backgroundColor),
          side: MaterialStateProperty.all(BorderSide(
            color: ColorTheme.primary3Color,
            width: 2,
          )),
        ),
      ),
    );
  }
}
