import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/api/firebase_api.dart';
import 'package:triumph_life_ui/newappcode/Messaging/model/user.dart';
import 'package:triumph_life_ui/newappcode/Messaging/widget/chat_body_widget.dart';
import 'package:triumph_life_ui/newappcode/Messaging/widget/chat_header_widget.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xffCC9B00),
        body: SafeArea(
          child: StreamBuilder<List<friendss>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final users = snapshot.data;
                    if (users.isEmpty) {
                      return buildText('No Friends Found');
                    } else
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
