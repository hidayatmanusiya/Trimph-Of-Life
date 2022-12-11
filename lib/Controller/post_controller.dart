import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/group_model.dart';
import 'package:triumph_life_ui/models/post_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';

class PostController extends GetxController {
  // ReactionListController reactionListController =
  //     Get.put(ReactionListController());
  PostModel postData = PostModel();
  Loader loader = Get.put(Loader());
  UserController userController = Get.put(UserController());
  TextEditingController postTextController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  File postpic;
  bool actionBlocked = false;
  List<PostModel> allPosts = [];
  List<PostModel> userPosts = [];
  List<PostModel> groupAllPosts = [];
  List<DocumentSnapshot> products = []; // stores fetched products
  bool isLoadingHomeFeeds = false;
  bool hasMoreHomeFeeds = true;
  int documentLimit = 5;
  DocumentSnapshot homeFeedlastDocument;
  ScrollController homeFeedScrollController = ScrollController();
  bool isLoadingGroupFeeds = false;
  bool hasMoreGroupFeeds = true;
  DocumentSnapshot groupFeedlastDocument;
  ScrollController groupScrollController = ScrollController();
  bool isLoadingUserFeeds = false;
  bool hasMoreUserFeeds = true;
  DocumentSnapshot userFeedlastDocument;
  ScrollController userScrollController = ScrollController();

  savePost() {
    if (!actionBlocked) {
      actionBlocked = true;
      uploadFile(
          "postsPics/${userController.userData.userId}/Posts${DateTime.now()}.jpg",
          firebase);
    }
  }

  savePostForGroup(GroupModel groupData, context) async {
    if (!actionBlocked) {
      actionBlocked = true;
      await uploadFile(
          "GroupsPics/${groupData.groupRef.id}/${userController.userData.userId}/Posts${DateTime.now()}.jpg",
          groupData.groupRef);
      listenGroupPostScrollerScroller(context, groupData.groupRef);
    }
  }

  sharePost(PostModel post) {
    if (!actionBlocked) {
      actionBlocked = true;

      var sharedPost = PostModel();
      int totalShares = post.totalShares + 1;
      if (post.isPostShared) {
        sharedPost.originalPostId = post.originalPostId;
        sharedPost.originalUserId = post.originalUserId;
        sharedPost.originalTime = post.originalTime;
        sharedPost.originalUserName = post.originalUserName;
        sharedPost.originalUserPic = post.originalUserPic;
      } else {
        sharedPost.originalPostId = post.postId;
        sharedPost.originalUserId = post.userId;
        sharedPost.originalTime = post.time;
        sharedPost.originalUserName = post.username;
        sharedPost.originalUserPic = post.userPic;
      }
      sharedPost.userPic = userController.userData.profilePhoto;
      sharedPost.username = userController.userData.firstName +
          ' ' +
          userController.userData.lastName;
      sharedPost.userId = userController.userData.userId;
      sharedPost.isPostShared = true;
      sharedPost.content = post.content;
      sharedPost.postPhoto = post.postPhoto;
      sharedPost.time = FieldValue.serverTimestamp();
      post.ref.update({'totalShares': totalShares});
      firebase.collection('Posts').add(sharedPost.toMap()).then((ref) {
        ref.get().then((doc) {
          allPosts.insert(0, PostModel.fromDocumentSnapShot(doc));
          update();
        });
      });
      post.totalShares = totalShares;
      Get.snackbar('Shared', 'Post Shared',
          backgroundColor: Colors.greenAccent.withOpacity(0.4));
      actionBlocked = false;
      sharedPost.time = null;

      update();
    }
  }

