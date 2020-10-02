import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locationapp/view/about_app.dart';
import 'package:locationapp/view/about_usScreen.dart';
import 'package:locationapp/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
     _save(int token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = token;
    prefs.setInt(key, value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        centerTitle: true,
         backgroundColor:Color(0xff06d6a0),
          leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
     
        title: Text("اعدادات"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 7,
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(
                  fullscreenDialog: true,
                builder: (context){
                  return AboutAppScreen();
                }));
              },
              title: Text("عن التطبيق"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 18,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              onTap: () {
                 Navigator.push(context, CupertinoPageRoute(
                  fullscreenDialog: true,
                builder: (context){
                  return AboutUsScreen();
                }));
              },
              title: Text("حول المبادرة"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 18,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            color: Colors.red,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) {
                                _save(null);
                                return LoginPage();
                              },
                            ),
                          );
              },
              title: Text("تسجيل خروج",style: TextStyle(color: Colors.white),),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
