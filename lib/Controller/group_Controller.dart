import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/group_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';

import 'loading_controller.dart';

class GroupController extends GetxController {
/* -------------------------------- variable -------------------------------- */
  Loader loader = Get.put(Loader());
  NotificationController notificationController =
      Get.put(NotificationController());
  GroupModel groupModel = GroupModel();
  GlobalKey<FormState> groupFormKey = GlobalKey<FormState>();
  UserController userController = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var userFirebase = FirebaseFirestore.instance.collection('Users');

  List<GroupModel> allgroups = [];
  List<UserModel> allAdmins = [];
  List<GroupModel> myGroups = [];
  List<UserModel> group10User = [];
  List<UserModel> groupAllUsers = [];
  List<UserModel> joinRequestMembers = [];
  List invitedMembers = [];
  List alluser = [];

  GroupModel selectedGroup;
  String photolink = '';
  String groupName, description, rules, privacy = 'Public';
  bool sharePostInGroup = true, shareGroupPost = true;
  final Map<String, IconData> data = Map.fromIterables(
      ['Public', 'Secret', 'Private'],
      [Icons.public, Icons.security, Icons.privacy_tip]);
  String selectedType = 'Public';
  IconData selectedIcon;
  // ignore: missing_return
  String groupNameValidator(String val) {
    if (val.length < 4) {
      return "Group name should be atleast 4 digit long";
    }
  }

  File groupPhoto;
  refreshData() {
    getMyGroups();
    getAllGroups();
  }

/* ------------------------------ create group ------------------------------ */
  createGroup() async {
    if (groupFormKey.currentState.validate()) {
      groupFormKey.currentState.save();
      loader.loadingShow();
      if (groupPhoto != null) {
        await uploadGroupPhoto();
      }
      groupModel.groupName = groupName;
      groupModel.admins = [userController.userData.userId];
      groupModel.createdby = userController.userData.userId;
      groupModel.createdOn = FieldValue.serverTimestamp();
      groupModel.description = description;
      groupModel.gropProfile = photolink;
      groupModel.privacy = selectedType;
      groupModel.rules = rules;
      groupModel.shareGroupPosts = shareGroupPost;
      groupModel.sharePostsInGroup = sharePostInGroup;
      groupModel.members = [userController.userData.userId];
      var _groupRef =
          await firebaseFirestore.collection('Groups').add(groupModel.toMap());
      userController.myGroups.add(_groupRef.id);
      userController.userData.refrence
          .collection("Groups")
          .doc('Groups' + userController.userData.userId)
          .set({'List': userController.myGroups});
      _groupRef.collection('Members').doc('memberList').set({
        'List': [userController.userData.userId]
      });
      // _groupRef.collection('Members').doc('info').set({'TotalLists': 1});
      refreshData();
      loader.loadingDismiss();
      Get.back();
      Get.snackbar('Group Created', 'Group Created successfully');
      update();
    }
  }

/* ------------------------------- join group ------------------------------- */
  joinGroup(GroupModel groupDetails) async {
    loader.loadingShow();
    if (groupDetails.privacy == 'Public') {
      var groupMember = [];
      groupMember = await getGroupMember(groupDetails);
      userController.myGroups.add(groupDetails.groupRef.id);
      userController.userData.refrence
          .collection("Groups")
          .doc('Groups' + userController.userData.userId)
          .set({'List': userController.myGroups});
      groupMember.add(userController.userData.userId);
      groupDetails.groupRef
          .collection('Members')
          .doc('memberList')
          .set({'List': groupMember});

/* --------------------------------- private -------------------------------- */

    } else if (groupDetails.privacy == 'Private') {
      var grouJoinRequests = [];
      grouJoinRequests = await getGroupJoinRequests(groupDetails);
      userController.myGroupsRequests.add(groupDetails.groupRef.id);
      userController.userData.refrence
          .collection("GroupsRequests")
          .doc('Groups' + userController.userData.userId)
          .set({'List': userController.myGroupsRequests});
      grouJoinRequests.add(userController.userData.userId);
      groupDetails.groupRef
          .collection('JoinRequests')
          .doc('memberList')
          .set({'List': grouJoinRequests});
    }
    refreshData();
    loader.loadingDismiss();
  }

/* -------------------------- get all group Member -------------------------- */
  Future getGroupMember(GroupModel groupDetails) async {
    List memberList = [];
    var doc = await groupDetails.groupRef
        .collection('Members')
        .doc('memberList')
        .get();
    if (doc.exists) {
      memberList = doc.data()['List'];
    }
    return memberList;
  }

/* ------------------------- get group join requests ------------------------ */

