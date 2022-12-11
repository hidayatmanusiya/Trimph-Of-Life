import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:triumph_life_ui/models/streamer_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/screens/live_streams/broadcast_page.dart';

class StreamController extends GetxController {
  List<StreamerModel> liveList = [];
  String userChanel = '';
  StreamerModel userLiveData;
  UserModel currentUser = UserModel();

  StreamSubscription<QuerySnapshot> liveSubscription;
  TextEditingController messageTextController = TextEditingController();
  goToLive(UserModel user) async {
    await [Permission.camera, Permission.microphone].request();
    bool cameraGranted = await Permission.camera.isGranted;
    bool audioGranted = await Permission.microphone.isGranted;
    if (cameraGranted && audioGranted) {
      currentUser = user;
      //go to live page
      print(1);
      print(user.userId);
      print(user.email);
      print(user.country);
      print(user.dob);
      print(user.firstName);
      print(user.gender);
      userLiveData = StreamerModel(
          id: user.userId,
          pic: user.profilePhoto,
          name: user.firstName + ' ' + user.lastName,
          status: 'Live');
      /* --------------- change channel name from sheraz to user ID --------------- */
      userChanel = user.userId;
      print(2);
      print(userChanel);
      Get.to(() => BroadcastPage(
            channelName: user.userId,
            isBroadcaster: true,
          ));
    } else {
      Get.snackbar('Permission Error',
          'First Allow Camera & Audio Permission to start live stream',
          backgroundColor: Colors.red.withOpacity(0.4));
    }
  }

  sendMessage() {
    // if (messageTextController.text != '') {
    // print('--------------------------------${messageTextController.text}');
    FirebaseFirestore.instance
        .collection('Lives')
        .doc(userChanel)
        .collection('LiveChat')
        .add({
      'message': messageTextController.text,
      'picture': currentUser.profilePhoto,
      'name': currentUser.firstName + ' ' + currentUser.lastName,
      'adminMessage': userChanel == currentUser.userId,
      'time': DateTime.now().millisecondsSinceEpoch
    });
    messageTextController.clear();
    update();
    // }
  }

  watchLive(chanelName, UserModel userdata) {
    currentUser = userdata;
    userChanel = chanelName;
    Get.to(() => BroadcastPage(
          channelName: chanelName,
          isBroadcaster: false,
        ));
  }

  addDataInLive() {
    FirebaseFirestore.instance
        .collection('Lives')
        .doc(userLiveData.id)
        .set(userLiveData.toMap());
  }

  removeDataFromLive(userId) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection('Lives')
        .doc(userChanel)
        .collection('LiveChat')
        .get();
    var liveref = await FirebaseFirestore.instance
        .collection('Lives')
        .doc(userChanel)
        .get();
    if (liveref.exists) {
      liveref.reference.delete();
    }

    ref.docs.forEach((element) {
      element.reference.delete();
    });
    // var liveref = await FirebaseFirestore.instance
    //     .collection('Lives')
    //     .doc(userChanel)
    //     .get();
    // if (liveref.exists) {
    //   liveref.reference.delete();
    // }
    userChanel = '';
    update();
  }

  getOnlinePlayer(userId) {
    if (liveSubscription != null) {
      liveSubscription.cancel();
    }
    liveSubscription = FirebaseFirestore.instance
        .collection('Lives')
        // .where('id', isNotEqualTo: userId)
        .snapshots()
        .listen((event) {
      liveList.clear();
      event.docs.forEach((doc) {
        liveList.add(StreamerModel.fromDocumentSnapShot(doc));
      });
      update();
    });
  }
}
