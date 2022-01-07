import 'package:courier_services/constants.dart';
import 'package:courier_services/models/user.dart';
import 'package:courier_services/screens/userAccount/profilePage.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/services/exception.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late User user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    user = User(
        userId: 1,
        email: "test@gmail.com",
        firstName: "john",
        lastName: "mdoe",
        profileImage: "",
        phoneNumber: "0742446941");
    try {
      User _user = await Auth.getUserProfile();
      setState(() {
        user = _user;
      });
    } on Failure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message,
              style: TextStyle(color: Theme.of(context).errorColor))));
    }
  }

  Future<void> _refresh() async {
    try {
      User _user = await Auth.refreshUserProfile();
      setState(() {
        user = _user;
      });
    } catch (_) {}
  }

  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _profileImage(),
                    Container(
                        constraints: BoxConstraints(minHeight: height - 250),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: ColorTheme.lighBlueColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _tabIndex = 0;
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: _tabIndex == 0
                                              ? ColorTheme.accentColor
                                              : Colors.transparent,
                                          width: 2.0, // Underline thickness
                                        ))),
                                        child: _labelText("Status")),
                                  ),
                                  InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                            color: _tabIndex == 1
                                                ? ColorTheme.accentColor
                                                : Colors.transparent,
                                            width: 2.0,
                                          )),
                                        ),
                                        child: _labelText("Profile")),
                                    onTap: () {
                                      setState(() {
                                        _tabIndex = 1;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[500],
                            ),
                            (_tabIndex == 0)
                                ? _menu()
                                : Container(
                                    child: user == null
                                        ? CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.black87),
                                          )
                                        : ProfilePage(
                                            user: user,
                                          ),
                                  )
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Hero(tag: "page_paint", child: Container())),
        ],
      ),
    ));
  }

  Container _profileImage() {
    return Container(
      height: 180.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Stack(fit: StackFit.loose, children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 100.0,
                      height: 100.0,
                      alignment: Alignment.center,
                      child: user != null
                          ? Text(
                              "${user.firstName[0]}${user.lastName[0]}"
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorTheme.primary3Color
                          //TODO:replace name initials with profile image

                          // image: DecorationImage(
                          //   image: ExactAssetImage(
                          //       'assets/profile.png'),
                          //   fit: BoxFit.cover,
                          // ),
                          )),
                ],
              ),
              // Padding(
              //     padding: EdgeInsets.only(top: 50.0, right: 80.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         CircleAvatar(
              //           backgroundColor:ColorTheme.accentColor,
              //           radius: 20.0,
              //           child: Icon(
              //             Icons.camera_alt,
              //             color: Colors.white,
              //           ),
              //         )
              //       ],
              //     )),
            ]),
          )
        ],
      ),
    );
  }

  Widget _labelText(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _menu() {
    Future<void> logout() async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove("authToken");
      _prefs.remove("user");
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.welcome, (route) => false);
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _menuItem("My Bookings", Icons.bookmark,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.shipmentHistory)),
        _menuItem("Help", Icons.call,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.support)),
        _menuItem("Feedback", Icons.message,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.feedback)),
        _menuItem("Logout", Icons.exit_to_app, onPressed: logout)
      ],
    );
  }

  Widget _menuItem(String label, IconData icon,
      {required void Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: _labelText(label),
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
