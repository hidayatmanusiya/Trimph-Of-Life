import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  ChatModel(
      {this.usersList,
      this.user1,
      this.user2,
      this.isGroupChat,
      this.chatProfile, //ya chat profie kya kr rhi? kb sy och rhu hu
      this.lastMessage,
      this.lastMeassageTime,
      this.chatheading,
      this.profileLink,
      this.ref});

  List usersList;
  String user1;
  String user2;
  bool isGroupChat;
  String chatProfile;
  String lastMessage;
  var lastMeassageTime;
  DocumentReference ref;
  String chatheading;
  String profileLink;

  factory ChatModel.fromDocumentSnapshot(DocumentSnapshot doc) => ChatModel(
      usersList: doc.data()["usersList"],
      user1: doc.data()["user1"],
      user2: doc.data()["user2"],
      isGroupChat: doc.data()["isGroupChat"],
      chatProfile: doc.data()["chatProfile"],
      lastMessage: doc.data()["lastMessage"],
      lastMeassageTime: doc.data()["lastMeassageTime"],
      ref: doc.reference);

  Map<String, dynamic> toMap() => {
        "usersList": usersList,
        "user1": user1,
        "user2": user2,
        "isGroupChat": isGroupChat,
        "chatProfile": chatProfile,
        "lastMessage": lastMessage,
        "lastMeassageTime": lastMeassageTime,
      };
}
