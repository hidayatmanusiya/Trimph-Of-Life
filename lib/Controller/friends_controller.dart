import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';

class FriendController extends GetxController {
  bool actionBlocked = false;
  UserController userController = Get.put(UserController());
  NotificationController notificationController =
      Get.put(NotificationController());
  Loader loader = Get.put(Loader());
/* -------------------------------- variables ------------------------------- */

  List<UserModel> allUserList = [];
  List<UserModel> allRequestList = [];
  List<UserModel> allFriendList = [];

/* --------------------------------- queries -------------------------------- */
  var userFirebase = FirebaseFirestore.instance.collection('Users');
  var alluser = FirebaseFirestore.instance
      .collection('Users')
      .where('UserId', isNotEqualTo: UserController().userData.userId);

/* -------------------------------- functions ------------------------------- */

  getallData() {
    getAlluser();
    getFriendRequestList();
    getFriensList();
  }

  checkFriendorRequestReceive(user) {
    bool found = false;
    // if (userController.requestSentList.contains(user)) {
    //   found = true;
    // }
    if (userController.friendsList.contains(user)) {
      found = true;
    }
    if (userController.friendRequestList.contains(user)) {
      found = true;
    }
    return found;
  }
/* ---------------------------- get all user list --------------------------- */

  getAlluser() async {
    loader.loadingShow();
    await userFirebase
        .where('UserId', isNotEqualTo: userController.userData.userId)
        .get()
        .then((qSnap) {
      if (qSnap.docs.length > 0) {
        allUserList.clear();
        qSnap.docs.forEach((element) {
          //* in future we can also remove friend whom already request sent
          allUserList.add(UserModel.fromDocumentSnapshot(element));
        });
      }
      loader.loadingDismiss();
      update();
    });
  }

/* ------------------ add data in user and target user list ----------------- */

/* -------------------------- send request to user -------------------------- */

  sendRequest(DocumentReference ref, token) {
    actionBlocked = true;
    secondUserFriendRequestList(ref).then((list) {
      list.add(userController.userData.userId);
      userController.requestSentList.add(ref.id);
      updateFriendRequest(ref, list);
      updateRequestSent(
          userController.userData.refrence, userController.requestSentList);
      // ref
      //     .collection('FriendRequests')
      //     .doc('FRequest' + ref.id)
      //     .set({'List': list});
      // userController.userData.refrence
      //     .collection('RequestSent')
      //     .doc('RSent' + userController.userData.userId)
      //     .set({'List': userController.requestSentList});

      //! Send notification
      notificationController.sendPushnotification(
          token: token,
          title: "Request Received",
          body: " Send you a Friend request",
          userName: userController.userData.firstName +
              ' ' +
              userController.userData.lastName,
          pic: userController.userData.profilePhoto);

      notificationController.insertNotification(
        ref: ref,
        actionRef: userController.userData.refrence,
        subtype: 'Request Sent',
        type: 'Friend',
        buttondisable: false,
        body:
            '${userController.userData.firstName} ${userController.userData.lastName} Send you a Friend Request',
      );
      actionBlocked = false;
      update();
    });
  }

  cancelRequest(DocumentReference ref) {
    actionBlocked = true;
    secondUserFriendRequestList(ref).then((list) {
      list.removeWhere((element) => element == userController.userData.userId);
      userController.requestSentList
          .removeWhere((element) => element == ref.id);
      updateFriendRequest(ref, list);
      updateRequestSent(
          userController.userData.refrence, userController.requestSentList);

      actionBlocked = false;
      update();
    });
  }

/* ------------------ check is request already sent or not ------------------ */

  isRequestSent(DocumentReference ref) {
    bool found = false;
    if (userController.requestSentList.contains(ref.id)) {
      found = true;
    }
    return found;
  }

  isRequestAccepted(DocumentReference ref) {
    bool found = false;
    if (userController.friendsList.contains(ref.id)) {
      found = true;
    }
    return found;
  }

  //
  // get all user who send you request
  getFriendRequestList() {
    allRequestList.clear();
    loader.loadingShow();
    for (var i = 0; i < userController.friendRequestList.length; i++) {
      userFirebase.doc(userController.friendRequestList[i]).get().then((dSnap) {
        allRequestList.add(UserModel.fromDocumentSnapshot(dSnap));

        update();
      });
    }
    loader.loadingDismiss();
  }

  getFriensList() {
    allFriendList.clear();
    loader.loadingShow();
    for (var i = 0; i < userController.friendsList.length; i++) {
      userFirebase.doc(userController.friendsList[i]).get().then((dSnap) {
        allFriendList.add(UserModel.fromDocumentSnapshot(dSnap));
        update();
      });
    }
    loader.loadingDismiss();
  }

  requestAccept(DocumentReference ref, String token) {
    actionBlocked = true;
    secondUserFriendList(ref).then((friendlist) {
      secondUserRequestSentList(ref).then((requestSentList) {
        friendlist.add(userController.userData.userId);
        userController.friendsList.add(ref.id);
        requestSentList.remove(userController.userData.userId);
        userController.requestSentList.remove(ref.id);
        updateFriends(ref, friendlist);
        updateFriends(
            userController.userData.refrence, userController.friendsList);

        updateRequestSent(ref, requestSentList);

        updateRequestSent(
            userController.userData.refrence, userController.friendRequestList);
        //! Send notification
        notificationController.sendPushnotification(
            token: token,
            title: "Request Accepted",
            body: " Accept Your Friend request",
            userName: userController.userData.firstName +
                ' ' +
                userController.userData.lastName,
            pic: userController.userData.profilePhoto);
        notificationController.insertNotification(
          ref: ref,
          actionRef: userController.userData.refrence,
          buttondisable: true,
          subtype: 'Request Accept',
          type: 'Friend',
          body:
              '${userController.userData.firstName} ${userController.userData.lastName} Accept your friend request',
        );
        update();
        actionBlocked = false;
      });
    });
  }

  updateRequestSent(DocumentReference ref, list) {
    ref.collection('RequestSent').doc('RSent' + ref.id).set({'List': list});
    // notificationController.notification();
  }

  updateFriendRequest(DocumentReference ref, list) {
    ref
        .collection('FriendRequests')
        .doc('FRequest' + ref.id)
        .set({'List': list});
    //  notificationController.notification();
  }

  updateFriends(DocumentReference ref, list) {
    ref.collection('Friends').doc('Friend' + ref.id).set({'List': list});
    //  notificationController.notification();
  }

  secondUserRequestSentList(DocumentReference ref) async {
    List requestSentList = [];
    await ref
        .collection('RequestSent')
        .doc('RSent' + ref.id)
        .get()
        .then((dSnaps) {
      if (dSnaps.exists) {
        requestSentList = dSnaps.data()['List'];
      }
    });
    return requestSentList;
  }

  secondUserFriendList(DocumentReference ref) async {
    List friendList = [];
    await ref.collection('Friends').doc('Friend' + ref.id).get().then((dSnaps) {
      if (dSnaps.exists) {
        friendList = dSnaps.data()['List'];
      }
    });
    return friendList;
  }

  secondUserFriendRequestList(DocumentReference ref) async {
    List requestListofFriend = [];
    await ref
        .collection('FriendRequests')
        .doc('FRequest' + ref.id)
        .get()
        .then((dSnaps) {
      if (dSnaps.exists) {
        requestListofFriend = dSnaps.data()['List'];
      }
    });
    return requestListofFriend;
  }
}
