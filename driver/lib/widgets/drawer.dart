import 'package:courier_services/constants.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "C",
                      style: TextStyle(
                          color: ColorTheme.primaryColor,
                          fontSize: 32,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: "ourier",
                      style: TextStyle(
                        color: ColorTheme.dark[2],
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.home, color: ColorTheme.primaryColor),
              title: Text('Home'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.home),
            ),
            ListTile(
              leading: Icon(Icons.local_taxi, color: ColorTheme.primaryColor),
              title: Text('Vehicles'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.vehicle),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: ColorTheme.primaryColor),
              title: Text('Contact'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.support),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Account',
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box_rounded,
                  color: ColorTheme.primaryColor),
              title: Text('Account'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            ),
            ListTile(
              leading:
                  Icon(Icons.bookmark_outlined, color: ColorTheme.primaryColor),
              title: Text('Orders'),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.shipmentHistory),
            ),
            ListTile(
              leading:
                  Icon(Icons.notifications, color: ColorTheme.primaryColor),
              title: Text('Notifications'),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.notifications),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: ColorTheme.primaryColor),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences _pref = await SharedPreferences.getInstance();
                _pref.clear();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(AppRoutes.signin);
              },
            ),
          ],
        ),
      ),
    );
  }
}
