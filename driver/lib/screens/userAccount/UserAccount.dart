import 'package:courier_services/models/user.dart';
import 'package:courier_services/screens/userAccount/profilePage.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AccountPage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  Driver? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final _res = await Auth.getUserProfile();
    _res.fold(
      (_user) => setState(() {
        user = _user;
      }),
      (error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message,
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final _res = await Auth.getUserProfile();
    _res.fold(
        (_user) => setState(() {
              user = _user;
            }),
        (r) => null);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: user == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorTheme.primaryColor,
                  ),
                )
              : Column(
                  children: <Widget>[
                    _profileImage(),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(minHeight: height - 250),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: ColorTheme.lighBlueColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: SingleChildScrollView(
                          child: ProfilePage(
                            user: user!,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
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
                              "${user!.user.userName[0]}".toUpperCase(),
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
}