  sharePostInGroup(PostModel post, GroupModel groupData) {
    if (!actionBlocked) {
      actionBlocked = true;

      var sharedPost = PostModel();
      int totalShares = post.totalShares + 1;
      if (post.isPostShared) {
        sharedPost.originalPostId = post.originalPostId;
        sharedPost.originalUserId = post.originalUserId;
        sharedPost.originalTime = post.originalTime;
        sharedPost.originalUserName = post.originalUserName;
        sharedPost.originalUserPic = post.originalUserPic;
      } else {
        sharedPost.originalPostId = post.postId;
        sharedPost.originalUserId = post.userId;
        sharedPost.originalTime = post.time;
        sharedPost.originalUserName = post.username;
        sharedPost.originalUserPic = post.userPic;
      }
      sharedPost.userPic = userController.userData.profilePhoto;
      sharedPost.username = userController.userData.firstName +
          ' ' +
          userController.userData.lastName;
      sharedPost.userId = userController.userData.userId;
      sharedPost.isPostShared = true;
      sharedPost.content = post.content;
      sharedPost.postPhoto = post.postPhoto;
      sharedPost.time = FieldValue.serverTimestamp();
      post.ref.update({'totalShares': totalShares});
      groupData.groupRef.collection('Posts').add(sharedPost.toMap());
      post.totalShares = totalShares;
      Get.snackbar('Shared', 'Post Shared',
          backgroundColor: Colors.greenAccent.withOpacity(0.4));
      actionBlocked = false;
      sharedPost.time = null;

      update();
    }
  }

/* -------------------------------------------------------------------------- */
/*                             get home page posts                            */
/* -------------------------------------------------------------------------- */

  listenHomePostScrollerScroller(context) {
    isLoadingHomeFeeds = false;
    hasMoreHomeFeeds = true;
    homeFeedScrollController.dispose();
    homeFeedScrollController = ScrollController();
    homeFeedlastDocument = null;
    allPosts.clear();
    getPosts();
    homeFeedScrollController.addListener(() {
      double maxScroll = homeFeedScrollController.position.maxScrollExtent;
      double currentScroll = homeFeedScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        //  getProducts();
        getPosts();
      }
    });
  }

  getPosts() {
    // allPosts.clear();
    if (!hasMoreHomeFeeds) {
      print("no more posts");
      isLoadingHomeFeeds = false;
      update();
      return;
    }
    if (isLoadingHomeFeeds) {
      return;
    }
    isLoadingHomeFeeds = true;
    update();
    if (homeFeedlastDocument == null) {
      // allPosts.clear();
      firebase
          .collection('Posts')
          .orderBy('time', descending: true)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          homeFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreHomeFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            allPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingHomeFeeds = false;

          update();
        }
      });
    } else {
      firebase
          .collection('Posts')
          .orderBy('time', descending: true)
          .startAfterDocument(homeFeedlastDocument)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          homeFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreHomeFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            allPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingHomeFeeds = false;

          update();
        }
      });
    }
  }

/* -------------------------------------------------------------------------- */
/*                     get post for a user on which taped                     */
/* -------------------------------------------------------------------------- */
  listenUserPostScrollerScroller(context, UserModel user) {
    isLoadingUserFeeds = false;
    hasMoreUserFeeds = true;
    userScrollController.dispose();
    userScrollController = ScrollController();
    userFeedlastDocument = null;
    userPosts.clear();

    getPostsForSpecificUser(user);
    userScrollController.addListener(() {
      double maxScroll = userScrollController.position.maxScrollExtent;
      double currentScroll = userScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        //  getProducts();
        getPostsForSpecificUser(user);
      }
    });
  }

  getPostsForSpecificUser(UserModel user) {
    // userPosts.clear();
    if (!hasMoreUserFeeds) {
      print("no more posts");
      isLoadingUserFeeds = false;
      update();
      return;
    }
    if (isLoadingUserFeeds) {
      return;
    }
    isLoadingUserFeeds = true;
    update();
    if (userFeedlastDocument == null) {
      firebase
          .collection('Posts')
          .where('userId', isEqualTo: user.userId)
          .orderBy('time', descending: true)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          userFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreUserFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            userPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingHomeFeeds = false;

          update();
        }
      });
    } else {
      firebase
          .collection('Posts')
          .where('userId', isEqualTo: user.userId)
          .orderBy('time', descending: true)
          .startAfterDocument(userFeedlastDocument)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          userFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreUserFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            userPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingHomeFeeds = false;

          update();
        }
      });
    }
  }

