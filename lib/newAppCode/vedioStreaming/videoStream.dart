import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:triumph_life_ui/newappcode/vedioStreaming/CallPage.dart';
import 'package:triumph_life_ui/tabs/home_tab.dart';

class VideoStream extends StatefulWidget {
  @override
  _VideoStreamState createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final myController = TextEditingController();
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.25,
                  child: MaterialButton(

                    onPressed:onJoin,
                    height: 40,
                    color: Color(0xffCC9B00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Live',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context)=>HomeTab(),));

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => CallPage(channelName: 'test'),
    //     ));
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
  }
}

