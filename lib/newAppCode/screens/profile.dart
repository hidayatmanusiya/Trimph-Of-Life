import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/showBioToUser_api.dart';
import 'package:triumph_life_ui/newappcode/Api/viewCoverPic_api.dart';
import 'package:triumph_life_ui/newappcode/Api/viewProfilePic_api.dart';
import 'package:triumph_life_ui/newappcode/Data/profilePicData.dart';
import 'package:triumph_life_ui/newappcode/Data/userData.dart';
import 'package:triumph_life_ui/newappcode/Models/post_model.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/screens/editInfo.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import '../Messaging/main.dart';
import '../Messaging/message.dart';
import 'package:flutter_svg/svg.dart';
import '../Navigation/bottomNavigationBar.dart';
import '../Data/data.dart';

class profile extends StatefulWidget {
  const profile({Key key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {

   SharedPreferences user;
  int id;
  dynamic profiledata,coverdata,userdata;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }

  void initialGetsavedData() async {
    user = await SharedPreferences.getInstance();
    id=user.getInt('userId');
    final  body={'showprofile':'show',"user_id":'${id}'};
    final  body1={'showcoverpic':'show',"user_id":'${id}'};
    final  body2={'view':'view',"user_id":'${id}'};
    setState(() {
      profiledata=ApiServices.viewProfilePic(body);
      coverdata=ApiService_cover.viewCoverPic(body1);
      userdata=ApiService_userData.showBioToUser(body2);
    });
  }

  Future<int> getUserId() async {
    return user.getInt('userId');
  }
  final double coverheight=148;
  final double profileheight=114;

  @override
  Widget build(BuildContext context) {
    final double top=coverheight-profileheight/2;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Scaffold(
          body: Container(
            color: Color(0xffCC9B00),
            child: Column(
              mainAxisSize : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 70,
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
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
                            child:InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp_()));
                                },
                                child:Image(
                                  alignment: Alignment.topRight,
                                  height: 53.97,
                                  width: 96,
                                  image: AssetImage('assets/chat.png'),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 23,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child:Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: width,
                                margin: EdgeInsets.only(bottom: profileheight/2),
                                child: FutureBuilder <profilePicData>(
                                  future: coverdata,
                                  builder: (BuildContext context,AsyncSnapshot snapshot) {
                                    if(snapshot.hasData==null){
                                      return Container(
                                        child: Center(
                                          child: Text('loading',),
                                        ),
                                      );
                                    }
                                    else if (snapshot.hasData) {
                                      profilePicData data = snapshot.data;
                                      return ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                        child:CachedNetworkImage(
                                            imageUrl: data.path.toString()+data.cover_pic.toString(),
                                            imageBuilder: (context, imageProvider) => Container(
                                              width: 80.0,
                                              height: coverheight,
                                              decoration: BoxDecoration(
                                                //shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider, fit: BoxFit.fitHeight),
                                              ),
                                            ),
                                            placeholder: (context, url) => CircularProgressIndicator(),
                                            errorWidget: (context, url, error) => buildCoverImage()
                                        ),
                                        //child: CachedNetworkImage(imageUrl:posts[0].imageUrl,height: coverheight,fit: BoxFit.fill,),
                                      );
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
                                              valueColor : AlwaysStoppedAnimation(Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  top: top,
                                  child: Row(
                                    children: [
                                      FutureBuilder <profilePicData>(
                                        future: profiledata,
                                        builder: (BuildContext context,AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            profilePicData data = snapshot.data;
                                            return CircleAvatar(
                                              radius: profileheight/2,
                                              //backgroundImage: AssetImage('assets/images.jpg'),
                                              child:CachedNetworkImage(
                                                imageUrl: data.path.toString()+data.Profile_pic.toString(),
                                                imageBuilder: (context, imageProvider) => Container(
                                                  width: profileheight,
                                                  height: profileheight,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider, fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => buildProfileImage(),
                                              ),
                                            );
                                          }
                                          return CircleAvatar(
                                            radius: profileheight/2,
                                            backgroundImage: AssetImage('assets/images.jpg'),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      //buildProfileImage(),
                                      SizedBox(width: 5),
                                      FutureBuilder <userData>(
                                          future: userdata,
                                          builder:(BuildContext context,AsyncSnapshot snapshot){
                                            if (snapshot.hasData) {
                                              userData data = snapshot.data;
                                              return Column(
                                                children: [
                                                  SizedBox(height: 50),
                                                  Text("${data?.name}",textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 24,letterSpacing: 1,fontWeight: FontWeight.w600),),
                                                ],);
                                            }
                                            return Column();
                                          }
                                          )
                                    ],
                                  )
                              ),
                            ],
                          ),
                          Divider(color: Color(0xffC4C4C4), thickness: 1,),
                          FutureBuilder <userData>(
                            future: userdata,
                            builder: (BuildContext context,AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                userData data = snapshot.data;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('  About',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w800),),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 20,),
                                        Icon(Icons.location_on_rounded, color: Color(0xffCC9B00),),
                                        Text('  ${data?.state},${data.country}',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 15,letterSpacing: 1,color: Colors.black),),
                                        SizedBox(width: 30,),
                                        Icon(Icons.transgender, color: Color(0xffCC9B00),),
                                        Text('  ${data.gender}',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 15,letterSpacing: 1,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 20,),
                                        Icon(Icons.calendar_today_outlined, color: Color(0xffCC9B00),),
                                        Text('  Born on ${data.dob}',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 15,letterSpacing: 1,color: Colors.black),),
                                        SizedBox(width: 30,),
                                        Icon(Icons.shopping_bag_sharp, color: Color(0xffCC9B00),),
                                        Text('  ${data.profession}',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 15,letterSpacing: 1,color: Colors.black),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Divider(color: Color(0xffC4C4C4), thickness: 1,),
                                    Text('  Photos/Uploads',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w800),),
                                    SizedBox(height: 80,),
                                    Divider(color: Color(0xffC4C4C4), thickness: 1,),
                                    Text('  Friends',textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w800),),
                                    SizedBox(height: 80,),
                                    Row(
                                      mainAxisAlignment:  MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 38,
                                          margin: EdgeInsets.symmetric(horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 3,
                                                // offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child:InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
                                            },
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                //SizedBox(width: 15,),
                                                Text("Edit Profile",textAlign: TextAlign.center ,style: TextStyle(fontSize:17,color: Colors.black, fontFamily: 'Montserrat',fontWeight: FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                );
                              }
                              return Column();
                            },
                          ),

                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(2),
        ),
      ),
    );
  }
  Widget buildCoverImage()=> ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50),
    ),
    child:  Image.asset('assets/black.jpg',fit: BoxFit.fill,height: coverheight), key: null,
    //child: CachedNetworkImage(imageUrl:posts[0].imageUrl,height: coverheight,fit: BoxFit.fill,),
  );

  Widget buildProfileImage()=> CircleAvatar(
    radius: profileheight/2,
    backgroundImage: AssetImage('assets/images.jpg'),
    //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
  );

  Widget profileName()=> Column(
    children: [
      SizedBox(height: 50),
      Text("Mark Ruffalo",textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 24,letterSpacing: 1,fontWeight: FontWeight.w600),),
    ],);

  _showImageDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () {

                },
              ),
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () {

                },
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
