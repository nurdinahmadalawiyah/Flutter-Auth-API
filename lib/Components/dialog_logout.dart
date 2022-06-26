import 'package:flutter/material.dart';
import 'package:login_api/Page/SignInPage/signin_page.dart';
import 'package:login_api/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({
    Key? key,
  }) : super(key: key);

  void removeSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('is_login');
    await pref.remove('username');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text('Logout!', textAlign: TextAlign.center),
      content: const Text('Are you sure you want to logout ?',
          textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              primary: whiteColor, backgroundColor: redColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(
              primary: whiteColor, backgroundColor: greenColor),
          onPressed: () {
            removeSession();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SignInPage(),
              ),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
