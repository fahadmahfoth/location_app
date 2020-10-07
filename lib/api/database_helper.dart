import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataBase {
  _save(int token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = token;
    prefs.setInt(key, value);
  }

  _saveStatus(int token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'status';
    final value = token;
    prefs.setInt(key, value);
  }

  var message = "هنالك خطأ في الاتصال";
  var status = false;
  var status2 = true;
  var logout = false;
  login({String username, String password}) async {
    try {
      var req = await http.post(
          "https://agatha-academy.kf.iq/PhoneRequest/login.php",
          body: {"username": "$username", "password": "$password"});

      int userid = int.tryParse(req.body);

      if (userid is int) {
        print(userid);
        message = "تم التسجيل بنجاح";
        _save(userid);
        status = true;
        return true;
      }
      message = req.body.toString();
      status = false;
      return false;
    } on SocketException {
      message = "لايوجد اتصال انترنت";
    } catch (e) {
      print(e.toString());
    }
  }

  updateLocation({double lat, double lng}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = prefs.get(key) ?? 0;
    print(value);

    try {
      var req = await http.post(
          "https://agatha-academy.kf.iq/PhoneRequest/locationsUpdate.php",
          body: {
            "UserID": value.toString(),
            "lat": lat.toString(),
            "lng": lng.toString()
          });

      if (req.body.toString().contains("USER_NOT_FOUND") ||
          req.body.toString().contains("NOT_FOUND_LAT_LANG_VAL") ||
          req.body.toString().contains("NOT_FOUND_USERID")) {
        logout = true;
        prefs.remove('userid');
      }
      message = req.body.toString();
      print(message);

      if (int.parse(req.body) == 0) {
        status2 = false;
        _saveStatus(int.parse(req.body));
      }

      return 0;
    } on SocketException {
      message = "لايوجد اتصال انترنت";
    } catch (e) {
      print(e.toString());
    }
  }

  updateStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = prefs.get(key) ?? 0;
    print(value);

    try {
      var req = await http.post(
          "https://agatha-academy.kf.iq/PhoneRequest/chekStatus.php",
          body: {"UserID": value.toString()});

      message = req.body.toString();

      print(message);

      _saveStatus(int.parse(req.body));

      return 0;
    } on SocketException {
      message = "لايوجد اتصال انترنت";
    } catch (e) {
      print(e.toString());
    }
  }
}
