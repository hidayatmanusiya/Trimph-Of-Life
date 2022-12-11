import 'dart:io';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import '../newappcode/Api/login_api.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import '../newappcode/Api/signup_api.dart';
import '../newappcode/Api/uploadProfilePicture_api.dart';
import '../newappcode/screens/homeScreen.dart';
import '../screens/ChoosePhotoScreen.dart';
import '../newappcode/User/globalUser.dart' as globals;

class UserController extends GetxController {

  /*-------------------controllers-------------------------------------*/
  Loader loader = Get.put(Loader());

/* -------------------------------- variables ------------------------------- */

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 6570));
  String currentUserId;
  bool isPicUpload;
  File coverPhoto;
  File profilePhoto;
  File groupPhoto;
  SharedPreferences user;
  String gender = 'Male';
  UserModel userData = UserModel();
  List requestSentList = [];
  List friendRequestList = [];
  List friendsList = [];
  List blockedList = [];
  List myGroups = [];
  List myGroupsInvitations = [];
  List myGroupsRequests = [];
  String errorMessage = '';
  String token = "";
  SharedPreferences user2;
  int id;

/* -------------------------------- page data ------------------------------- */
  final formKeySignUp = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController signUpemailController = TextEditingController();
  TextEditingController signUppasswordController = TextEditingController();
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  ArsProgressDialog progressDialog;
/* -------------------------------- functions ------------------------------- */

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  clearForm() {
    errorMessage = '';
    firstNameController.text = '';
    lastNameController.text = '';
    signUpemailController.text = '';
    signUppasswordController.text = '';
    loginemailController.text = '';
    loginemailController.text = '';
    countryController.text = '';
    stateController.text = '';
    professionController.text = '';
    userData.dob = null;
  }

/* -------------------------- get current user Data ------------------------- */

  Future getData() async {
    userData = UserModel();

    var userId = firebaseAuth.currentUser.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Users")
        .doc(userId)
        .get()
        .then((value) => userData = UserModel.fromDocumentSnapshot(value));
    clearUserData();
    getAdditionalData();
    update();
  }

  Future<UserModel> getSpecificUserData(UserModel userData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docs = await firestore.collection("Users").doc(userData.userId).get();

    if (docs.exists) {
      return userData = UserModel.fromDocumentSnapshot(docs);
    } else {
      return null;
    }
  }

  getAdditionalData() {
    getFriendRequest();
    getFriends();
    getRequestSent();
    getMyGroups();
    getMyGroupsInvitation();
    getMyGroupsRequests();
  }

/* ----------------------------- clear user data ---------------------------- */
  clearUserData() {
    friendRequestList.clear();
    friendsList.clear();
    requestSentList.clear();
    myGroups.clear();
  }

/* --------------------------- get requestes sents -------------------------- */

  getRequestSent() {
    userData.refrence
        .collection('RequestSent')
        .doc('RSent' + userData.userId) // ha voho
        .get()
        .then((dSnap) {
      if (dSnap.exists) {
        requestSentList = dSnap.data()['List'];
      }
    });
  }

/* --------------------------- get friends request -------------------------- */

  getFriendRequest() {
    userData.refrence
        .collection('FriendRequests')
        .doc('FRequest' + userData.userId)
        .snapshots() // acha
        .forEach((dSnap) {
      if (dSnap.exists) {
        friendRequestList.clear();
        friendRequestList = dSnap.data()['List'];
      }
    });
  }

/* ----------------------------- get all friends ---------------------------- */

  getFriends() async {
    userData.refrence
        .collection('Friends')
        .doc('Friend' + userData.userId)
        .snapshots()
        .forEach((dSnap) {
      if (dSnap.exists) {
        friendsList.clear();
        friendsList = dSnap.data()['List'];
      }
    });
  }

/* ---------------------------- get all my groups --------------------------- */

  getMyGroups() async {
    userData.refrence
        .collection('Groups')
        .doc('Groups' + userData.userId)
        .snapshots()
        .forEach((dSnap) {
      if (dSnap.exists) {
        myGroups.clear();
        myGroups = dSnap.data()['List'];
      }
    });
  }

  getMyGroupsInvitation() async {
    userData.refrence
        .collection('GroupsInvitations')
        .doc('Groups' + userData.userId)
        .snapshots()
        .forEach((dSnap) {
      if (dSnap.exists) {
        myGroupsInvitations.clear();
        myGroupsInvitations = dSnap.data()['List'];
      }
    });
  }

  getMyGroupsRequests() async {
    userData.refrence
        .collection('GroupsRequests')
        .doc('Groups' + userData.userId)
        .snapshots()
        .forEach((dSnap) {
      if (dSnap.exists) {
        myGroupsRequests.clear();
        myGroupsRequests = dSnap.data()['List'];
      }
    });
  }

