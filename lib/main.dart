
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/HomeScreen.dart';

//import 'package:triumph_life_ui/newappcode/Start/Login.dart';
import 'package:triumph_life_ui/SignupScreen.dart';
import 'package:triumph_life_ui/newappcode/Start/Login.dart';

import 'constant_functions.dart';
import 'newappcode/Messaging/api/firebase_api.dart';
import 'newappcode/Messaging/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp().then((_) {

    runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        )
    );
  });

  // await  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser;
    // print("FirstSifat : user-id :  $userId");
    // print("FirstSifat : user-email :  ${userId.email}");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Triumph of Life',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        // Agora()
        splashScreen(),
        builder: EasyLoading.init()

      // home: MyHomePage(),

    );
  }
}



class splashScreen extends StatefulWidget{
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  UserController userController = Get.put(UserController());
  Color changeColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.white;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    userController.clearForm();

    Timer(Duration(seconds: 2),() {Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context)=>LoginScreen(),));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color(0xff8C6B00),
      body: Container(
        decoration:BoxDecoration(
          image:DecorationImage(
            scale: 1.0,
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext  context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

