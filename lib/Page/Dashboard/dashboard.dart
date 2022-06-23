import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_api/Page/SignInPage/signin_page.dart';
import 'package:login_api/color.dart';
import 'package:login_api/json_list/user_view_model.dart';
import 'package:login_api/models/data_prodi.dart';
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

  Widget personDetailCard(DataProdi data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: whiteColor,
        elevation: 0,
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
                              'https://i.pravatar.cc/150?u=${data.nim}'))),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.nama,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.nim,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    data.prodi,
                    style: const TextStyle(fontSize: 12),
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

  showDetailDialog(DataProdi data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: whiteColor,
            title: const Text('Detail Person', textAlign: TextAlign.center),
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
                              'https://i.pravatar.cc/150?u=${data.nim}'))),
                ),
              ),
              Text(data.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(data.nim,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text("Prodi : ${data.prodi}",
                      style: const TextStyle(fontSize: 12)),
                  Text("Agama : ${data.agama}",
                      style: const TextStyle(fontSize: 12)),
                  // Text("Tempat, Tanggal Lahir : ${data.tempatLahir}, ${data.tanggalLahir}",
                  //     style: const TextStyle(fontSize: 12)),
                  Text("Jenis Kelamin : ${data.jnsKel}",
                      style: const TextStyle(fontSize: 12)),
                  // Text("Alamat : ${data.alamat}",
                  //     style: const TextStyle(fontSize: 12)),
                  Text("Asal Sekolah : ${data.asalSekolah}",
                      style: const TextStyle(fontSize: 12)),
                  Text("Tahun : ${data.tahun}",
                      style: const TextStyle(fontSize: 12)),
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
          title: const Text(
            "List User",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          backgroundColor: whiteColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: secondaryColor,
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
        backgroundColor: whiteColor,
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
