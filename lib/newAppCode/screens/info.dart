import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/screens/friends.dart';
import '../Api/logout_api.dart';
import '../Messaging/main.dart';
import '../Start/login.dart';
import '../Messaging/message.dart';
import 'package:flutter_svg/svg.dart';
import '../Navigation/bottomNavigationBar.dart';

class info extends StatefulWidget {
  const info({Key key}) : super(key: key);

  @override
  _infoState createState() => _infoState();
}

// ignore: camel_case_types
class _infoState extends State<info> {

   SharedPreferences user,SignupData;
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }
  void initialGetsavedData() async{
    user=await SharedPreferences.getInstance();
    SignupData=await SharedPreferences.getInstance();
  }
  Future<void> RemoveAll() async{
    user.remove('userId');
    user.remove('email');
    user.remove('pass');
    SignupData.remove('userName');
    SignupData.remove('userEmail');
    SignupData.remove('userPassword');
  }

  static double iconeWidth = 25;
  static double iconesHeight = 25;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body:Container(
        width: width,
        height: height,
        child: Scaffold(
          body: Container(
            color:  Color(0xffCC9B00),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child:Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child:Image(
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
                Expanded(
                  flex: 20,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: TextDirection.ltr,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Info', textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Color(0xffC4C4C4), thickness: 2,),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                            child: Container(
                                      height: 100,
                                      width: (width/2)-40,
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
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => friends()));
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10,),
                                            Text("Groups" ,style: TextStyle(fontSize:20,color: Colors.black, fontFamily: 'Montserrat',fontWeight: FontWeight.w900)),
                                          ],
                                        ),
                                      ),
                                    )
                            ),
                            Expanded(
                                child: Container(
                                  height: 100,
                                  width: (width/2)-40,
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
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => friends()));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10,),
                                        Text("Friends" ,style: TextStyle(fontSize:20,color: Colors.black, fontFamily: 'Montserrat',fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                      child: Row(
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
                                showDialog(
                                  builder: (context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                            "Are you sure you want to logout?"),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              RemoveAll();
                                              final body = {'logout':"logout"};
                                              ApiService.logout(body).then((success){
                                                if(success){
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                                }
                                              });
                                            },
                                            child: Text('Logout',style: TextStyle(color: Color(0xffCC9B00)),),
                                          ),
                                        ],
                                      ),
                                  context: context,
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //SizedBox(width: 15,),
                                  Text("Log out",textAlign: TextAlign.center ,style: TextStyle(fontSize:20,color: Colors.red, fontFamily: 'Montserrat',fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                  ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(4),
        ),
      ),
    );

  }
}