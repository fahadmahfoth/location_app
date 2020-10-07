import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locationapp/api/database_helper.dart';

import 'home_view.dart';

class LoginPage extends StatefulWidget {

  final message ;
  LoginPage({this.message});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    DataBase database = DataBase();
      bool isLooging = false;


      
    TextEditingController _usernameController = TextEditingController() ;
    TextEditingController _passwordController = TextEditingController() ;

    @override
  // void initState() {
     
  //             widget.message!= null ? EdgeAlert.show(context,
  //               title: 'تنبيه',
  //               description: widget.message,
  //               icon: Icons.send,
  //               gravity: EdgeAlert.TOP):print("جديد");

      

  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 12,
            ),
            Container(
                height: 110,
                child: Container(
                  child: Image.asset("assets/1.png"),
                )),
            SizedBox(
              height: 38,
            ),
            Center(
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 38,
            ),
           
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 10, left: 10, bottom: 8),
                  child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 4, right: 4),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          decoration: new InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 12, bottom: 12),
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: 'اسم المستخدم',
                              alignLabelWithHint: true,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: InputBorder.none),

                              controller: _usernameController,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 10, left: 10, bottom: 8),
                  child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 4, right: 4),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: new InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 12, bottom: 12),
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: 'كلمة السر',
                              alignLabelWithHint: true,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: InputBorder.none),
                              controller: _passwordController,
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                !isLooging
                          ? GestureDetector(
                  onTap: () {
                    print("taped");

                    setState(() {
                                    isLooging = true;
                                  });

                    

                    database.login(username:_usernameController.text,password: _passwordController.text).whenComplete((){
                    print(database.message);
                     if (database.status) {

                                      print(database.status.toString());
                                      Navigator.pushReplacement(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return HomeView();
                                      }));
                                    }
                                    if (!database.status) {
                                      setState(() {
                                        isLooging = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: <Widget>[
                                                OutlineButton(
                                                  highlightedBorderColor:
                                                      Colors.red,
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "اغلاق",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              ],
                                              title: Text(
                                                "خطأ",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              content: Text(
                                                  "${database.message}"),
                                            );
                                          });
                                    }
                                  });
                                },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 60, left: 60, bottom: 8),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4)
                          ],
                          color: Color(0xff33533D),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ):Center(
                  child: CircularProgressIndicator(
                               
                              ),
                ),
              
          ],
        ),
      ),
    );
  }
}
