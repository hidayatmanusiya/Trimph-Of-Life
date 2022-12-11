import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';

import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/comment_model.dart';
import 'package:triumph_life_ui/models/post_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';

class CommentController extends GetxController {
  NotificationController notificationController =
      Get.put(NotificationController());
  UserController userController = Get.put(UserController());
  PostController postController = Get.put(PostController());
  PostModel currentPost;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  bool actionBlocked = false;
  CommentModel commentData = CommentModel();
  List<CommentModel> commentList = [];
  postComment(
    comment,
  ) async {
    if (comment == '') {
      return null;
    }
    int postComments = currentPost.totalComments + 1;
    //create comment Data
    if (!actionBlocked) {
      actionBlocked = true;
      commentData.comment = comment;
      commentData.userId = userController.userData.userId;
      commentData.userphoto = userController.userData.profilePhoto;
      commentData.userName = userController.userData.firstName +
          ' ' +
          userController.userData.lastName;
      commentData.time = FieldValue.serverTimestamp();

      currentPost.ref.collection('Comments').add(commentData.toMap());
      currentPost.ref.update({
        "lcbyUserId": commentData.userId,
        "lcUserphoto": commentData.userphoto,
        "lcUserName": commentData.userName,
        "lcTime": commentData.time,
        "lastComment": commentData.comment,
        "totalComments": postComments
      });
      actionBlocked = false;
      currentPost.lastComment = commentData.comment;
      currentPost.lastCommentTime = null;
      currentPost.lcUserName = commentData.userName;
      currentPost.lcUserphoto = commentData.userphoto;
      currentPost.totalComments = postComments;

      postController.update();

      // commentList.add(commentData);
      getAllComments();
      Get.snackbar('Comment Posted', comment,
          backgroundColor: Colors.green.withOpacity(0.6));

/* ---------------------------- push notification --------------------------- */

      if (currentPost.userId != userController.userData.userId) {
        var postOwner = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentPost.userId)
            .get();
        notificationController.sendPushnotification(
          token: UserModel.fromDocumentSnapshot(postOwner).token,
          title: "Comment",
          body:
              "${userController.userData.firstName} ${userController.userData.lastName} Comment on your post ",
          userName: '',
        );
        notificationController.insertNotification(
          ref: UserModel.fromDocumentSnapshot(postOwner).refrence,
          actionRef: currentPost.ref,
          buttondisable: true,
          subtype: 'Comment',
          type: 'Post',
          body:
              "${userController.userData.firstName} ${userController.userData.lastName} Comment on your post ",
        );
      }
      update();
    }
  }

  getAllComments() {
    commentList.clear();
    currentPost.ref
        .collection('Comments')
        .orderBy('time', descending: true)
        .get()
        .then((qsnaps) {
      if (qsnaps.size > 0) {
        qsnaps.docs.forEach((doc) {
          commentList.add(CommentModel.fromDocumentSnapShot(doc));
        });
        update();
      }
    });
  }
}
