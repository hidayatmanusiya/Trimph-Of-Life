
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/fetch_all_posts.dart';
import 'package:triumph_life_ui/newappcode/Api/showBioToUser_api.dart';
import 'package:triumph_life_ui/newappcode/Api/viewProfilePic_api.dart';
import 'package:triumph_life_ui/newappcode/Data/postData.dart';
import 'package:triumph_life_ui/newappcode/Data/profilePicData.dart';
import 'package:triumph_life_ui/newappcode/Data/userData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/api/firebase_api.dart';
import 'package:triumph_life_ui/newappcode/Messaging/chat_box.dart';
import 'package:triumph_life_ui/newappcode/Messaging/main.dart';
import 'package:triumph_life_ui/newappcode/Messaging/page/chats_page.dart';
import 'package:triumph_life_ui/newappcode/Messaging/users.dart';
import 'package:triumph_life_ui/newappcode/screens/writePost.dart';
import 'package:triumph_life_ui/newappcode/vedioStreaming/videoStream.dart';
import 'package:triumph_life_ui/newappcode/widgets/widgets.dart';

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
import '../../models/userModel.dart';
import '../Api/friends_api.dart';
import '../Navigation/bottomNavigationBar.dart';
import '../Messaging/message.dart';
import '../User/globalUser.dart' as globals;


