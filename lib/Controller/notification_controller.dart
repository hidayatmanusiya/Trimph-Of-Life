import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/Controller/friends_controller.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/group_model.dart';
import 'package:triumph_life_ui/models/notification_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';

class NotificationController extends GetxController {
  UserController userController = Get.put(UserController());

  List<NotificationsModel> notificationList = [];

/* ------------------------- send push notification ------------------------- */
  sendPushnotification(
      {String token, String title, String body, String userName, pic}) async {
    String postUrl = 'https://fcm.googleapis.com/fcm/send';

    var data = {
      "to": token,
      "notification": {
        "title": "$title",
        "body": "$userName $body",
        "mutable_content": true,
        "sound": "Tri-tone",
        // "image": pic
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAA5jq0mEU:APA91bFh0Q2lZ2lt6ozTqWsL_VGCYraREYx46xqMM9qCRrQmy1Tbtxe7c30Ab6PF3SWwzc0oL1s0-gmCojy8AbcYnooHF34LAU-tAnT7TLpQsV8vDjwmAIMSzbo4WBOHvklwy-YAuAhh'
    };
    try {
      await http
          .post(
        Uri.parse(postUrl),
        headers: headers,
        body: jsonEncode(data),
      )
          .then((value) {
        print(json.decode(value.body));
      });
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

/* -------------------- insert notification in data base -------------------- */

  Future insertNotification({
    DocumentReference ref,
    String title,
    String body,
    String type,
    String subtype,
    DocumentReference actionRef,
    bool buttondisable = true,
  }) async {
    var now = DateTime.now();
    NotificationsModel notifications = NotificationsModel();
    notifications.title = title;
    notifications.description = body;
    notifications.notificationType = type;
    notifications.subtype = subtype;
    notifications.action1Ref = actionRef;
    notifications.buttonDisable = buttondisable;
    notifications.time = now;
    ref.collection("Notification").add(notifications.toMap());
  }

/* ---------------------------- get notification ---------------------------- */

  getNotification() {
    notificationList.clear();
    DocumentReference ref = userController.userData.refrence;
    ref.collection('Notification').snapshots().forEach((qSnap) {
      notificationList = [];
      qSnap.docs.forEach((element) {
        NotificationsModel notification =
            NotificationsModel.fromDocumentSnapShot(element);
        notificationList.add(notification);

        update();
      });
    });
  }

  acceptRequestFromNotification(
      DocumentReference ref, DocumentReference notificationRef) async {
    FriendController _friendController = Get.put(FriendController());
    if (userController.friendsList.contains(ref.id)) {
      Get.snackbar(
        'Already Accepted',
        'This user is your friend now',
      );
    } else {
      var doc = await ref.get();
      _friendController.requestAccept(
          ref, UserModel.fromDocumentSnapshot(doc).token);
    }
  }

  acceptGroupJoinRequestFromNotification(
      DocumentReference ref, DocumentReference notificationRef) async {
    GroupController _groupController = Get.put(GroupController());
    if (userController.myGroups.contains(ref.id)) {
      Get.snackbar(
        'Already Accepted',
        'You are member of this group already',
      );
    } else {
      var doc = await ref.get();
      _groupController
          .userAcceptInvitation(GroupModel.fromDocumentSnapShot(doc));
    }
  }
}
