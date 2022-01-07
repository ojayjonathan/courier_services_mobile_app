import 'package:flutter/material.dart';
import '../../theme.dart';

class DefaultInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final IconData icon;
  final bool readOnly;
  final FocusNode? focusNode;
  const DefaultInput(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.icon,
      this.focusNode,
      this.readOnly = false,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        focusNode: focusNode,
        obscureText: this.isPassword,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: this.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  const BorderSide(color: ColorTheme.borderColor, width: 0.0),
            )),
        controller: this.controller,
        validator: this.validator,
      ),
    );
  }
}
