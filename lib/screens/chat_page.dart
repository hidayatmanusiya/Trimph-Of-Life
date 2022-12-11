import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/widgets/chat_widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ChatPage"),
        ),
        body: GetBuilder<ChatController>(
          builder: (_) {
            return Container(
              height: Get.height,
              // width: Get.width,
              child: ListView.builder(
                itemCount: _.chatList.length,
                // shrinkWrap: true,
                // padding: EdgeInsets.only(top: 16),
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = _.chatList[index];
                  return conversationList(
                    chatData: data,
                    name: data.chatheading ?? '',
                    messageText: data.lastMessage,
                    imageUrl: data.profileLink ?? '',
                    time: DateFormat('d MMM yy, h:mm:a')
                        .format(data.lastMeassageTime.toDate())
                        .toString(),
                    isMessageRead: false,
                  );
                },
              ),
            );
          },
        ));
  }
}
