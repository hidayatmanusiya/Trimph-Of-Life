import 'package:cloud_firestore/cloud_firestore.dart';

class StreamerModel {
  StreamerModel({
    this.id,
    this.pic,
    this.name,
    this.status,
  });

  String id;
  String pic;
  String name;
  String status;

  factory StreamerModel.fromDocumentSnapShot(DocumentSnapshot doc) =>
      StreamerModel(
        id: doc.data()["id"],
        pic: doc.data()["Pic"],
        name: doc.data()["name"],
        status: doc.data()["Status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Pic": pic,
        "name": name,
        "Status": status,
      };
}