/* ------------------------- update token of device ------------------------- */

  Future updateToken(String uid) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.subscribeToTopic("Topic");
    String token = await firebaseMessaging.getToken();
    firebaseFirestore
        .collection('Users')
        .doc(uid)
        .update({"token": token}).then((value) {
      loader.loadingDismiss();
      update();
      Get.to(homeScreen());
    });
  }

/* --------------------------------- sign in -------------------------------- */

  Future signIn() async {
    user=await SharedPreferences.getInstance();
    String _email = (user.getString('email') ?? '');
    String _pass = (user.getString('pass') ?? '');
    final body = {'sign':"sign", "Email": _email, "Pass": _pass,};
    print(body);
    UserCredential userCredential;
    try {
      loader.loadingShow();
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email:_email,
          password: _pass);
      currentUserId = userCredential.user.uid.toString();
      ApiService_login.login(body).then((success) async {
        //print(success);
        if (success>0) {
          loader.loadingDismiss();
          print("User Controller + ${currentUserId}");
          print("User Controller + ${success}");
          userData.userId=currentUserId;
          userData=await getSpecificUserData(userData);
          print(userData.email);
          print(userData.firstName);

          SharedPreferences user_id=await SharedPreferences.getInstance();
          user_id.setInt('userId', success);
          int id=user_id.getInt('userId');
          print("User Controller + ${id}");
          updateToken(currentUserId);
          Get.to(homeScreen());
          //userController.signIn();

          //   UserCredential userCredential;
          //   String currentUserId;
          //loader.loadingShow();
          // userCredential = await firebaseAuth.signInWithEmailAndPassword(
          // email: email1.text,
          // password: "123456789");
          // currentUserId = userCredential.user.uid.toString();
          //         updateToken(currentUserId);
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => H()));
        }

      });
    } catch (e) {
      print(e.toString());
      errorMessage = e.message;
      loader.loadingDismiss();
      Get.snackbar('Error', e.message);
      update();
    }
  }

  /* ------------------------------ sign up user ------------------------------ */

  signUp() async {
    loader.loadingShow();

    user=await SharedPreferences.getInstance();
    String email_f = (user.getString('email_f') ?? '');
    String password_f = (user.getString('password_f') ?? '');
    String name_f = (user.getString('name_f') ?? '');
    String gender_f = (user.getString('gender_f') ?? '');
    String date_f = (user.getString('date_f') ?? '');
    String country_f = (user.getString('country_f') ?? '');
    String state_f = (user.getString('state_f') ?? '');
    String profession_f = (user.getString('profession_f') ?? '');
    final body = {
      "create": "create",
      "email": email_f.toString(),
      "password": password_f.toString(),
      'name': name_f.toString(),
      "gender": gender_f.toString(),
      'date': date_f,
      // 'date': (selectedDate.day.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.year.toString()).toString(),
      "country": country_f.toString(),
      "state": state_f.toString(),
      'profession': profession_f.toString(),
    };
    final body1 = {'sign':"sign", "Email": email_f, "Pass": password_f,};



    //add data into model object from controller
    userData.firstName = name_f;
    userData.gender = gender_f;
    userData.lastName = name_f;
    userData.email = email_f;
    userData.country = country_f;
    userData.state = state_f;
    userData.profession = profession_f;
    userData.joinOn = FieldValue.serverTimestamp();
    userData.userId = "1";
    // User user = FirebaseAuth.instance.currentUser;
    try {
      var user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email_f, password: password_f);
      currentUserId = user.user.uid.toString();
      // update();
      addUserData().then((val) {
        print("add data");
        ApiService.signup(body).then((success1){
          print("signup api run");
          loader.loadingDismiss();
          ApiService_login.login(body1).then((success) async {
            print("login api run");
            if (success > 0) {
              loader.loadingDismiss();
              print("User Controller + ${currentUserId}");
              userData.userId = currentUserId;
              print("User Controller + ${success}");
              SharedPreferences user_id = await SharedPreferences.getInstance();
              user_id.setInt('userId', success);
              int new1=user_id.getInt('userId');
              print("User Controller + ${new1}");
              updateToken(currentUserId);
              globals.GlobalUserId=success;
              //userController.signIn();
              Get.snackbar('Success', 'Sign up SuccessFully');
              Get.to(ChoosePhotoScreen());
            }
          });
        });
      });
    } catch (e) {
      errorMessage = e.message;
      loader.loadingDismiss();
      update();
      Get.snackbar('Error', e.message);
    }
  }