/* -------------------------------------------------------------------------- */
/*                             get posts for group                            */
/* -------------------------------------------------------------------------- */

  listenGroupPostScrollerScroller(context, DocumentReference ref) {
    isLoadingGroupFeeds = false;
    hasMoreGroupFeeds = true;
    groupScrollController.dispose();
    groupScrollController = ScrollController();
    groupFeedlastDocument = null;
    groupAllPosts.clear();

    getPostsForGroups(ref);
    groupScrollController.addListener(() {
      double maxScroll = groupScrollController.position.maxScrollExtent;
      double currentScroll = groupScrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        // groupAllPosts.clear();
        //  getProducts();
        getPostsForGroups(ref);
      }
    });
  }

  getPostsForGroups(DocumentReference ref) {
    // groupAllPosts.clear();
    if (!hasMoreGroupFeeds) {
      print("no more posts");
      isLoadingGroupFeeds = false;
      update();
      return;
    }
    if (isLoadingGroupFeeds) {
      return;
    }
    isLoadingGroupFeeds = true;
    update();
    if (groupFeedlastDocument == null) {
      ref
          .collection('Posts')
          .orderBy('time', descending: true)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          groupFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreGroupFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            groupAllPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingGroupFeeds = false;

          update();
        }
      });
    } else {
      ref
          .collection('Posts')
          .orderBy('time', descending: true)
          .startAfterDocument(groupFeedlastDocument)
          .limit(documentLimit)
          .get()
          .then((qSnap) {
        if (qSnap.size > 0) {
          groupFeedlastDocument = qSnap.docs.last;
          if (qSnap.docs.length < documentLimit) {
            hasMoreGroupFeeds = false;
          }
          qSnap.docs.forEach((docSnap) async {
            var post = PostModel.fromDocumentSnapShot(docSnap);
            groupAllPosts.add(post);
            //get likes
            getLike(post);
            getWow(post);
            getHaha(post);
            getSad(post);
            getAngry(post);
            getLove(post);
          });
          isLoadingGroupFeeds = false;

          update();
        }
      });
    }
  }

/* ------------------------- select Picture from camera ------------------------ */

  imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      postpic = File(pickedFile.path);
      update();
    }
  }

/* ------------------------ select picture from galer ----------------------- */

  imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      postpic = File(pickedFile.path);
      update();
    }
  }

/* ------------------- bottom sheet for picture selcetion ------------------- */

  void selectPhoto(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

/* ------------------------------ delete PHoto ------------------------------ */

  deletePhoto() {
    postpic = null;
    update();
  }

  uploadPost(link, ref) async {
    // String link;
    // if (postpic != null) {
    //   link = await uploadFile();
    // }
    var user = userController.userData;
    postData.content = postTextController.text;
    postData.time = FieldValue.serverTimestamp();
    postData.userId = user.userId;
    postData.userPic = user.profilePhoto;
    postData.username = user.firstName + ' ' + user.lastName;
    postData.postPhoto = link;
    ref.collection('Posts').add(postData.toMap());
    loader.loadingDismiss();
    postTextController.text = '';
    postpic = null;
    Get.back();
    Get.snackbar('Published', 'Your post Publish SuccessFully',
        backgroundColor: Colors.greenAccent.withOpacity(0.4));
    actionBlocked = false;
    update();
  }
/* ------------------------------- upload file ------------------------------ */

  Future uploadFile(path, ref) async {
    loader.loadingShow();
    if (postpic != null) {
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(path);
      final firebase_storage.UploadTask uploadTask =
          storageReference.putData(postpic.readAsBytesSync());
      await uploadTask.whenComplete(() {
        storageReference.getDownloadURL().then((link) {
          print(link);
          uploadPost(link, ref);
        });
      });
    } else {
      uploadPost(null, ref);
    }
  }

/* -------------------------------------------------------------------------- */
/*                              get all reaction                              */
/* -------------------------------------------------------------------------- */
  getLike(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Likes').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Likes').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.likeList = tempList;
      print(allPosts);
      update();
    }
  }

  getHaha(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Hahas').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Hahas').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.hahaList = tempList;
      print(allPosts);
      update();
    }
  }

  getAngry(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc =
        await post.ref.collection('Angrys').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref
            .collection('Angrys')
            .doc("$index")
            .get()
            .then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.angryList = tempList;
      print(allPosts);
      update();
    }
  }

  getSad(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Sads').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Sads').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.sadList = tempList;
      print(allPosts);
      update();
    }
  }

  getLove(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Loves').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Loves').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.loveList = tempList;
      print(allPosts);
      update();
    }
  }

  getWow(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Wows').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Wows').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.wowList = tempList;
      print(allPosts);
      update();
    }
  }
}
