import 'package:flutter/material.dart';
import 'package:login_api/Components/input_container.dart';
import 'package:login_api/color.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: secondaryColor,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(icon, color: primaryColor),
          hintText: hintText,
          border: InputBorder.none
        ),
      ),
    );
  }
}