/* ---------------------- add user data into data base ---------------------- */

  Future addUserData() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.subscribeToTopic("Topic");
    String token = await firebaseMessaging.getToken();
    user=await SharedPreferences.getInstance();
    String email_f = (user.getString('email_f') ?? '');
    String password_f = (user.getString('password_f') ?? '');
    String name_f = (user.getString('name_f') ?? '');
    String gender_f = (user.getString('gender_f') ?? '');
    String date_f = (user.getString('date_f') ?? '');
    String country_f = (user.getString('country_f') ?? '');
    String state_f = (user.getString('state_f') ?? '');
    String profession_f = (user.getString('profession_f') ?? '');

   // if(date_f==null)
      {
        date_f= "23" + "-" + "12" + "-" + "1991";
      }

    FirebaseFirestore.instance.collection('Users').doc(currentUserId).set(
      {
        'FirstName': name_f,
        'Country': country_f,
        'UserId': currentUserId,
        'Email': email_f,
        'DOB': date_f,
        'Gender': gender_f,
        "JoinOn": FieldValue.serverTimestamp(),
        "LastName": name_f,
        "Profession": profession_f,
        "State": state_f,
        "CoverPhoto": "",
        "ProfilePhoto": "",
        "token": token,
      },
    );
    return true;
  }

/* --------------------------- update name of user -------------------------- */

  Future updateName() async {
    loader.loadingShow();
    userData.firstName = firstNameController.text;

    userData.lastName = lastNameController.text;

    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "FirstName": userData.firstName,
      "LastName": userData.lastName,
    }).then((value) {
      loader.loadingDismiss();
      update();
    });

    return true;
  }

/* -------------------------- update info of usere -------------------------- */

  Future updateInfo() async {
    loader.loadingShow();
    userData.country = countryController.text;
    userData.state = stateController.text;
    userData.profession = professionController.text;
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "Country": userData.country,
      "State": userData.state,
      "Profession": userData.profession
    }).then((value) {
      loader.loadingDismiss();
      update();
    });

    return true;
  }

/* ---------------------------- update user form ---------------------------- */

  Future updateForm(String link) async {
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "ProfilePhoto": "$link",
      "CoverPhoto": "$link",
      "FirstName": userData.firstName,
      "LastName": userData.lastName,
      "Country": userData.country,
      "State": userData.state,
      "Profession": userData.profession
    }).then((value) => getData());
    return true;
  }

  Future uploadFileCover() async {
    var userId = firebaseAuth.currentUser.uid;
    loader.loadingShow();
    final firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("CoverPhotos/$userId/CoverPhoto+userId.jpg");

    final firebase_storage.UploadTask uploadTask =
        storageReference.putData(profilePhoto.readAsBytesSync());
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
        return addProfileCover(value);
      });
      update();
    });
  }

  Future uploadFile() async {

    user = await SharedPreferences.getInstance();
    id=user.getInt('userId');
    var userId = firebaseAuth.currentUser.uid;
    loader.loadingShow();
    final firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("ProfilePhotos/$userId/ProfilePhoto+userId.jpg");

    final firebase_storage.UploadTask uploadTask =
        storageReference.putData(profilePhoto.readAsBytesSync());
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        final body={'update':'update','user_id':'$id','pic':value};
        ApiService_uploadProfile.uploadProfilePic(body).then((success){
          if(success){

          }
        });
        print(value);
        return addProfile(value);
      });
      update();
    });
  }

  Future uploadFiles() async {
    var userId = firebaseAuth.currentUser.uid;
    userData.firstName = firstNameController.text;

    userData.lastName = lastNameController.text;

    userData.country = countryController.text;
    userData.state = stateController.text;
    userData.profession = professionController.text;

    final firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("ProfilePhotos/$userId/ProfilePhoto+userId.jpg");

    final firebase_storage.UploadTask uploadTask =
        storageReference.putData(profilePhoto.readAsBytesSync());
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
        update();
        return updateForm(value);
      });
    });
  }

  Future addProfileCover(String link) async {
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "CoverPhoto": "$link",
    }).then((value) => getData());
    loader.loadingDismiss();
    update();
    return true;
  }

  Future addGroupCover(String link) async {
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "GroupPhoto": "$link",
    }).then((value) => getData());
    loader.loadingDismiss();
    update();
    return true;
  }

  Future addProfile(String link) async {
    var userId = firebaseAuth.currentUser.uid;

    await firebaseFirestore.collection('Users').doc(userId).update({
      "ProfilePhoto": "$link",
    }).then((value) => getData());
    loader.loadingDismiss();
    update();
    return true;
  }

  signout() {
    firebaseAuth.signOut();
   // Get.offAll(MyHomePage());
  }
}
