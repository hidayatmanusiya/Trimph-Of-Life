import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:triumph_life_ui/main.dart';

//ya h apka code
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

const TextStyle textStyle = TextStyle(
  color: Colors.white,
);

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double>  animation;

//  onDoneLoading() async {
//    Navigator.of(context).push(
//        MaterialPageRoute(builder: (context) => PhVerification()));
//  }
//  Future<Timer> loadData() async {
//    return new Timer(Duration(seconds: 5), onDoneLoading);
//  }

  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 5),
    //     () => Navigator.of(context).pushReplacement(
    //
    //         MaterialPageRoute(
    //         builder: (BuildContext context) => MyHomePage()))
    //
    // );
    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent : controller, curve: Curves.easeInOutCirc));

    controller.forward();
  }

  final background = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/13.png'),
        fit: BoxFit.cover,
      ),
    ),
  );

  final greenOpacity = Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(0xFF004E75),
          Color(0xFF1385bd),
        ])),
  );

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
//    ]);

    final logo = new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
        position: Tween<Offset>(
            begin: Offset(
              10.0,
              -0.0,
            ),
            end: Offset.zero)
            .animate(CurvedAnimation(
            parent: controller, curve: Curves.easeInOutSine)),
        child: Image.asset(
          'images/12.png',
          width: 180.0,
          height: 180.0,
        ),
      ),
    );
    // final logo = new
    // ScaleTransition(
    //   scale: animation,
    //   child: Image.asset(
    //     'images/12.png',
    //     width: 180.0,
    //     height: 180.0,
    //   ),
    // );

    final description = new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
        position: Tween<Offset>(
            begin: Offset(
              -0.0,
              10.0,
            ),
            end: Offset.zero)
            .animate(CurvedAnimation(
            parent: controller, curve: Curves.easeInOutSine)),
        child: Image.asset(
          'images/13.png',
          width: 180.0,
          height: 180.0,
        ),
      ),
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //greenOpacity,
          //background,

          new SafeArea(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logo,
                  SizedBox(height: 50.0),
                  description,
                  SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
