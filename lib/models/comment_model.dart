import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  CommentModel({
    this.userId,
    this.userphoto,
    this.userName,
    this.comment,
    this.time,
    this.ref,
  });

  String userId;
  String userphoto;
  String userName;
  String comment;
  var time;
  DocumentReference ref;

  factory CommentModel.fromDocumentSnapShot(DocumentSnapshot doc) =>
      CommentModel(
          userId: doc.data()["UserId"],
          userphoto: doc.data()["Userphoto"],
          userName: doc.data()["UserName"],
          comment: doc.data()["Comment"],
          time: doc.data()["time"],
          ref: doc.reference);

  Map<String, dynamic> toMap() => {
        "UserId": userId,
        "Userphoto": userphoto,
        "UserName": userName,
        "Comment": comment,
        "time": time,
      };
}
