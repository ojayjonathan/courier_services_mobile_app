import 'package:courier_services/constants.dart';
import 'package:courier_services/screens/Signup.dart';
import 'package:courier_services/screens/Vehicles.dart';
import 'package:courier_services/screens/home.dart';

import 'package:courier_services/screens/intro.dart';
import 'package:courier_services/screens/notifications.dart';
import 'package:courier_services/screens/resetPassword.dart';
import 'package:courier_services/screens/rideHistory.dart';
import 'package:courier_services/screens/splash.dart';
import 'package:courier_services/screens/support.dart';
import 'package:courier_services/screens/userAccount/UserAccount.dart';
import 'package:courier_services/screens/welcomePage.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './screens/signin.dart';

final AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(CourierDriver());
}

class CourierDriver extends StatefulWidget {
  @override
  _CourierDriverState createState() => _CourierDriverState();
}

class _CourierDriverState extends State<CourierDriver> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: ColorTheme.primaryColor,
              playSound: true,
              icon: "@mipmap/launcher_icon",
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title ?? "Notification"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(notification.body ?? "")],
                  ),
                ),
              );
            });
      }
    });
  }

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
        AppRoutes.notifications: (_) => NotificationScreen(),
        AppRoutes.resetpassword: (_) => ResetPasswordPage(),
      },
    );
  }
}
