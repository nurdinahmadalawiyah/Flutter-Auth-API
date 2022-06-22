import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:login_api/Components/dialod_success_login.dart';
import 'package:login_api/Components/dialog_failed_login.dart';
import 'package:login_api/Components/popup_dialog.dart';
import 'package:login_api/Components/signin_button.dart';
import 'package:login_api/Components/social_icon.dart';
import 'package:login_api/Components/text_field.dart';
import 'package:login_api/Components/textfield_input.dart';
import 'package:login_api/Page/Dashboard/dashboard.dart';
import 'package:login_api/color.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String textUsername = "";
  String textPassword = "";
  late Timer _timer;

  void validasiLogin() async {
    if (textUsername == "" && textPassword == "") {
      Fluttertoast.showToast(
          msg: "Username and Password must be filled",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          fontSize: 16,
          backgroundColor: redColor);
      return;
    }
    showLoaderDialog(context, 30);
    final response = await http.post(
        Uri.parse("http://rismayana.diary-project.com/login.php"),
        body: jsonEncode({"username": textUsername, "password": textPassword}));
    int statCode = response.statusCode;

    if (statCode == 200) {
      Navigator.pop(context);
      saveSession(textUsername);
      String dataLogin = response.body;
      final data = jsonDecode(dataLogin);
      String resStatus = data["username"];
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              DialogSuccessLogin(username: resStatus),
        );
      });
    } else {
      Navigator.pop(context);
      removeSession(textUsername);
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) => const DialogFailedLogin(),
        );
      });
    }
  }

  showLoaderDialog(BuildContext context, int _period) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        _timer = Timer(Duration(seconds: _period), () {
          Navigator.of(context).pop();
        });
        return alert;
      },
    ).then((value) => {
          if (_timer.isActive) {_timer.cancel()}
        });
  }

  saveSession(String textUsername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("username", textUsername);
    await pref.setBool("is_login", true);
  }

  void removeSession(String textUsername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('is_login');
    await pref.remove('username');
  }

  void ceckLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ceckLogin();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultSignInSize = size.height - (size.height * 0.1);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: defaultSignInSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: secondaryColor),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Login to your Account',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: secondaryColor),
                    ),
                    const SizedBox(height: 35),
                    TextFieldInput(
                      onChanged: (e) => textUsername = e,
                      icon: IconlyLight.user,
                      hintText: 'Username',
                    ),
                    const SizedBox(height: 10),
                    TextFieldPassword(
                      onChanged: (e) => textPassword = e,
                      icon: IconlyLight.password,
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Forgot Password ? ",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog(),
                            );
                          },
                          child: const Text(
                            'Click Here',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SignInButton(onTap: () {
                      validasiLogin();
                    }),
                    const SizedBox(height: 20),
                    const Text(
                      'Or sign in with',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: secondaryColor),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          iconSrc: "assets/icons/google.svg",
                          press: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog()),
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/apple.svg",
                          press: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog()),
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog()),
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an Account ? ",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const PopUpDialog(),
                            );
                          },
                          child: const Text(
                            'Sign Up now',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
