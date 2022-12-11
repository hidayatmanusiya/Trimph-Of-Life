import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/post_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/widgets/post_widget/reactins.dart';

import 'loading_controller.dart';

class LikeController extends GetxController {
  PostModel postData = PostModel();
  Loader loader = Get.put(Loader());
  UserController userController = Get.put(UserController());
  NotificationController notificationController =
      Get.put(NotificationController());

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  List likes = [];
  liked(ref, PostModel post, index, ischeked) async {
    int reactionIndex = checkIsLiked(post);
    if (reactionIndex != index) {
      if (reactionIndex == 0) {
        removeLike(ref, post);
      } else if (reactionIndex == 1) {
        removeLove(ref, post);
      } else if (reactionIndex == 2) {
        removeHaha(ref, post);
      } else if (reactionIndex == 3) {
        removeWow(ref, post);
      } else if (reactionIndex == 4) {
        removeSad(ref, post);
      } else if (reactionIndex == 5) {
        removeAngry(ref, post);
      }
    }
    bool isaddLike = false;
    if (reactionIndex == -1 && ischeked == true) {
      isaddLike = true;
    } else {
      isaddLike = false;
    }

    if (isaddLike || reactionIndex != index) {
      if (ischeked && (index == -1 || index == 0)) {
        addLike(ref, post);
      } else if (ischeked && (index == 1)) {
        addLove(ref, post);
      } else if (ischeked && (index == 2)) {
        addHaha(ref, post);
      } else if (ischeked && (index == 3)) {
        addWow(ref, post);
      } else if (ischeked && (index == 4)) {
        addSad(ref, post);
      } else if (ischeked && (index == 5)) {
        addAngry(ref, post);
      } else if (!ischeked) {
        print('remove reaction');
      }

/* ---------------------------- add notification ---------------------------- */
      if (post.userId != userController.userData.userId) {
        var postOwner = await FirebaseFirestore.instance
            .collection('Users')
            .doc(post.userId)
            .get();
        notificationController.sendPushnotification(
          token: UserModel.fromDocumentSnapshot(postOwner).token,
          title: "Reaction",
          body:
              "${userController.userData.firstName} ${userController.userData.lastName} React on your post ",
          userName: '',
        );
        notificationController.insertNotification(
          ref: UserModel.fromDocumentSnapshot(postOwner).refrence,
          actionRef: post.ref,
          buttondisable: true,
          subtype: 'Reaction',
          type: 'Post',
          body:
              "${userController.userData.firstName} ${userController.userData.lastName} react on your post ",
        );
      }
    }
  }

  checkLikedReaction(PostModel post) {
    String userId = userController.userData.userId;
    if ((post.likeList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/like.gif',
          'assets/reactions/like_fill.png', 'Like', Colors.blue);
    } else if ((post.hahaList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/haha.gif',
          'assets/reactions/haha.png', 'Haha', Colors.yellow[900]);
    } else if ((post.sadList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/sad.gif',
          'assets/reactions/sad.png', 'Sad', Colors.yellow[900]);
    } else if ((post.loveList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/love.gif',
          'assets/reactions/love.png', 'Love', Colors.red[900]);
    } else if ((post.wowList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/wow.gif',
          'assets/reactions/wow.png', 'Wow', Colors.yellow[900]);
    } else if ((post.angryList ?? []).contains(userId)) {
      return reactionIcon('assets/reactions/angry.gif',
          'assets/reactions/angry.png', 'Angry', Colors.deepOrange);
    } else {
      return reactionIcon('assets/reactions/like.gif',
          'assets/reactions/like_fill.png', 'Like', Colors.grey[800]);
    }
  }

  countLikes(PostModel post) {
    int total = 0;
    total = total + (post.likeList ?? []).length;
    total = total + (post.loveList ?? []).length;
    total = total + (post.wowList ?? []).length;
    total = total + (post.hahaList ?? []).length;
    total = total + (post.sadList ?? []).length;
    total = total + (post.angryList ?? []).length;
    if (total != 0) {
      return total == 1 ? '$total Reaction' : '$total Reactions';
    } else {
      return 'No Reaction';
    }
  }

