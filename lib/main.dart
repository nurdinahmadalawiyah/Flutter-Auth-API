import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_api/Page/Dashboard/dashboard.dart';
import 'package:login_api/Page/SignInPage/signin_page.dart';
import 'package:login_api/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Workout App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
      ),
      home: const CheckLogin(),
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({ Key? key }) : super(key: key);

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

    void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin) {
      if(mounted){
        setState(() {
          isLogin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(isLogin) {
      child = const SignInPage();
    } else {
      child = const Dashboard();
    }

    return Scaffold(
      body: child,
    );
  }
}