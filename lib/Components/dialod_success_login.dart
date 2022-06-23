
import 'package:flutter/material.dart';

import 'package:login_api/Page/Dashboard/dashboard.dart';
import 'package:login_api/color.dart';

class DialogSuccessLogin extends StatelessWidget {
  final String username;
  const DialogSuccessLogin({
    Key? key, required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text('Login Successful!', textAlign: TextAlign.center),
      content: Text('Welcome Back $username \nClick OK to continue',
          textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              primary: whiteColor,
              backgroundColor: greenColor),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard())),
          child: const Text('OK'),
        ),
      ],
    );
  }
}