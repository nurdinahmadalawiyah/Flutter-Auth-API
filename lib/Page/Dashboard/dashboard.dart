import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_api/Page/SignInPage/signin_page.dart';
import 'package:login_api/json_list/user_model.dart';
import 'package:login_api/json_list/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List dataUser = [];
    late Timer _timer;
    
  void getDataUser() {
    UserViewModel().getUsers().then((value) {
      setState(() {
          dataUser = value;
      });
    });
  }

  Widget personDetailCard(UserModel data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        color: const Color(0XFF1B2430),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pravatar.cc/150?u=${data.email}'))),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.username,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    data.email,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  showDetailDialog(UserModel data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: const Color(0XFF05050b),
            title: const Text('Detail Person',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pravatar.cc/150?u=${data.email}'))),
                ),
              ),
              Text(data.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(data.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text("Username : ${data.username}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                  Text("Website : ${data.website}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          );
        });
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

  void removeSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('is_login');
    await pref.remove('username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "List User",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          backgroundColor: const Color(0XFF05050b),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                removeSession();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignInPage(),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: const Color(0XFF05050b),
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {
                    showDetailDialog(dataUser[i]);
                  },
                  child: personDetailCard(dataUser[i]));
            },
            itemCount: dataUser == null ? 0 : dataUser.length,
          ),
        ));
  }
}
