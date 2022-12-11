import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/model/user.dart';
import 'package:triumph_life_ui/newappcode/Messaging/widget/messages_widget.dart';
import 'package:triumph_life_ui/newappcode/Messaging/widget/new_message_widget.dart';
import 'package:triumph_life_ui/newappcode/Messaging/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final friendss user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xffCC9B00),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.user.user_id),
                ),
              ),
              NewMessageWidget(idUser: widget.user.user_id)
            ],
          ),
        ),
      );
}
