import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.firstName,
      this.userId,
      this.email,
      this.dob,
      this.gender,
      this.profilePhoto,
      this.coverPhoto,
      this.country,
      this.joinOn,
      this.lastName,
      this.profession,
      this.state,
      this.refrence,
      this.token,
      this.groupPhoto
      });

  String firstName;
  String lastName;
  String userId;
  String email;
  String dob;
  String gender = 'Male';
  String profilePhoto;
  String coverPhoto;
  String groupPhoto;
  DocumentReference refrence;
  var joinOn;
  String country;
  String state;
  String profession;
  String token;

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) => UserModel(
      groupPhoto:doc.data()["GroupPhoto"],
      firstName: doc.data()["FirstName"],
      userId: doc.data()["UserId"],
      email: doc.data()["Email"],
      dob: doc.data()["DOB"],
      gender: doc.data()["Gender"],
      profilePhoto: doc.data()["ProfilePhoto"],
      coverPhoto: doc.data()["CoverPhoto"],
      country: doc.data()["Country"],
      joinOn: doc.data()["JoinOn"],
      lastName: doc.data()["LastName"],
      profession: doc.data()["Profession"],
      state: doc.data()["State"],
      refrence: doc.reference,
      token:doc.data()["token"],
      );

  Map<String, dynamic> toMap() => {
        "GroupPhoto":groupPhoto,
        "FirstName": firstName,
        "UserId": userId,
        "Email": email,
        "DOB": dob,
        "Gender": gender,
        "ProfilePhoto": profilePhoto,
        "CoverPhoto": coverPhoto,
        "State": state,
        "Profession": profession,
        "LastName": lastName,
        "JoinOn": joinOn,
        "Country": country,
        "token":token,
      };
}
