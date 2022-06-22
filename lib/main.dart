import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_api/Page/SignInPage/signin_page.dart';
import 'package:login_api/color.dart';

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
      home: const SignInPage(),
    );
  }
}