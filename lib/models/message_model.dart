import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel(
      {this.messageBody,
      this.senderId,
      this.messageTime,
      this.messageType,
      this.messagePictureLink,
      this.messageVideoLink,
      this.ref});

  String messageBody;
  String senderId;
  var messageTime;
  String messageType;
  String messagePictureLink;
  String messageVideoLink;
  DocumentReference ref;
  factory MessageModel.fromDocumentSnapShot(DocumentSnapshot doc) =>
      MessageModel(
          messageBody: doc.data()["messageBody"],
          senderId: doc.data()["senderId"],
          messageTime: doc.data()["messageTime"],
          messageType: doc.data()["messageType"],
          messagePictureLink: doc.data()["messagePictureLink"],
          messageVideoLink: doc.data()["messageVideoLink"],
          ref: doc.reference);

  Map<String, dynamic> toMap() => {
        "messageBody": messageBody,
        "senderId": senderId,
        "messageTime": messageTime,
        "messageType": messageType,
        "messagePictureLink": messagePictureLink,
        "messageVideoLink": messageVideoLink,
      };
}
