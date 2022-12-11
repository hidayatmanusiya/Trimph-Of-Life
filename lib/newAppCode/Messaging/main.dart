import 'package:triumph_life_ui/newappcode/Messaging/api/firebase_api.dart';
import 'package:triumph_life_ui/newappcode/Messaging/page/chat_page.dart';
import 'package:triumph_life_ui/newappcode/Messaging/page/chats_page.dart';
import 'package:triumph_life_ui/newappcode/Messaging/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp_ extends StatelessWidget {
  static final String title = 'Firebase Chat';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: ChatsPage(),
      );
}