class homeScreen extends StatefulWidget {
  const homeScreen({Key key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> with SingleTickerProviderStateMixin  {
  int id;

  TabController  _tabController;
  UserController userController = Get.put(UserController());
  ChatController chatController = Get.put(ChatController());
  PostController postController = Get.put(PostController());
  StreamController streamController = Get.put(StreamController());
  dynamic data, userdata, profiledata;List frienddata;
  @override
  void initState() {
    // userController.getData();
    // streamController.getOnlinePlayer(FirebaseAuth.instance.currentUser.uid);
    // _tabController = TabController(vsync: this, length: 2);
    // postController.listenHomePostScrollerScroller(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    initialGetsavedData();
    super.initState();
  }

  void initialGetsavedData() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    id = user.getInt('userId');
    print("Home Screen + ${id}");
    globals.GlobalUserId=id;
    print(globals.GlobalUserId);
    final body2 = {'view': 'view', "user_id": '${id}'};
    final body = {'showprofile': 'show', "user_id": '${id}'};
    final body1 = {'friends': 'friends', "user_id": '${id}'};
    data = ApiServicee_all.fetchPost();
    profiledata = ApiServices.viewProfilePic(body);
    userdata = ApiService_userData.showBioToUser(body2);
    frienddata=await ApiServicee_friends.get_friends(body1);
    FirebaseApi.addRandomUsers(frienddata);
    setState(() {});
  }

  final double coverheight = 148;
  final double profileheight = 114;

  Widget buildProfileImage() => CircleAvatar(
        radius: profileheight / 4,
        backgroundImage: AssetImage('assets/images.jpg'),
        //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
      );

  TextEditingController post_content = new TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:


    Container(
    width: width,
    height: height,
    child: Scaffold(
    body:

    Container(
    color: Color(0xffCC9B00),
    child: Column(
    children: [
    Expanded(
    flex: 2,
    child: Row(
    children: [
    Expanded(
    flex: 2,
    child: Container(
    child: Image(
    alignment: Alignment.topLeft,
    height: 161,
    width: 333,
    image: AssetImage('assets/logo1.png'),
    ),
    ),
    ),
    Expanded(
    flex: 2,
    child: Container(
    child: InkWell(
    onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => MyApp_()));
    },
    child: Image(
    alignment: Alignment.topRight,
    height: 53.97,
    width: 96,
    image: AssetImage('assets/chat.png'),
    )),
    ),
    ),
    ],
    ),
    ),
    Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(50),
    topRight: Radius.circular(50),
    ),
    ),
    child: Column(
    children: [
    SizedBox(
    height: 20,
    ),
    Column(
    children: [
    Row(
    children: [
    SizedBox(
    width: 5,
    ),
    FutureBuilder<profilePicData>(
    future: profiledata,
    builder: (BuildContext context,
    AsyncSnapshot snapshot) {
    if (snapshot.hasData == null) {
    return Container(
    child: Center(
    child: Text(
    'loading',
    ),
    ),
    );
    } else if (snapshot.hasData) {
    profilePicData data = snapshot.data;
    return CircleAvatar(
    radius: profileheight / 4,
    backgroundImage: AssetImage('assets/images.jpg'),
    child: CachedNetworkImage(
    imageUrl: data.path.toString() +
    data.Profile_pic.toString(),
    imageBuilder:
    (context, imageProvider) =>
    Container(
    width: profileheight,
    height: profileheight,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
    image: imageProvider,
    fit: BoxFit.cover),
    ),
    ),
    placeholder: (context, url) =>
    CircularProgressIndicator(),
    errorWidget: (context, url, error) =>
    buildProfileImage(),
    ),
    );
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    }
    return Column(
    crossAxisAlignment:
    CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Center(
    child: Container(
    height: 20,
    width: 20,
    margin: EdgeInsets.all(5),
    child: CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor: AlwaysStoppedAnimation(
    Colors.white),
    ),
    ),
    ),
    ],
    );
    },
    ),
    SizedBox(
    width: 5,
    ),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    SizedBox(
    width: 2,
    ),
    FutureBuilder<userData>(
    future: userdata,
    builder: (BuildContext context,
    AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
    userData data = snapshot.data;
    return Text(
    '${data.name}',
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
    style: TextStyle(
    fontSize: 18,
    letterSpacing: 2,
    fontWeight: FontWeight.w900),
    );
    }
    return Column();
    }),
    // Text('Mark Ruffalo', textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 18,letterSpacing: 2,fontWeight: FontWeight.w900),),
    SizedBox(
    height: 2,
    ),
    Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Color(0xffC4C4C4),
    ),
    borderRadius: BorderRadius.circular(40),
    ),
    child: Row(
    children: [
    SizedBox(
    width: 5,
    ),
    Expanded(
    child: InkWell(
    onTap: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) =>
    CreatePostPage()));
    },
    child: Text(
    "Whats on your mind"))),
    InkWell(
    onTap: () => {},
    child: Icon(
    Icons.camera_alt_outlined,
    color: Colors.greenAccent,
    ),
    ),
    SizedBox(
    width: 2,
    ),
    InkWell(
    onTap: ()=> {},
    child: Icon(
    Icons.photo_library_rounded,
    color: Colors.redAccent,
    ),
    ),
    SizedBox(
    width: 2,
    ),
    InkWell(
    onTap: ()  {
    //  getData();

    //clearUserData();
    //getAdditionalData();

    //update();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoStream()));
    },
    child: Icon(
    Icons.photo_camera_front,
    color: Colors.blue,
    ),
    ),
    SizedBox(
    width: 2,
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    SizedBox(
    width: 5,
    ),
    ],
    ),
    Divider(
    color: Color(0xffC4C4C4),
    thickness: 6,
    ),
    ],
    ),
    ],
    ),
    ),
    Expanded(
    flex: 12,
    child: FutureBuilder<List<postData>>(
    future: data,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData == null) {
    return Container(
    child: Center(
    child: Text(
    'loading',
    ),
    ),
    );
    } else if (snapshot.hasData) {
    List<postData> data = snapshot.data;
    //print(data?.length);
    return ListView.builder(
    itemCount: data?.length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
    padding:
    const EdgeInsets.symmetric(vertical: 8.0),
    color: Colors.white,
    child:
    PostContainer(post: snapshot.data[index]),
    );
    });
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    }
    return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Center(
    child: Container(
    height: 20,
    width: 20,
    margin: EdgeInsets.all(5),
    child: CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor:
    AlwaysStoppedAnimation(Colors.white),
    ),
    ),
    ),
    ],
    );
    },
    ),
    ),
    ],
    ),
    ),
    bottomNavigationBar: BottomNavigation(0),
    ),
    ),


      );

  }

  Future<void> onJoin({ bool isBroadcaster}) async {
    await [Permission.camera, Permission.microphone].request();

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => BroadcastPage(
    //       channelName: 'abc',
    //       isBroadcaster: isBroadcaster,
    //     ),
    //   ),
    // );
  }

  _showImageDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Edit post'),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }));
  }
}

