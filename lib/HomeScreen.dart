import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/Controller/stream_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/screens/chat_page.dart';
import 'package:triumph_life_ui/tabs/friends_tab.dart';
import 'package:triumph_life_ui/tabs/home_tab.dart';
import 'package:triumph_life_ui/tabs/menu_tab.dart';
import 'package:triumph_life_ui/tabs/notifications_tab.dart';
import 'package:triumph_life_ui/tabs/profile_tab.dart';

import 'constants.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Loader loader = Get.put(Loader());

  TabController _tabController;
  UserController userController = Get.put(UserController());
  ChatController chatController = Get.put(ChatController());
  PostController postController = Get.put(PostController());
  StreamController streamController = Get.put(StreamController());
  @override
  void initState() {
    super.initState();
    // friendController.getallData();
    userController.getData();
    streamController.getOnlinePlayer(FirebaseAuth.instance.currentUser.uid);
    _tabController = TabController(vsync: this, length: 5);
    postController.listenHomePostScrollerScroller(context);
    print("data inserted old app");
    print(userController.getData());
    print(streamController.currentUser);
    print(streamController.userChanel);
    print(streamController.liveList);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        indicatorColor: Colors.blueAccent,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(icon: Icon(Icons.home, size: 30.0)),
          Tab(icon: Icon(Icons.people, size: 30.0)),
          // Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
          Tab(icon: Icon(Icons.account_circle, size: 30.0)),
          Tab(icon: Icon(Icons.notifications, size: 30.0)),
          Tab(icon: Icon(Icons.menu, size: 30.0))
        ],
      );

  @override
  Widget build(BuildContext context) {
    customContext = context;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,

        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Triumph of Life',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              // GestureDetector(
              // onTap: () {
              //   Get.snackbar('Posted', 'Your post Publish SuccessFully',
              //       backgroundColor: Colors.green.withOpacity(0.4));
              // loader.loadingShow();
              // notificationController.sendPushnotification(
              //     'c5r2R7cmThOJb0dT2R6PeI:APA91bHjDPOERCjIf5nLdKBMfN6r_gCRumHnxyOCVbPFDnekz8WOQOlFBaCpiY8xMoFSEAkQ4IRJyZ89V3laGqQfy0mZGGfTwsnuKe-KGKQyFm4z85E_EfI1APjsrjlt8TvjTHNuZzQT',
              //     'Friend Request Recieved',
              //     'Send you a Friend Request',
              //     'sherazi');
              // },
              // child: Icon(Icons.search, color: Colors.white)
              //     ),
              SizedBox(width: 15.0),
              GestureDetector(
                  onTap: () {
                    chatController.getChatList(userController.userData.userId);
                    Get.to(ChatPage());
                  },
                  child: Icon(Icons.chat_rounded, color: Colors.white))
            ]),
          ],
        ),
        backgroundColor: Color(0xffffd600),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: ColoredBox(
            color: Colors.white,
            child: _tabBar,
          ),
        ),
//        TabBar(
//
//          indicatorColor: Colors.blueAccent,
//          controller: _tabController,
//          unselectedLabelColor: Colors.grey,
//          labelColor: Colors.blueAccent,
//
//          tabs: [
//            Tab(icon: Icon(Icons.home, size: 30.0)),
//            Tab(icon: Icon(Icons.people, size: 30.0)),
////            Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
//            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
//            Tab(icon: Icon(Icons.notifications, size: 30.0)),
//            Tab(icon: Icon(Icons.menu, size: 30.0))
//          ],
//        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeTab(),
        FriendsTab(),
        // WatchTab(),
        ProfileTab(),
        NotificationsTab(),
        MenuTab()
      ]),
    );
  }
}
