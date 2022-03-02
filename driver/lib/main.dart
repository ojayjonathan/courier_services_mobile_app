import 'package:courier_services/constants.dart';
import 'package:courier_services/screens/Signup.dart';
import 'package:courier_services/screens/Vehicles.dart';
import 'package:courier_services/screens/home.dart';

import 'package:courier_services/screens/intro.dart';
import 'package:courier_services/screens/rideHistory.dart';
import 'package:courier_services/screens/splash.dart';
import 'package:courier_services/screens/support.dart';
import 'package:courier_services/screens/userAccount/UserAccount.dart';
import 'package:courier_services/screens/welcomePage.dart';
import 'package:flutter/material.dart';

import './screens/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87, size: 12.0),
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.shipmentHistory: (_) => RideHistory(),
        AppRoutes.signin: (_) => SignIn(),
        AppRoutes.signup: (_) => SignUp(),
        AppRoutes.home: (_) => Scaffold(
              body: Home(),
            ),
        AppRoutes.splash: (_) => SplashScreen(),
        AppRoutes.intro: (_) => OnBoardingPage(),
        AppRoutes.welcome: (_) => WelcomePage(),
        AppRoutes.profile: (_) => AccountPage(),
        AppRoutes.support: (_) => ContactUs(),
        AppRoutes.vehicle: (_) => VehicleScreen(),

      },
    );
  }
}