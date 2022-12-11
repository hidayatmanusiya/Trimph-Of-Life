import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel(
      {this.createdDate,
      this.date,
      this.title,
      this.description,
      this.totalGoing,
      this.totalIntrested,
      this.totalShares,
      this.createdBy,
      this.location,
      this.isTime,
      this.going,
      this.intrested,
      this.ref});

  var createdDate;
  String createdBy;
  String location;
  var date;
  bool isTime;
  String title;
  String description;
  int totalGoing;
  int totalIntrested;
  DocumentReference ref;
  int totalShares;
  List going;
  List intrested;

  factory EventModel.documentSnapshots(DocumentSnapshot doc) => EventModel(
      createdDate: doc.data()["createdDate"],
      date: doc.data()["date"],
      title: doc.data()["title"],
      description: doc.data()["description"],
      totalGoing: doc.data()["totalGoing"],
      totalIntrested: doc.data()["totalIntrested"],
      totalShares: doc.data()["totalShares"],
      location: doc.data()['location'],
      createdBy: doc.data()['createdBy'],
      isTime: doc.data()['isTime'],
      ref: doc.reference);

  Map<String, dynamic> toMap() => {
        "createdDate": createdDate,
        "date": date,
        "title": title,
        "createdBy": createdBy,
        "location": location,
        "description": description,
        "totalGoing": totalGoing,
        "totalIntrested": totalIntrested,
        "totalShares": totalShares,
        "isTime": isTime
      };
}
