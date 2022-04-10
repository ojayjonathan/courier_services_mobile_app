import 'package:courier_services/constants.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:flutter/material.dart';
import '../../widgets/button/button.dart';
import '../../widgets/defultInput/inputField.dart';
import '../theme.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void login() async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Please wait...",
        style: TextStyle(color: ColorTheme.successColor),
      )));
      if (_formKey.currentState!.validate()) {
        final res = await Auth.loginUser({
          "email": _emailController.text,
          "password": _passwordController.text
        });
        res.fold((l) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushNamed(AppRoutes.home);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login successfuly",
                style: TextStyle(
                  color: ColorTheme.successColor,
                ),
              ),
            ),
          );
        }, (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message,
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              duration: SNACKBARDURATION,
            ),
          );
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Signin",
          textAlign:TextAlign.center,
          style: TextStyle(color: ColorTheme.dark[1], fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                heightFactor: 3,
                child: Image.asset(
                  'assets/images/truck.png',
                  height: 50,
                  width: 195,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Text(
                'Welcome Back !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text('Login to continue using Courier'),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _emailController,
                            hintText: 'email',
                            validator: emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.email_outlined,
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: PasswordField(
                            _passwordController,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  AppRoutes.resetpassword,
                                ),
                                child: Text(
                                  'forgot password',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: DefaultButton(
                          handlePress: login,
                          text: 'Log in',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('New a User ? ',
                                  style: TextStyle(color: Colors.grey)),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.signup);
                                },
                                child: Text('Sign up for a new account',
                                    style: TextStyle(
                                        color: ColorTheme.primaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