  checkIsLiked(PostModel post) {
    String userId = userController.userData.userId;
    if ((post.likeList ?? []).contains(userId)) {
      return 0;
    } else if ((post.hahaList ?? []).contains(userId)) {
      return 2;
    } else if ((post.sadList ?? []).contains(userId)) {
      return 4;
    } else if ((post.loveList ?? []).contains(userId)) {
      return 1;
    } else if ((post.wowList ?? []).contains(userId)) {
      return 3;
    } else if ((post.angryList ?? []).contains(userId)) {
      return 5;
    } else {
      return -1;
    }
  }

  // boolcheckIsLiked(PostModel post) {
  //   String userId = userController.userData.userId;
  //   if ((post.likeList ?? []).contains(userId)) {
  //     return true;
  //   } else if (post.hahaList ?? [].contains(userId)) {
  //     return true;
  //   } else if (post.sadList ?? [].contains(userId)) {
  //     return true;
  //   } else if (post.loveList ?? [].contains(userId)) {
  //     return true;
  //   } else if (post.wowList ?? [].contains(userId)) {
  //     return true;
  //   } else if (post.angryList ?? [].contains(userId)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  addLike(DocumentReference ref, PostModel post) async {
    if (post.likeList == null) {
      post.likeList = [];
    }
    post.likeList.add(userController.userData.userId);

    for (var i = 0; i < (post.likeList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.likeList.length) {
          temp.add(post.likeList[j]);
        }
      }
      ref.collection('Likes').doc('${i + 1}').set({'list': temp});
      ref.collection('Likes').doc('info').set({'TotalLists': (i + 1)});
      print('file updated -->$i');
    }
  }

  addHaha(DocumentReference ref, PostModel post) async {
    if (post.hahaList == null) {
      post.hahaList = [];
    }
    post.hahaList.add(userController.userData.userId);
    for (var i = 0; i < (post.hahaList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.hahaList.length) {
          temp.add(post.hahaList[j]);
        }
      }
      ref.collection('Hahas').doc('${i + 1}').set({'list': temp});
      ref.collection('Hahas').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
  }

  addWow(DocumentReference ref, PostModel post) async {
    if (post.wowList == null) {
      post.wowList = [];
    }
    post.wowList.add(userController.userData.userId);
    for (var i = 0; i < (post.wowList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.wowList.length) {
          temp.add(post.wowList[j]);
        }
      }
      ref.collection('Wows').doc('${i + 1}').set({'list': temp});
      ref.collection('Wows').doc('info').set({'TotalLists': (i + 1)});
      print('file updated -->$i');
    }
  }

  addSad(DocumentReference ref, PostModel post) async {
    if (post.sadList == null) {
      post.sadList = [];
    }
    post.sadList.add(userController.userData.userId);
    for (var i = 0; i < (post.sadList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.sadList.length) {
          temp.add(post.sadList[j]);
        }
      }
      ref.collection('Sads').doc('${i + 1}').set({'list': temp});
      ref.collection('Sads').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
  }

  addLove(DocumentReference ref, PostModel post) async {
    if (post.loveList == null) {
      post.loveList = [];
    }
    post.loveList.add(userController.userData.userId);
    for (var i = 0; i < (post.loveList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.loveList.length) {
          temp.add(post.loveList[j]);
        }
      }
      ref.collection('Loves').doc('${i + 1}').set({'list': temp});
      ref.collection('Loves').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
  }

  addAngry(DocumentReference ref, PostModel post) async {
    if (post.angryList == null) {
      post.angryList = [];
    }
    post.angryList.add(userController.userData.userId);
    for (var i = 0; i < (post.angryList.length / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.angryList.length) {
          temp.add(post.angryList[j]);
        }
      }
      ref.collection('Angrys').doc('${i + 1}').set({'list': temp});
      ref.collection('Angrys').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
  }

