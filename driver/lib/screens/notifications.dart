import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Notification'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                    color: ColorTheme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder(
                  future: Auth.notification(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<UserNotification> notifications =
                          snapshot.data as List<UserNotification>;
                      if (notifications.isEmpty)
                        return Text("There is noting here ");
                      return ListView.builder(
                          itemBuilder: (_, index) =>
                              _notificationCard(context, notifications[index]),
                          itemCount: notifications.length);
                    }
                    return snapshot.hasError
                        ? Text(snapshot.error.toString())
                        : Center(
                            child: CircularProgressIndicator(
                              color: ColorTheme.primaryColor,
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationCard(BuildContext context, UserNotification n) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shadowColor: Colors.grey.shade300,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      n.date,
                      style: TextStyle(
                          color: ColorTheme.dark[1],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(n.message)
            ],
          )),
    );
  }
}
