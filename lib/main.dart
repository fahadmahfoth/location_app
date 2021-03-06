
import 'package:flutter/material.dart';
import 'package:locationapp/view/home_view.dart';
import 'package:locationapp/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';



void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    print("Native called background task: "); //simpleTask will be emitted here.
    return Future.value(true);
  });
}



void main() {

WidgetsFlutterBinding.ensureInitialized();
 

  
  Workmanager.initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: false,

     // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
   
  Workmanager.registerOneOffTask("1", "simpleTask",); //Android only (see below)
  runApp(App());
}




class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

    var isLoged = false;


  
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    final value = prefs.get(key) ?? 0;
    if (value != 0) {
      setState(() {
        isLoged = true;
      });

      return value;
    }
  }

  @override
  void initState() {
    super.initState();
    read();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
       
      darkTheme: ThemeData(                           // New
        brightness: Brightness.dark,                  // New
      ), 
          title: 'تطبيق التعقب', 
          theme: ThemeData.light(),
        home: !isLoged? LoginPage():HomeView());
  }
}