/* -------------------------------------------------------------------------- */
/*                                remove Reaction                                */
/* -------------------------------------------------------------------------- */

  removeLike(DocumentReference ref, PostModel post) async {
    if (post.likeList == null) {
      post.likeList = [];
    }
    int fileLength = (((post.likeList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;
    post.likeList.removeWhere((id) => userController.userData.userId == id);

    for (var i = 0; i < ((post.likeList.length + 1) / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.likeList.length) {
          temp.add(post.likeList[j]);
        }
      }
      ref.collection('Likes').doc('${i + 1}').set({'list': temp});
      ref.collection('Likes').doc('info').set({'TotalLists': (i + 1)});
      print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Likes').doc('$fileLength').delete();
    }
  }

  removeHaha(DocumentReference ref, PostModel post) async {
    if (post.hahaList == null) {
      post.hahaList = [];
    }
    int fileLength = (((post.hahaList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;
    post.hahaList.removeWhere((id) => userController.userData.userId == id);
    for (var i = 0; i < ((post.hahaList.length + 1) / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.hahaList.length) {
          temp.add(post.hahaList[j]);
        }
      }
      ref.collection('Hahas').doc('${i + 1}').set({'list': temp});
      ref.collection('Hahas').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Hahas').doc('$fileLength').delete();
    }
  }

  removeWow(DocumentReference ref, PostModel post) async {
    if (post.wowList == null) {
      post.wowList = [];
    }
    int fileLength = (((post.wowList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;
    post.wowList.removeWhere((id) => userController.userData.userId == id);
    for (var i = 0; i < ((post.wowList.length + 1) / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.wowList.length) {
          temp.add(post.wowList[j]);
        }
      }
      ref.collection('Wows').doc('${i + 1}').set({'list': temp});
      ref.collection('Wows').doc('info').set({'TotalLists': (i + 1)});
      print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Wows').doc('$fileLength').delete();
    }
  }

  removeSad(DocumentReference ref, PostModel post) async {
    if (post.sadList == null) {
      post.sadList = [];
    }
    int fileLength = (((post.sadList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;

    post.sadList.removeWhere((id) => userController.userData.userId == id);
    for (var i = 0; i < ((post.sadList.length + 1) / 4000); i++) {
      loopIndex = i;
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.sadList.length) {
          temp.add(post.sadList[j]);
        }
      }
      ref.collection('Sads').doc('${i + 1}').set({'list': temp});
      ref.collection('Sads').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Sads').doc('$fileLength').delete();
    }
  }

  removeLove(DocumentReference ref, PostModel post) async {
    if (post.loveList == null) {
      post.loveList = [];
    }
    int fileLength = (((post.loveList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;
    post.loveList.removeWhere((id) => userController.userData.userId == id);
    for (var i = 0; i < ((post.loveList.length + 1) / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.loveList.length) {
          temp.add(post.loveList[j]);
        }
      }
      ref.collection('Loves').doc('${i + 1}').set({'list': temp});
      ref.collection('Loves').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Loves').doc('$fileLength').delete();
    }
  }

  removeAngry(DocumentReference ref, PostModel post) async {
    if (post.angryList == null) {
      post.angryList = [];
    }
    int fileLength = (((post.angryList.length ~/ 4000) + 1)).toInt();
    int loopIndex = 0;
    post.angryList.removeWhere((id) => userController.userData.userId == id);
    for (var i = 0; i < ((post.angryList.length + 1) / 4000); i++) {
      List temp = [];
      for (var j = i * 4000; j < (i + 1) * 4000; j++) {
        if (j < post.angryList.length) {
          temp.add(post.angryList[j]);
        }
      }
      ref.collection('Angrys').doc('${i + 1}').set({'list': temp});
      ref.collection('Angrys').doc('info').set({'TotalLists': (i + 1)});
      // print('file updated -->$i');
    }
    if ((loopIndex + 1) < fileLength) {
      ref.collection('Angrys').doc('$fileLength').delete();
    }
  }
}