  Future getGroupJoinRequests(GroupModel groupDetails) async {
    List memberList = [];
    var doc = await groupDetails.groupRef
        .collection('JoinRequests')
        .doc('memberList')
        .get();
    if (doc.exists) {
      memberList = doc.data()['List'];
    }
    return memberList;
  }

/* ---------------------- get all user who are invited ---------------------- */

  Future getGroupInvited(GroupModel groupDetails) async {
    List memberList = [];
    var doc = await groupDetails.groupRef
        .collection('InvitedMembers')
        .doc('memberList')
        .get();
    if (doc.exists) {
      memberList = doc.data()['List'];
    }
    return memberList;
  }

/* -------------------------- accept group request -------------------------- */

/* ----------------------------- check my groups ---------------------------- */

/* ------------------------------ group status ------------------------------ */

/* ------------------------------share post in group ----------------------------- */

/* ---------------------------- share group post ---------------------------- */

/* ------------------------------- veiw member ------------------------------ */
  getGroup10Members() async {
    List userIdList = await getGroupMember(selectedGroup);
    group10User.clear();
    for (int i = 0; i < 10; i++) {
      if (userIdList.length > i) {
        userFirebase.doc(userIdList[i]).get().then((dSnap) {
          if (dSnap.exists) {
            group10User.add(UserModel.fromDocumentSnapshot(dSnap));
          }
          update();
        });
      }
    }
  }

  getGroupAllMembers() async {
    List userIdList = await getGroupMember(selectedGroup);
    groupAllUsers.clear();
    update();
    for (int i = 0; i < userIdList.length; i++) {
      userFirebase.doc(userIdList[i]).get().then((dSnap) {
        if (dSnap.exists) {
          groupAllUsers.add(UserModel.fromDocumentSnapshot(dSnap));
        }
        update();
      });
    }
  }

/* ------------------------------- upload pic ------------------------------- */
  Future uploadGroupPhoto() async {
    var userId = firebaseAuth.currentUser.uid;

    final firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("GroupPhotos/$userId/GroupPhoto+userId.jpg");

    final firebase_storage.UploadTask uploadTask =
        storageReference.putData(groupPhoto.readAsBytesSync());
    await uploadTask.whenComplete(() async {
      return photolink = await storageReference.getDownloadURL();
      // print(photolink);

      // update();
    });
  }

/* ----------------------------pick image from galery --------------------------- */

  imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      groupPhoto = File(pickedFile.path);
      update();
    }
  }

/* ------------------------------ getAllGroups ------------------------------ */
  getAllGroups() async {
    var qSnap = await firebaseFirestore
        .collection("Groups")
        .where('privacy', isNotEqualTo: 'Secret')
        .get();
    allgroups = [];
    if (qSnap.size > 0) {
      qSnap.docs.forEach((doc) {
        allgroups.add(GroupModel.fromDocumentSnapShot(doc));
      });
      update();
    }
  }

/* ------------------------------- getMyGroups ------------------------------ */
  getMyGroups() async {
    myGroups.clear();
    for (var i = 0; i < userController.myGroups.length; i++) {
      var doc = await firebaseFirestore
          .collection("Groups")
          .doc(userController.myGroups[i])
          .get();
      if (doc.exists) {
        myGroups.add(GroupModel.fromDocumentSnapShot(doc));
      }
    }
    update();
  }

/* ---------------------------- check conditions ---------------------------- */
  isUserPresentInGroup(groupId) {
    return userController.myGroups.contains(groupId);
  }

  isUserSendRequest(groupId) {
    return userController.myGroupsRequests.contains(groupId);
  }

  isUserInvitedForGroup(groupId) {
    return userController.myGroupsInvitations.contains(groupId);
  }

  checkUserForInvitation(UserModel userData) async {
    List _userIdList = await getGroupMember(selectedGroup);
    List _invitedList = await getGroupInvited(selectedGroup);
    if ((_userIdList.contains(userData.userId)) ||
        _invitedList.contains(userData.userId)) {
      Get.snackbar(
          'Can not invite', 'User already present in group are invited');
    } else {
      inviteUser(userData);
    }
  }

/* -------------------------------- add admin ------------------------------- */
  addAdmin(UserModel userData) {
    List _admins = selectedGroup.admins;
    _admins.add(userData.userId);
    selectedGroup.groupRef.update({'admins': _admins});
    notificationController.sendPushnotification(
      token: userData.token,
      title: "Admin",
      body: "You are now Admin of ${selectedGroup.groupName}",
      userName: '',
    );
    notificationController.insertNotification(
      ref: userData.refrence,
      actionRef: selectedGroup.groupRef,
      buttondisable: true,
      subtype: 'Make Admin',
      type: 'Group',
      body: 'You are now Admin of ${selectedGroup.groupName}',
    );
    update();
  }

