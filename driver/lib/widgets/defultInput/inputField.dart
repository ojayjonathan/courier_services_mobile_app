import 'package:courier_services/utils/validators.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

class DefaultInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final IconData icon;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextInputType keyboardType;
  const DefaultInput(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.icon,
      this.focusNode,
      this.readOnly = false,
      this.isPassword = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        focusNode: focusNode,
        obscureText: this.isPassword,
        textAlign: TextAlign.start,
        readOnly: readOnly,
        decoration: InputDecoration(
            prefixIcon: Icon(
              this.icon,
              color: readOnly ? ColorTheme.primaryColor : null,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: this.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  const BorderSide(color: ColorTheme.borderColor, width: 0.0),
            )),
        controller: this.controller,
        validator: this.validator,
        keyboardType: keyboardType,
      ),
    );
  }
}

class MapInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final IconData icon;

  final FocusNode? focusNode;
  final Function()? onTap;
  const MapInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.icon,
    this.onTap,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        readOnly: true,
        focusNode: focusNode,
        onTap: this.onTap,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            prefixIcon: Icon(
              this.icon,
              color: ColorTheme.primaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: this.hintText,
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: ColorTheme.dark[1],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(999)),
              borderSide:
                  const BorderSide(color: ColorTheme.borderColor, width: 0.0),
            )),
        controller: this.controller,
        validator: this.validator,
      ),
    );
  }
}

//password field
class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField(this.controller);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          obscureText: hidePassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  const BorderSide(color: ColorTheme.borderColor, width: 0.0),
            ),
            prefixIcon: Icon(Icons.lock),
            hintText: "password",
            suffix: InkWell(
                onTap: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                child: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: ColorTheme.dark[2],
                )),
          ),
          validator: passwordValidator,
          controller: widget.controller,
        ));
  }
}
