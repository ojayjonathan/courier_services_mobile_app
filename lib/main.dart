import 'package:courier_services/constants.dart';
import 'package:courier_services/screens/confirmshipment.dart';
import 'package:courier_services/screens/intro.dart';
import 'package:courier_services/screens/packageDetail.dart';
import 'package:courier_services/screens/splash.dart';
import 'package:courier_services/screens/support.dart';
import 'package:courier_services/screens/userAccount/UserAccount.dart';
import 'package:courier_services/screens/welcomePage.dart';
import 'package:flutter/material.dart';

import './screens/rating.dart';
import './screens/rideHistory.dart';
import './screens/signin.dart';
import './screens/Signup.dart';
import './screens/home.dart';

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
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.rating: (_) => RatingScreen(),
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
        AppRoutes.packageDetail: (_) => PackageDetail(),
        AppRoutes.confirmShipment: (_) => ConfirmShipment(),
      },
    );
  }
}
// primarySwatch: Color(0x3277D8),

