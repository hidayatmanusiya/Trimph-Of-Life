import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/models/chat_model.dart';
import 'package:triumph_life_ui/models/message_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/screens/chatDetailPage.dart';

class ChatController extends GetxController {
/* ------------------------------ for chat page ----------------------------- */

/* -------------------------------- variables ------------------------------- */

  bool isFirstMessage = false;
  MessageModel messageData = MessageModel();
  ChatModel chatdata = ChatModel();
  List<MessageModel> messagesList = [];
  List<ChatModel> chatList = [];
  String userid1 = "";
  String messageType = "";
  String userid2 = "";
  String messageBody = "";
  String messagePictureLink = "";
  String messageVideoLink = "";
  List usersList = [];
  bool actionBlocked = false;
/* --------------------------------- queries -------------------------------- */
  var userChat = FirebaseFirestore.instance.collection('Chat');
/* -------------------------------- functions ------------------------------- */

  sendMessage(MessageModel messageData, DocumentReference ref,) async {
    if (!actionBlocked && messageData.messageBody != '') {
      actionBlocked = true;
      ref.collection('Messages').add(messageData.toMap());
      userChat.doc(ref.id).update({
        'lastMessage': messageData.messageBody,
        'lastMeassageTime': messageData.messageTime
      });
      update();
      actionBlocked = false;
      //send Notification
    }
  }

  createNewChat() async {
    MessageModel messageDataTemp = MessageModel();
    ChatModel chatdataTemp = ChatModel();
    chatdataTemp.lastMeassageTime = FieldValue.serverTimestamp();
    chatdataTemp.user1 = userid1;
    chatdataTemp.user2 = userid2;
    chatdataTemp.usersList = [userid1, userid2];

    chatdataTemp.lastMessage = 'hi';
    messageDataTemp.messageBody = 'hi';
    messageDataTemp.messageTime = FieldValue.serverTimestamp();
    messageDataTemp.messageType = 'Text';
    messageDataTemp.senderId = userid1;

    userChat.doc(userid1 + userid2).set(chatdataTemp.toMap());
    userChat
        .doc(userid1 + userid2)
        .collection("Messages")
        .add(messageDataTemp.toMap());
    Get.back();

    isChatAvailable(userid1, userid2);
    // isChatAvailable(userid1, userid2);
    // await getmessageList(userChat.doc(userid1 + userid2));
    // update();
    // print("----Chat created");
  }

  getmessageList(DocumentReference ref) {
    // messagesList.clear();
    // update();
    // ref.collection('').snapshots()
    ref
        .collection('Messages')
        .orderBy('messageTime', descending: true)
        .snapshots()
        .forEach((qSnap) {
      messagesList.clear();
      if (qSnap.size > 0) {
        qSnap.docs.forEach((doc) {
          messagesList.add(MessageModel.fromDocumentSnapShot(doc));
        });
        update();
      }
    });
  }

  getChatList(myId) {
    chatList.clear();
    userChat
        .where('usersList', arrayContains: myId)
        .orderBy('lastMeassageTime', descending: true)
        .snapshots()
        .forEach((qSnap) async {
      if (qSnap.size > 0) {
        chatList.clear();
        qSnap.docs.forEach((doc) {
          chatList.add(ChatModel.fromDocumentSnapshot(doc));
        });
        await getUserDataForChat(myId).then((value) {
          update();
        });
      }
    });
  }

  getUserDataForChat(myId,) async {
    UserModel userDataforChat;
    for (var i = 0; i < chatList.length; i++) {
      var notMyid = chatList[i].usersList[0];
      if (chatList[i].usersList[0] == myId) {
        notMyid = chatList[i].usersList[1];
      }
      var doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(notMyid)
          .get();

      userDataforChat = UserModel.fromDocumentSnapshot(doc);
      chatList[i].chatheading =
          userDataforChat.firstName + "" + userDataforChat.lastName;
      chatList[i].profileLink = userDataforChat.profilePhoto;

      update();
    }
  }

  getSpecificUserData(id) async {
    var doc =
        await FirebaseFirestore.instance.collection("Users").doc(id).get();
    return UserModel.fromDocumentSnapshot(doc);
  }

  isChatAvailable(userId1, userId2) async {
    userid1 = userId1;
    userid2 = userId2;
    userChat
        .where('user1', isEqualTo: userId1)
        .where('user2', isEqualTo: userId2)
        .get()
        .then((docSnap) async {
      if (docSnap.size > 0) {
        print('Chat is Available');
        chatdata = ChatModel.fromDocumentSnapshot(docSnap.docs[0]);
        UserModel userData = await getSpecificUserData(userid2);
        chatdata.profileLink = userData.profilePhoto;
        chatdata.chatheading = userData.firstName + userData.lastName;
        getmessageList(docSnap.docs[0].reference);
        isFirstMessage = false;
        Get.to(ChatDetailPage(
          chatdata: chatdata,
        ));
        update();
        // open messagelist and pass chat id
      } else {
        userChat
            .where('user1', isEqualTo: userId2)
            .where('user2', isEqualTo: userId1)
            .get()
            .then((docSnap) async {
          if (docSnap.size > 0) {
            print('Chat is Available');
            chatdata = ChatModel.fromDocumentSnapshot(docSnap.docs[0]);
            UserModel userData = await getSpecificUserData(userid2);
            chatdata.profileLink = userData.profilePhoto;
            chatdata.chatheading = userData.firstName + userData.lastName;
            getmessageList(docSnap.docs[0].reference);
            isFirstMessage = false;
            Get.to(ChatDetailPage(
              chatdata: chatdata,
            ));
            update();
          } else {
            isFirstMessage = true;
            Get.to(ChatDetailPage());
            update();
            //go for new chat
          }
        });
      }
    });
  }
}
