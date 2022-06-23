import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_api/models/data_prodi.dart';

class UserViewModel {
  Future<dynamic> getUsers() async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("http://rismayana.diary-project.com/bio.php?prodi=Teknik%20Informatika"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
        print("data category success");
        final data = dataProdiFromJson(hasil.body);
        return data;
      } else {
        print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}
