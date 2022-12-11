import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  GroupModel(
      {this.groupName,
      this.description,
      this.privacy,
      this.gropProfile,
      this.createdby,
      this.admins,
      this.createdOn,
      this.rules,
      this.shareGroupPosts,
      this.sharePostsInGroup,
      this.members,
      this.groupRef});

  String groupName;
  String description;
  String privacy;
  String gropProfile;
  String createdby;
  List admins;
  var createdOn;
  String rules;
  bool shareGroupPosts;
  bool sharePostsInGroup;
  List members;

  DocumentReference groupRef;
  factory GroupModel.fromDocumentSnapShot(DocumentSnapshot doc) => GroupModel(
      groupName: doc.data()["groupName"],
      description: doc.data()["description"],
      privacy: doc.data()["privacy"],
      gropProfile: doc.data()["gropProfile"],
      createdby: doc.data()["createdby"],
      admins: doc.data()["admins"],
      createdOn: doc.data()["createdOn"],
      rules: doc.data()["rules"],
      shareGroupPosts: doc.data()["shareGroupPosts"],
      sharePostsInGroup: doc.data()["sharePostsInGroup"],
      groupRef: doc.reference);

  Map<String, dynamic> toMap() => {
        "groupName": groupName,
        "description": description,
        "privacy": privacy,
        "gropProfile": gropProfile,
        "createdby": createdby,
        "admins": admins,
        "createdOn": createdOn,
        "rules": rules,
        "shareGroupPosts": shareGroupPosts,
        "sharePostsInGroup": sharePostsInGroup,
      };
}
