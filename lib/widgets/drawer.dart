import 'package:courier_services/constants.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';

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
              leading: Icon(Icons.account_box_rounded,
                  color: ColorTheme.primaryColor),
              title: Text('Account'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            ),
            ListTile(
              leading: Icon(Icons.legend_toggle_sharp,
                  color: ColorTheme.primaryColor),
              title: Text('Orders'),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.shipmentHistory),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Label',
              ),
            ),
            ListTile(
              leading: Icon(Icons.bookmark, color: ColorTheme.primaryColor),
              title: Text('Item A'),
            ),
          ],
        ),
      ),
    );
  }
}
