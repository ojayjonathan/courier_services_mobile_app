import 'package:courier_services/services/auth.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:courier_services/widgets/button/button.dart';
import 'package:courier_services/widgets/defultInput/inputField.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  void resetPassword() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please wait ...",
            style: TextStyle(color: ColorTheme.successColor),
          ),
        ),
      );
      final res = await Auth.resetPassword(_emailController.text.trim());

      res.fold(
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(color: ColorTheme.successColor),
            ),
          ),
        ),
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
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Reset Password',
          style: TextStyle(color: ColorTheme.headerColor, fontSize: 30),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _title(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formKey,
                      child: DefaultInput(
                          hintText: "johndoe@gmail.com",
                          controller: _emailController,
                          validator: emailValidator,
                          icon: Icons.email)),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultButton(handlePress: resetPassword, text: "Submit")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
