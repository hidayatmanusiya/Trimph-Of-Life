import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/screens/chatDetailPage.dart';

conversationList({
  chatData,
  String name,
  String messageText,
  String imageUrl,
  String time,
  bool isMessageRead,
  bool isGroupChat,
}) {
  ChatController chatController = Get.put(ChatController());
  return GestureDetector(
    onTap: () {
      chatController.getmessageList(chatData.ref);
      Get.to(ChatDetailPage(
        chatdata: chatData,
      ));
    },
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  maxRadius: 30,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          messageText,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isMessageRead ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    ),
  );
}
