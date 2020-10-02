import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:locationapp/api/database_helper.dart';
import 'package:locationapp/view/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_alert/status_alert.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:edge_alert/edge_alert.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool sendlocation = false;
  bool isLoading = false;
  DataBase database = DataBase();

  var userid;

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = prefs.get(key) ?? 0;
    if (value != 0) {
      userid = prefs.get(userid);

      // print(userid);
    }
  }

  onpressed() {
    if (sendlocation) {
      close();
      setState(() {
        sendlocation = false;
      });

      StatusAlert.show(
        context,
        duration: Duration(seconds: 2),
        title: 'تم الايقاف',
        subtitle: 'تم ايقاف مزامنة الموقع',
        configuration: IconConfiguration(icon: Icons.location_off),
      );
    } else {
      getCurrentLocation();

      setState(() {
        sendlocation = true;
      });

      StatusAlert.show(
        context,
        duration: Duration(seconds: 2),
        title: 'تتم مشاركة الموقع',
        subtitle: 'يتم مزامنة موقعك',
        configuration: IconConfiguration(icon: Icons.location_on),
      );
    }
  }

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  dynamic lat = 0;
  dynamic lng = 0;

  void getCurrentLocation() async {
    try {
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((locationData) {
        if (locationData != null) {
          double calculateDistance(lat1, lon1, lat2, lon2) {
            var p = 0.017453292519943295;
            var c = cos;
            var a = 0.5 -
                c((lat2 - lat1) * p) / 2 +
                c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
            return 12742 * asin(sqrt(a));
          }

          double totalDistance = calculateDistance(
              lat, lng, locationData.latitude, locationData.longitude);

          if (totalDistance > 0.05) {
            print(totalDistance);
           

            setState(() {
              lat = locationData.latitude;
              lng = locationData.longitude;
            });

            database.updateLocation(lat: lat, lng: lng). whenComplete((){
               EdgeAlert.show(context,
                title: 'تنبيه',
                description: '${database.message}',
                icon: Icons.send,
                gravity: EdgeAlert.TOP);
            });

            

            // print(
            //     "loction : ${locationData.latitude} | ${locationData.longitude}");
          }
          
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // debugPrint("Permission Denied");
      }
    }
  }

  void close() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    //  _locationTracker.changeSettings(accuracy: LocationAccuracy.high,distanceFilter: 1000000,interval: 1000000);

    read();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("اغاثة"),
        backgroundColor: Color(0xff06d6a0),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.settings_applications),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        maintainState: true,
                        builder: (context) {
                          return SettingsPage();
                        }));
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

           sendlocation
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'يتم تحديث وارسال المعلومات بعد 50 متر من اخر نقطة ارسلتها ',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  
                )
              : SizedBox(
                  height: 0,
                ),
          sendlocation
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Location: Lat:${lat ?? 0}, Long: ${lng ?? 0}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
                SizedBox(
                  height: 20,
                ),
          Center(
              child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: sendlocation ? Color(0xff06d6a0) : Colors.black)
                ]),
            child: ClipOval(
                child: RaisedButton(
              color: sendlocation ? Color(0xff06d6a0) : Colors.black,
              onPressed: onpressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !sendlocation
                      ? Text(
                          "مغلق",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "مفعل",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                ],
              ),
            )),
          )

              //  NiceButton(
              //   radius: 1000,
              //   padding: const EdgeInsets.all(15),
              //   text: sendlocation ? "ايقاف" : "تشغيل",
              //   icon: !sendlocation ? Icons.location_on : Icons.location_off,
              //   gradientColors: [secondColor, firstColor],
              //   onPressed: onpressed,
              //   background: null,
              // ),
              ),
        ],
      ),
    );
  }
}