/* ------------------------------ remove admin ------------------------------ */
  removeAdmin(UserModel userData) {
    if (userData.userId != selectedGroup.createdby) {
      List _admins = selectedGroup.admins;
      _admins.removeWhere((element) => element == userData.userId);
      selectedGroup.groupRef.update({'admins': _admins});

      update();
    } else {
      Get.snackbar('Error', 'You Can not remove group Creater',
          backgroundColor: Colors.red.withOpacity(0.7));
    }
  }

/* ---------------------------- get group admins ---------------------------- */
  getGroupAdmins() async {
    allAdmins.clear();
    for (int i = 0; i < selectedGroup.admins.length; i++) {
      userFirebase.doc(selectedGroup.admins[i]).get().then((dSnap) {
        if (dSnap.exists) {
          allAdmins.add(UserModel.fromDocumentSnapshot(dSnap));
        }
        update();
      });
    }
  }

  getJoinRequestMembers() async {
    List userIdList = await getGroupJoinRequests(selectedGroup);
    joinRequestMembers.clear();
    update();
    for (int i = 0; i < userIdList.length; i++) {
      userFirebase.doc(userIdList[i]).get().then((dSnap) {
        if (dSnap.exists) {
          joinRequestMembers.add(UserModel.fromDocumentSnapshot(dSnap));
        }
        update();
      });
    }
  }

  acceptJoinRequest(UserModel userData) async {
    List groupJoinRequests = [];
    List userJoinrequest = [];
    List userGroup = [];
    List groupMember = [];
//get all join requests
    groupJoinRequests = await getGroupJoinRequests(selectedGroup);
// get group member
    groupMember = await getGroupMember(selectedGroup);
    // get user join requests
    userJoinrequest = await getUserRequestGroup(userData);
// get user groups
    userGroup = await getUserGroup(userData);
    //get user groups
    userJoinrequest
        .removeWhere((element) => element == selectedGroup.groupRef.id);
    groupJoinRequests.removeWhere((element) => element == userData.userId);
    userGroup.add(selectedGroup.groupRef.id);
    groupMember.add(userData.userId);
// update group members
    selectedGroup.groupRef
        .collection('Members')
        .doc('memberList')
        .set({'List': groupMember});
// update user groups
    userData.refrence
        .collection("Groups")
        .doc('Groups' + userData.userId)
        .set({'List': userGroup});
// update  user group requests
    userData.refrence
        .collection("GroupsRequests")
        .doc('Groups' + userData.userId)
        .set({'List': userJoinrequest});
// update group requests
    selectedGroup.groupRef
        .collection('JoinRequests')
        .doc('memberList')
        .set({'List': groupJoinRequests});
    joinRequestMembers.removeWhere((element) => element == userData);
    notificationController.sendPushnotification(
      token: userData.token,
      title: "Joined",
      body: "Your request to join ${selectedGroup.groupName} is accepted",
      userName: '',
    );
    notificationController.insertNotification(
      ref: userData.refrence,
      actionRef: selectedGroup.groupRef,
      buttondisable: true,
      subtype: 'Request Accept',
      type: 'Group',
      body: 'Your request to join ${selectedGroup.groupName} is accepted',
    );
    update();
  }

  getUserGroup(UserModel userData) async {
    List _list = [];
    var data = await userData.refrence
        .collection('Groups')
        .doc('Groups' + userData.userId)
        .get();

    if (data.exists) {
      _list = data.data()['List'];
    }

    return _list;
  }

  getUserRequestGroup(UserModel userData) async {
    List _list = [];
    var data = await userData.refrence
        .collection('GroupsRequests')
        .doc('Groups' + userData.userId)
        .get();

    if (data.exists) {
      _list = data.data()['List'];
    }

    return _list;
  }

