import 'package:courier_services/models/shipment.dart';
import 'package:courier_services/services/shipment_service.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../widgets/button/button.dart';
import '../../widgets/defultInput/inputField.dart';
import '../../widgets/ratingBar/ratingBar.dart';

class RatingScreen extends StatelessWidget {
  final Shipment shipment;
  RatingScreen({Key? key, required this.shipment}) : super(key: key);
  final ShipmentApiProvider _service = ShipmentApiProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void rate() {
      if (_formKey.currentState!.validate()) {
        _service
            .rateDelivery(
              this.shipment.id!,
              4.5,
              _textController.text,
            )
            .then(
              (res) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Thank you for your feedback",
                    style: TextStyle(color: ColorTheme.successColor),
                  ),
                ),
              ),
            );
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Courier'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Delivery complete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorTheme.h1Color),
                  ),
                ),
                Text(
                  'Rate Our Delivery Ride\n Service',
                  style: TextStyle(
                    color: ColorTheme.h2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  minRadius: 42,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/yuna.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Driver Rating'),
                ),
                ratingBar(rating: 4.0, size: 30),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _textController,
                            hintText: 'FeedBack',
                            validator: requiredValidator,
                            icon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultButton(
                            handlePress: rate,
                            text: 'Submit FeedBack',
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
