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

  
  var message = "هنالك خطأ في الاتصال";
  var status = false  ;
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
        status = true ;
        return true;
      }
      message = req.body.toString();
      status = false ;
      return false;

    } on SocketException {
      message = "لايوجد اتصال انترنت";
    }
     catch (e) {
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
          body: {"UserID": value.toString(), "lat": lat.toString(),"lng":lng.toString()});

      

      message = req.body.toString();
      print(message);
     
      return 0;



      

    } on SocketException {
      message = "لايوجد اتصال انترنت";
    }
    
    
    catch (e) {
      print(e.toString());
    }


  }
}