/* ------------------------------ invite a user ----------------------------- */
  inviteUser(UserModel userData) async {
    List _userInvitation = [];
    List _groupInvitation = [];
    // get list of all group that invited this user
    var dSnap = await userData.refrence
        .collection('GroupsInvitations')
        .doc('Groups' + userData.userId)
        .get();
    if (dSnap.exists) {
      _userInvitation = dSnap.data()['List'];
    }
    //get ivitation list (invited users )of a group

    var doc = await selectedGroup.groupRef
        .collection('InvitedMembers')
        .doc('memberList')
        .get();
    if (doc.exists) {
      _groupInvitation = doc.data()['List'];
    }
    // add data in user and group invitation list
    _groupInvitation.add(userData.userId);
    _userInvitation.add(selectedGroup.groupRef.id);
    // update group invited list
    selectedGroup.groupRef
        .collection('InvitedMembers')
        .doc('memberList')
        .set({'List': _groupInvitation});
    // update user invitationlist
    userData.refrence
        .collection('GroupsInvitations')
        .doc('Groups' + userData.userId)
        .set({'List': _userInvitation});
    notificationController.sendPushnotification(
      token: userData.token,
      title: "Invitation",
      body:
          "${userController.userData.firstName} ${userController.userData.lastName} invite you to join ${selectedGroup.groupName}",
      userName: '',
    );
    notificationController.insertNotification(
      ref: userData.refrence,
      actionRef: selectedGroup.groupRef,
      buttondisable: false,
      subtype: 'Invite',
      type: 'Group',
      body:
          "${userController.userData.firstName} ${userController.userData.lastName} invite you to join ${selectedGroup.groupName}",
    );
    update();
  }

/* ------------------------- user accept invitation ------------------------- */

  userAcceptInvitation(GroupModel groupData) async {
    List _userInvitation = [];
    List _groupInvitation = [];
    var _groupMember = [];
    // get all group that invite user
    var dSnap = await userController.userData.refrence
        .collection('GroupsInvitations')
        .doc('Groups' + userController.userData.userId)
        .get();
    if (dSnap.exists) {
      _userInvitation = dSnap.data()['List'];
    }
    // get list of member invited to this group
    var doc = await groupData.groupRef
        .collection('InvitedMembers')
        .doc('memberList')
        .get();
    if (doc.exists) {
      _groupInvitation = doc.data()['List'];
    }
    // remove user id
    _groupInvitation
        .removeWhere((element) => element == userController.userData.userId);
    _userInvitation.removeWhere((element) => element == groupData.groupRef.id);
    // update group list of invited memebers
    groupData.groupRef
        .collection('InvitedMembers')
        .doc('memberList')
        .set({'List': _groupInvitation});
    // update list of user invted by group
    userController.userData.refrence
        .collection('GroupsInvitations')
        .doc('Groups' + userController.userData.userId)
        .set({'List': _userInvitation});
// get group members
    _groupMember = await getGroupMember(groupData);

    userController.myGroups.add(groupData.groupRef.id);
    // update user and group memeber and group list
    userController.userData.refrence
        .collection("Groups")
        .doc('Groups' + userController.userData.userId)
        .set({'List': userController.myGroups});
    _groupMember.add(userController.userData.userId);
    groupData.groupRef
        .collection('Members')
        .doc('memberList')
        .set({'List': _groupMember});

    update();
  }

  leaveGroup() async {
    var _groupMember = [];
    _groupMember = await getGroupMember(selectedGroup);

    userController.myGroups
        .removeWhere((element) => element == selectedGroup.groupRef.id);
    // update user and group memeber and group list
    userController.userData.refrence
        .collection("Groups")
        .doc('Groups' + userController.userData.userId)
        .set({'List': userController.myGroups});
    _groupMember
        .removeWhere((element) => element == userController.userData.userId);
    selectedGroup.groupRef
        .collection('Members')
        .doc('memberList')
        .set({'List': _groupMember});
    if (selectedGroup.admins.contains(userController.userData.userId)) {
      List _admins = selectedGroup.admins;
      _admins
          .removeWhere((element) => element == userController.userData.userId);
      selectedGroup.groupRef.update({'admins': _admins});
      update();
    }
    Get.back();
    Get.back();
    Get.back();
  }

  removeUser(UserModel userData) async {
    var _groupMember = [];
    var _userGroup = [];
    _userGroup = await getUserGroup(userData);
    _groupMember = await getGroupMember(selectedGroup);

    _userGroup.removeWhere((element) => element == selectedGroup.groupRef.id);
    // update user and group memeber and group list
    userData.refrence
        .collection("Groups")
        .doc('Groups' + userData.userId)
        .set({'List': _userGroup});
    _groupMember.removeWhere((element) => element == userData.userId);
    selectedGroup.groupRef
        .collection('Members')
        .doc('memberList')
        .set({'List': _groupMember});
    update();
  }
/* ------------------------------ image picker ------------------------------ */

  // void showPickerImage() {
  //   showModalBottomSheet(
  //       context: customContext,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGallery();
  //                     }),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
