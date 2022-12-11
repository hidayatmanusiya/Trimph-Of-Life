import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/Controller/message_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/chat_model.dart';
import 'package:triumph_life_ui/models/message_model.dart';

class ChatDetailPage extends StatefulWidget {
  final ChatModel chatdata;

  ChatDetailPage({this.chatdata});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  DateTime now = DateTime.now();
  MessageModel messageModel = MessageModel();

  UserController userController = Get.put(UserController());
  MessageController messageController = Get.put(MessageController());
  ChatModel chatModel = ChatModel();

  TextEditingController chatTextController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (_) {
        return Scaffold(
          appBar: chatController.isFirstMessage
              ? null
              : AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  flexibleSpace: SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.chatdata.profileLink ?? ''),
                            maxRadius: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.chatdata.chatheading ?? '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                // SizedBox(
                                //   height: 6,
                                // ),
                                // Text(
                                //   "Tariq",
                                //   style: TextStyle(
                                //       color: Colors.grey.shade600, fontSize: 13),
                                // ),
                              ],
                            ),
                          ),
                          // Icon(
                          //   Icons.settings,
                          //   color: Colors.black54,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
          body: _.isFirstMessage
              ? Center(
                  child: InkWell(
                    onTap: () {
                      // call creat chat function
                      _.createNewChat();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Say hi to start Messge"),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: _.messagesList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = _.messagesList[index];
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (data.senderId !=
                                      userController.userData.userId
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (data.senderId !=
                                          userController.userData.userId
                                      ? Colors.grey.shade200
                                      : Colors.blue[200]),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  data.messageBody,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      // height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     height: 30,
                            //     width: 30,
                            //     decoration: BoxDecoration(
                            //       color: Colors.lightBlue,
                            //       borderRadius: BorderRadius.circular(30),
                            //     ),
                            //     child: Icon(
                            //       Icons.add,
                            //       color: Colors.white,
                            //       size: 20,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                maxLines: null,
                                controller: chatTextController,
                                decoration: InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                onPressed: () {
                                  addMessage();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  addMessage() {
    messageModel.messageBody = chatTextController.text;
    messageModel.messageTime = FieldValue.serverTimestamp();
    messageModel.senderId = userController.userData.userId;
    messageModel.messageType = "Text";
    chatController.sendMessage(messageModel, widget.chatdata.ref);
    chatTextController.text = '';
  }
}
