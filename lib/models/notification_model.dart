import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  String pic;
  String title;
  String description;
  var time;
  bool buttonDisable;
  String actionId1;
  String actionId2;
  String subtype;
  String notificationType;
  DocumentReference notificationRef;
  DocumentReference action1Ref;
  DocumentReference action2Ref;

  NotificationsModel(
      {this.description,
      this.title,
      this.time,
      this.pic,
      this.subtype,
      this.actionId1,
      this.actionId2,
      this.buttonDisable = true,
      this.action1Ref,
      this.action2Ref,
      this.notificationRef,
      this.notificationType});
  factory NotificationsModel.fromDocumentSnapShot(DocumentSnapshot doc) =>
      NotificationsModel(
          notificationType: doc.data()['notificationType'],
          subtype: doc.data()['subType'],
          pic: doc.data()["messageData"],
          title: doc.data()["title"],
          description: doc.data()["description"],
          time: doc.data()["time"],
          actionId1: doc.data()['actionId1'],
          action1Ref: doc.data()['action1Ref'],
          action2Ref: doc.data()['action2Ref'],
          actionId2: doc.data()['actionId2'],
          buttonDisable: doc.data()['buttonDisable'],
          notificationRef: doc.reference);

  Map<String, dynamic> toMap() => {
        "pic": pic,
        "title": title,
        "description": description,
        "time": time,
        "actionId1": actionId1,
        "actionId2": actionId2,
        "buttonDisable": buttonDisable,
        "notificationType": notificationType,
        "subType": subtype,
        "action1Ref": action1Ref
      };
}
