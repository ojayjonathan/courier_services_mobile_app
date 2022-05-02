import 'package:courier_services/constants.dart';
import 'package:courier_services/services/auth.dart';
import 'package:courier_services/theme.dart';
import 'package:courier_services/utils/validators.dart';
import 'package:flutter/material.dart';
import '../../widgets/button/button.dart';
import '../../widgets/defultInput/inputField.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dlNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void register() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Please wait...",
          style: TextStyle(color: ColorTheme.successColor),
        )));
        final res = await Auth.registerUser(
          {
            "email": _emailController.text,
            "phone_number": "+254" + _phoneController.text.substring(1),
            "username": _usernameController.text,
            "password": _passwordController.text,
            "is_driver": true,
            "dl_number": _dlNumberController.text
          },
        );
        res.fold((l) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushNamed(AppRoutes.home);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Account created successfuly",
                style: TextStyle(color: ColorTheme.successColor),
              ),
            ),
          );
        }, (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message,
                style: TextStyle(color: Theme.of(context).errorColor),
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
          "Register",
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Welcome Aboard!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'SignUp with Courier',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _usernameController,
                            hintText: 'User Name',
                            validator: requiredValidator,
                            icon: Icons.person_outline,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: requiredValidator,
                            icon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _phoneController,
                            hintText: 'Phone number',
                            validator: phoneValidator,
                            keyboardType: TextInputType.number,
                            icon: Icons.phone,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultInput(
                            controller: _dlNumberController,
                            hintText: 'Driver licence number',
                            validator: requiredValidator,
                            icon: Icons.local_taxi,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: PasswordField(
                            _passwordController,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DefaultButton(
                            handlePress: register,
                            text: 'Sign Up',
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already a User ? ',
                                      style: TextStyle(color: Colors.grey)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.signin);
                                    },
                                    child: Text('Login now',
                                        style: TextStyle(
                                            color: ColorTheme.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
