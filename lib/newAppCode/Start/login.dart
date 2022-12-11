import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/screens/homeScreen.dart';
import 'package:triumph_life_ui/newappcode/Start/signupone.dart';
import '../Api/login_api.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  UserController userController = Get.put(UserController());
   SharedPreferences user;
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
  }

   Future updateToken(String uid) async {
     FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
     await firebaseMessaging.requestPermission(
       alert: true,
       announcement: false,
       badge: true,
       carPlay: false,
       criticalAlert: false,
       provisional: false,
       sound: true,
     );
     firebaseMessaging.subscribeToTopic("Topic");
     String token = await firebaseMessaging.getToken();
     firebaseFirestore
         .collection('Users')
         .doc(uid)
         .update({"token": token}).then((value) {
       //loader.loadingDismiss();
      // update();
       Get.to(homeScreen());
     });
   }
  Future<void> saveUserId(int id) async{
    const keyUserId='userId';
    String tempAge = id.toString();
   // updateToken(tempAge);
    user.setInt(keyUserId, id);
  }
  Future<void> saveUserEmail(String email) async{
    const keyUserId='email';
    user.setString(keyUserId, email);
  }
  Future<void> saveUserPassword(String pass) async{
    const keyUserId='pass';
    user.setString(keyUserId, pass);
  }

  String url ="http://triumph.worldviewit.com/demo/api/login.php";
  final TextStyle _textInputStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  final TextStyle _hintStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  TextEditingController email1 = new TextEditingController(text: "");
  TextEditingController password = new TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery.of(context).size.width;
    double height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff8C6B00),

    body: GetBuilder<UserController>(
      builder: (_) {
        return Form(
        //  key: _.formKeyLogin,
          child:  Container(
                width: width1,
              height: height1,
              child:Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
              child:Container(
                    child:Container(
                      child:Image(
                        alignment: Alignment.topCenter,
                        height: 280,
                        width: 200,
                        image: AssetImage('assets/logo.png'),
                      )
                    ),
                  ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(
                      width: width1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                        ),
                      ),
                        child:SingleChildScrollView(
                        child:Padding(
                          padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                              child: Text('Login',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35,fontFamily: 'Montserrat'),),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 44,
                              width: 920,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    // offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextField(
                               // obscureText: true,
                                controller: email1,


                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.email_sharp,
                                      color: Color(0xffCC9B00),
                                    ),
                                  contentPadding: EdgeInsets.all(13),
                                  hintText: 'e-mail',
                                  hintStyle: _textInputStyle,
                                ),


                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              height: 44,
                              width: 920,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    // offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextField(
                               // obscureText: true,
                                controller: password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.vpn_key_rounded,
                                    color: Color(0xffCC9B00),
                                  ),
                                  contentPadding: EdgeInsets.all(13),
                                  hintText: 'Password',
                                  hintStyle: _hintStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              child: MaterialButton(
                                height: 38,
                                minWidth: 170,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                color: Color(0xffCC9B00),
                                onPressed: ()async
                                {
                                  saveUserEmail(email1.text);
                                  saveUserPassword(password.text);
                                  final body = {'sign':"sign", "Email": email1.text, "Pass": password.text,};
                                  if(email1.text==''||password.text==''){
                                    showDialog(
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text('Please Enter email or password'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'),
                                          )
                                        ],
                                      ),
                                      context: context,
                                    );
                                  }
                                  else{
                                    userController.signIn();
                                    //_.signIn();
                                    // ApiService_login.login(body).then((success) async {
                                    //   //print(success);
                                    //   if (success > 0) {
                                    //     saveUserId(success);
                                    //     print(success);
                                    //     // Get.to(homeScreen());
                                    //     // _.signIn();
                                    //   }
                                    // });

                                // //loader.loadingShow();
                                // // userCredential = await firebaseAuth.signInWithEmailAndPassword(
                                // // email: email1.text,
                                // // password: "123456789");
                                // // currentUserId = userCredential.user.uid.toString();
                                // //         updateToken(currentUserId);
                                //           //Navigator.of(context).push(MaterialPageRoute(builder: (context) => H()));
                                //       }
                                //       else{
                                //         if(success==-999)
                                //         {
                                //           showDialog(
                                //             builder: (context) => AlertDialog(
                                //               backgroundColor: Colors.white,
                                //               title: Text('Incorrect email or password'),
                                //               actions: <Widget>[
                                //                 FlatButton(
                                //                   onPressed: () {
                                //                     Navigator.pop(context);
                                //                   },
                                //                   child: Text('OK'),
                                //                 )
                                //               ],
                                //             ),
                                //             context: context,
                                //           );
                                //         }
                                //         else{
                                //           if(success==-888) {
                                //             showDialog(
                                //               builder: (context) => AlertDialog(
                                //                 backgroundColor: Colors.white,
                                //                 title: Text('User Not Logged In'),
                                //                 actions: <Widget>[
                                //                   FlatButton(
                                //                     onPressed: () {
                                //                       Navigator.pop(context);
                                //                     },
                                //                     child: Text('OK'),
                                //                   )
                                //                 ],
                                //               ),
                                //               context: context,
                                //             );
                                //           }
                                //           else{
                                //             if(success==-7){
                                //               showDialog(
                                //                 builder: (context) => AlertDialog(
                                //                   backgroundColor: Colors.white,
                                //                   title: Text('Incorrect credentials'),
                                //                   actions: <Widget>[
                                //                     FlatButton(
                                //                       onPressed: () {
                                //                         Navigator.pop(context);
                                //                       },
                                //                       child: Text('OK'),
                                //                     )
                                //                   ],
                                //                 ),
                                //                 context: context,
                                //               );
                                //             }
                                //           }
                                //         }
                                //       }
                                //
                                //     });
                                  }
                                },

                                child: Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Montserrat')),
                              ),
                            ),
                            SizedBox(height: 5),
                            InkWell(
                              onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Forgot Password?" ,style: TextStyle(color: Colors.black.withOpacity(0.7), fontFamily: 'Montserrat')),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
                              },
                              child: Container(
                                height: 44,
                                width: 920,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      // offset: const Offset(0, 10),
                                    ),
                                  ],
                               //   borderRadius: BorderRadius.circular(5),
                                 // color: Color(0xffC21D1D),
                                ),
                                // child: Row(
                                //   children: [
                                //     SizedBox(width: 10,),
                                //     Icon(
                                //       Icons.mail,
                                //       color: Colors.white,
                                //     ),
                                //     SizedBox(width: 20,),
                                //     Text('Login with Gmail',style: TextStyle(color: Colors.white),),
                                //   ],
                                // ),
                              ),
                            ),
                            SizedBox(height: 15),
                            InkWell(
                              onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
                              },
                              child: Container(
                                height: 44,
                                width: 920,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      // offset: const Offset(0, 10),
                                    ),
                                  ],
                                // borderRadius: BorderRadius.circular(5),
                                  //color: Color(0xff00479A),
                                ),
                                // child: Row(
                                //   children: [
                                //     SizedBox(width:10 ,),
                                //     Icon(
                                //       Icons.facebook_sharp,
                                //       color: Colors.white,
                                //     ),
                                //     SizedBox(width:20,),
                                //     Text('Login with Facebook',style: TextStyle(color: Colors.white),),
                                //   ],
                                // ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have account?" ,style: TextStyle(color: Colors.black, fontFamily: 'Montserrat')),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpOne()));
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sign up" ,style: TextStyle(color: Color(0xffCC9B00), fontFamily: 'SourceSansPro-Regular')),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  ),
                  ),
                ],
              ),
            ),
        );
      },
    )
    //   body: Container(
    //     width: width1,
    //   height: height1,
    //   child:Column(
    //     children: <Widget>[
    //       Expanded(
    //         flex: 5,
    //   child:Container(
    //         child:Container(
    //           child:Image(
    //             alignment: Alignment.topCenter,
    //             height: 280,
    //             width: 200,
    //             image: AssetImage('assets/logo.png'),
    //           )
    //         ),
    //       ),
    //       ),
    //       Expanded(
    //         flex: 20,
    //         child: Container(
    //           width: width1,
    //           decoration: const BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(50),
    //               topRight: Radius.circular(50)
    //             ),
    //           ),
    //             child:SingleChildScrollView(
    //             child:Padding(
    //               padding: EdgeInsets.all(20),
    //             child: Column(
    //               children: [
    //                 SizedBox(height: 25),
    //                 Container(
    //                   child: Text('Login',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35,fontFamily: 'Montserrat'),),
    //                 ),
    //                 SizedBox(height: 30),
    //                 Container(
    //                   height: 44,
    //                   width: 920,
    //                   margin: EdgeInsets.symmetric(horizontal: 20),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(5),
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.black.withOpacity(0.3),
    //                         spreadRadius: 3,
    //                         blurRadius: 3,
    //                         // offset: const Offset(0, 10),
    //                       ),
    //                     ],
    //                   ),
    //                   child: TextField(
    //                     controller: email1,
    //                     decoration: InputDecoration(
    //                       border: InputBorder.none,
    //                         prefixIcon: Icon(
    //                           Icons.email_sharp,
    //                           color: Color(0xffCC9B00),
    //                         ),
    //                       contentPadding: EdgeInsets.all(13),
    //                       hintText: 'e-mail',
    //                       hintStyle: _textInputStyle,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 25),
    //                 Container(
    //                   height: 44,
    //                   width: 920,
    //                   margin: EdgeInsets.symmetric(horizontal: 20),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(5),
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.black.withOpacity(0.3),
    //                         spreadRadius: 3,
    //                         blurRadius: 3,
    //                         // offset: const Offset(0, 10),
    //                       ),
    //                     ],
    //                   ),
    //                   child: TextField(
    //                     controller: password,
    //                     decoration: InputDecoration(
    //                       border: InputBorder.none,
    //                       prefixIcon: Icon(
    //                         Icons.vpn_key_rounded,
    //                         color: Color(0xffCC9B00),
    //                       ),
    //                       contentPadding: EdgeInsets.all(13),
    //                       hintText: 'Password',
    //                       hintStyle: _hintStyle,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 25),
    //                 Container(
    //                   child: MaterialButton(
    //                     height: 38,
    //                     minWidth: 170,
    //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //                     color: Color(0xffCC9B00),
    //                     onPressed: ()async
    //                     {
    //                       saveUserEmail(email1.text);
    //                       saveUserPassword(password.text);
    //                       final body = {'sign':"sign", "Email": email1.text, "Pass": password.text,};
    //                       if(email1.text==''||password.text==''){
    //                         showDialog(
    //                           builder: (context) => AlertDialog(
    //                             backgroundColor: Colors.white,
    //                             title: Text('Please Enter email or password'),
    //                             actions: <Widget>[
    //                               FlatButton(
    //                                 onPressed: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 child: Text('OK'),
    //                               )
    //                             ],
    //                           ),
    //                           context: context,
    //                         );
    //                       }
    //                       else{
    //                         ApiService.login(body).then((success) async {
    //                           //print(success);
    //                           if (success>0) {
    //
    //                             saveUserId(success);
    //
    //                             UserCredential userCredential;
    //                             String currentUserId;
    //
    //                     //loader.loadingShow();
    //                     userCredential = await firebaseAuth.signInWithEmailAndPassword(
    //                     email: email1.text,
    //                     password: "123456789");
    //                     currentUserId = userCredential.user.uid.toString();
    //                             updateToken(currentUserId);
    //                               //Navigator.of(context).push(MaterialPageRoute(builder: (context) => H()));
    //                           }
    //                           else{
    //                             if(success==-999)
    //                             {
    //                               showDialog(
    //                                 builder: (context) => AlertDialog(
    //                                   backgroundColor: Colors.white,
    //                                   title: Text('Incorrect email or password'),
    //                                   actions: <Widget>[
    //                                     FlatButton(
    //                                       onPressed: () {
    //                                         Navigator.pop(context);
    //                                       },
    //                                       child: Text('OK'),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 context: context,
    //                               );
    //                             }
    //                             else{
    //                               if(success==-888) {
    //                                 showDialog(
    //                                   builder: (context) => AlertDialog(
    //                                     backgroundColor: Colors.white,
    //                                     title: Text('User Not Logged In'),
    //                                     actions: <Widget>[
    //                                       FlatButton(
    //                                         onPressed: () {
    //                                           Navigator.pop(context);
    //                                         },
    //                                         child: Text('OK'),
    //                                       )
    //                                     ],
    //                                   ),
    //                                   context: context,
    //                                 );
    //                               }
    //                               else{
    //                                 if(success==-7){
    //                                   showDialog(
    //                                     builder: (context) => AlertDialog(
    //                                       backgroundColor: Colors.white,
    //                                       title: Text('Incorrect credentials'),
    //                                       actions: <Widget>[
    //                                         FlatButton(
    //                                           onPressed: () {
    //                                             Navigator.pop(context);
    //                                           },
    //                                           child: Text('OK'),
    //                                         )
    //                                       ],
    //                                     ),
    //                                     context: context,
    //                                   );
    //                                 }
    //                               }
    //                             }
    //                           }
    //
    //                         });
    //                       }
    //                     },
    //
    //                     child: Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Montserrat')),
    //                   ),
    //                 ),
    //                 SizedBox(height: 5),
    //                 InkWell(
    //                   onTap: (){
    //                     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
    //                   },
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Text("Forgot Password?" ,style: TextStyle(color: Colors.black.withOpacity(0.7), fontFamily: 'Montserrat')),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 20),
    //                 InkWell(
    //                   onTap: (){
    //                     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
    //                   },
    //                   child: Container(
    //                     height: 44,
    //                     width: 920,
    //                     margin: EdgeInsets.symmetric(horizontal: 20),
    //                     decoration: BoxDecoration(
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.black.withOpacity(0),
    //                           spreadRadius: 3,
    //                           blurRadius: 3,
    //                           // offset: const Offset(0, 10),
    //                         ),
    //                       ],
    //                    //   borderRadius: BorderRadius.circular(5),
    //                      // color: Color(0xffC21D1D),
    //                     ),
    //                     // child: Row(
    //                     //   children: [
    //                     //     SizedBox(width: 10,),
    //                     //     Icon(
    //                     //       Icons.mail,
    //                     //       color: Colors.white,
    //                     //     ),
    //                     //     SizedBox(width: 20,),
    //                     //     Text('Login with Gmail',style: TextStyle(color: Colors.white),),
    //                     //   ],
    //                     // ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 15),
    //                 InkWell(
    //                   onTap: (){
    //                     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => splashScreen()));
    //                   },
    //                   child: Container(
    //                     height: 44,
    //                     width: 920,
    //                     margin: EdgeInsets.symmetric(horizontal: 20),
    //                     decoration: BoxDecoration(
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.black.withOpacity(0),
    //                           spreadRadius: 3,
    //                           blurRadius: 3,
    //                           // offset: const Offset(0, 10),
    //                         ),
    //                       ],
    //                     // borderRadius: BorderRadius.circular(5),
    //                       //color: Color(0xff00479A),
    //                     ),
    //                     // child: Row(
    //                     //   children: [
    //                     //     SizedBox(width:10 ,),
    //                     //     Icon(
    //                     //       Icons.facebook_sharp,
    //                     //       color: Colors.white,
    //                     //     ),
    //                     //     SizedBox(width:20,),
    //                     //     Text('Login with Facebook',style: TextStyle(color: Colors.white),),
    //                     //   ],
    //                     // ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 15),
    //                 Container(
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Text("Don't have account?" ,style: TextStyle(color: Colors.black, fontFamily: 'Montserrat')),
    //                       InkWell(
    //                         onTap: (){
    //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpOne()));
    //                         },
    //                         child: Row(
    //                           children: [
    //                             Text("Sign up" ,style: TextStyle(color: Color(0xffCC9B00), fontFamily: 'SourceSansPro-Regular')),
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //       ),
    //       ),
    //       ),
    //     ],
    //   ),
    // ),
    );
  }
}