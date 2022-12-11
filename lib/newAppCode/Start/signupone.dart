import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/Start/signuptwo.dart';

import '../../Controller/user_cntroller.dart';
import '../my_flutter_app_icons.dart';

class SignUpOne extends StatefulWidget {
  const SignUpOne({Key key}) : super(key: key);

  @override
  _SignUpOneState createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne>{
  UserController userController = Get.put(UserController());
  final TextStyle _textInputStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  final TextStyle _hintStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  TextEditingController fname = new TextEditingController(text: "");
  TextEditingController lname = new TextEditingController(text: "");
  TextEditingController email = new TextEditingController(text: "");
  TextEditingController password = new TextEditingController(text: "");
  TextEditingController C_password = new TextEditingController(text: "");

   SharedPreferences SignupData;
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }
  void initialGetsavedData() async{
    SignupData=await SharedPreferences.getInstance();
  }
  final test=null;
  Future<void> saveUserSignUpOneData(String name,String email,String pass) async{
    const keyUserName='userName';
    const keyUserEmail='userEmail';
    const keyUserPass='userPassword';
    SignupData.setString(keyUserName, name);
    SignupData.setString(keyUserEmail, email);
    SignupData.setString(keyUserPass, pass);
  }




  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery
        .of(context)
        .size
        .width;
    double height1 = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Color(0xff8C6B00),
      body: GetBuilder<UserController>(
        builder: (_) {
          return Container(
            child: SingleChildScrollView(
              child: Form(
                //key: _.formKeySignUp,
                child:
                Container(
                  width: width1,
                  height: height1,
                child:Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child:Container(
                          child:Image(
                            alignment: Alignment.topCenter,
                            height: 180,
                            width: 100,
                            image: AssetImage('assets/logo.png'),
                          )
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height-200,
                        width: width1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                              child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35,fontFamily: 'Montserrat'),),
                            ),
                            SizedBox(height: 30),
                            Container(
                              //padding:EdgeInsets.only(left: 120,right: 120),
                              height: 44,
                              width: 960,
                              child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(child:Container(
                                        height: 44,
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
                                          child: new TextField(
                                            controller: fname,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Color(0xffCC9B00),
                                                ),
                                                contentPadding: EdgeInsets.all(13),
                                                hintText: 'First Name',
                                                hintStyle: _textInputStyle,
                                              )
                                          ),
                                      ),),
                                      //SizedBox(width: 5,),
                                      Expanded(child: Container(
                                        height: 44,
                                        //margin: EdgeInsets.symmetric(horizontal: 20),
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
                                          child: new TextField(
                                            controller: lname,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.all(13),
                                                hintText: 'Last Name',
                                                hintStyle: _textInputStyle,
                                              )
                                          ),
                                      ),),
                                      SizedBox(width: 20,),
                                ],
                              ),
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
                              child: TextFormField(
                                controller: email,
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
                                controller: C_password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.vpn_key_sharp,
                                    color: Color(0xffCC9B00),
                                  ),
                                  contentPadding: EdgeInsets.all(13),
                                  hintText: 'Confirm Password',
                                  hintStyle: _textInputStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              child: MaterialButton(
                                height: 44,
                                minWidth: 220,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                color: Color(0xffCC9B00),
                                onPressed: ()  {


                                  // final FormState formState =
                                  //     _.formKeySignUp.currentState;
                                  // if (formState.validate())
                                  //
                                  // {


                                    print('Form is validate');
                                    // if (_.userData.dob != null) {
                                    if(password.text==C_password.text&&password.text!=''&&C_password.text!=''){
                                      saveUserSignUpOneData(fname.text+" "+lname.text,email.text,password.text);
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpTwo()));

                                    // } else {
                                    //    Get.snackbar('Date Of Birth',
                                    //        'Please Select Date of Birth',
                                    //        colorText: Colors.black,
                                    //        backgroundColor: Colors.red);
                                    //}
                                  }

                                  else{
                                    showDialog(
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                      title: Text("Password did not match"),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        )
                                      ],
                                    ), context: context,);
                                }
                                },
                                child: Text('Next', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Montserrat')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          );
        }, // This trailing comma makes auto-formatting nicer for build methods.
      )

      // Container(
      //   width: width1,
      //   height: height1,
      // child:Stack(
      //   children: [
      //     Positioned(
      //       top: 0,
      //       right: 0,
      //       left: 0,
      //       child:Container(
      //           child:Image(
      //             alignment: Alignment.topCenter,
      //             height: 180,
      //             width: 100,
      //             image: AssetImage('assets/logo.png'),
      //           )
      //       ),
      //     ),
      //     Positioned(
      //       top: 200,
      //       right: 0,
      //       left: 0,
      //       bottom: 0,
      //       child: Container(
      //         height: MediaQuery.of(context).size.height-200,
      //         width: width1,
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(50),
      //               topRight: Radius.circular(50)
      //           ),
      //         ),
      //         child: SingleChildScrollView(
      //           child: Column(
      //           children: [
      //             SizedBox(height: 25),
      //             Container(
      //               child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35,fontFamily: 'Montserrat'),),
      //             ),
      //             SizedBox(height: 30),
      //             Container(
      //               //padding:EdgeInsets.only(left: 120,right: 120),
      //               height: 44,
      //               width: 960,
      //               child: Row(
      //                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       Expanded(child:Container(
      //                         height: 44,
      //                         margin: EdgeInsets.symmetric(horizontal: 20),
      //                         decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(5),
      //                           boxShadow: [
      //                             BoxShadow(
      //                               color: Colors.black.withOpacity(0.3),
      //                               spreadRadius: 3,
      //                               blurRadius: 3,
      //                               // offset: const Offset(0, 10),
      //                             ),
      //                           ],
      //                         ),
      //                           child: new TextField(
      //                             controller: fname,
      //                               decoration: InputDecoration(
      //                                 border: InputBorder.none,
      //                                 prefixIcon: Icon(
      //                                   Icons.person,
      //                                   color: Color(0xffCC9B00),
      //                                 ),
      //                                 contentPadding: EdgeInsets.all(13),
      //                                 hintText: 'First Name',
      //                                 hintStyle: _textInputStyle,
      //                               )
      //                           ),
      //                       ),),
      //                       //SizedBox(width: 5,),
      //                       Expanded(child: Container(
      //                         height: 44,
      //                         //margin: EdgeInsets.symmetric(horizontal: 20),
      //                         decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(5),
      //                           boxShadow: [
      //                             BoxShadow(
      //                               color: Colors.black.withOpacity(0.3),
      //                               spreadRadius: 3,
      //                               blurRadius: 3,
      //                               // offset: const Offset(0, 10),
      //                             ),
      //                           ],
      //                         ),
      //                           child: new TextField(
      //                             controller: lname,
      //                               decoration: InputDecoration(
      //                                 border: InputBorder.none,
      //                                 contentPadding: EdgeInsets.all(13),
      //                                 hintText: 'Last Name',
      //                                 hintStyle: _textInputStyle,
      //                               )
      //                           ),
      //                       ),),
      //                       SizedBox(width: 20,),
      //                 ],
      //               ),
      //             ),
      //             SizedBox(height: 30),
      //             Container(
      //               height: 44,
      //               width: 920,
      //               margin: EdgeInsets.symmetric(horizontal: 20),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(5),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.black.withOpacity(0.3),
      //                     spreadRadius: 3,
      //                     blurRadius: 3,
      //                     // offset: const Offset(0, 10),
      //                   ),
      //                 ],
      //               ),
      //               child: TextField(
      //                 controller: email,
      //                 decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                   prefixIcon: Icon(
      //                     Icons.email_sharp,
      //                     color: Color(0xffCC9B00),
      //                   ),
      //                   contentPadding: EdgeInsets.all(13),
      //                   hintText: 'e-mail',
      //                   hintStyle: _textInputStyle,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 30),
      //             Container(
      //               height: 44,
      //               width: 920,
      //               margin: EdgeInsets.symmetric(horizontal: 20),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(5),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.black.withOpacity(0.3),
      //                     spreadRadius: 3,
      //                     blurRadius: 3,
      //                     // offset: const Offset(0, 10),
      //                   ),
      //                 ],
      //               ),
      //               child: TextField(
      //                 controller: password,
      //                 decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                   prefixIcon: Icon(
      //                     Icons.vpn_key_rounded,
      //                     color: Color(0xffCC9B00),
      //                   ),
      //                   contentPadding: EdgeInsets.all(13),
      //                   hintText: 'Password',
      //                   hintStyle: _hintStyle,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 30),
      //             Container(
      //               height: 44,
      //               width: 920,
      //               margin: EdgeInsets.symmetric(horizontal: 20),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(5),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.black.withOpacity(0.3),
      //                     spreadRadius: 3,
      //                     blurRadius: 3,
      //                     // offset: const Offset(0, 10),
      //                   ),
      //                 ],
      //               ),
      //               child: TextField(
      //                 controller: C_password,
      //                 decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                   prefixIcon: Icon(
      //                     Icons.vpn_key_sharp,
      //                     color: Color(0xffCC9B00),
      //                   ),
      //                   contentPadding: EdgeInsets.all(13),
      //                   hintText: 'Confirm Password',
      //                   hintStyle: _textInputStyle,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 30),
      //             Container(
      //               child: MaterialButton(
      //                 height: 44,
      //                 minWidth: 220,
      //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      //                 color: Color(0xffCC9B00),
      //                 onPressed: (){
      //                   if(password.text==C_password.text&&password.text!=''&&C_password.text!=''){
      //                     saveUserSignUpOneData(fname.text+" "+lname.text,email.text,password.text);
      //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpTwo()));
      //                   }
      //                   else{
      //                     showDialog(
      //                         builder: (context) => AlertDialog(
      //                           backgroundColor: Colors.white,
      //                       title: Text("Password did not match"),
      //                       actions: <Widget>[
      //                         FlatButton(
      //                           onPressed: () {
      //                             Navigator.pop(context);
      //                           },
      //                           child: Text('OK'),
      //                         )
      //                       ],
      //                     ), context: context,);
      //                 }
      //                 },
      //                 child: Text('Next', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Montserrat')),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     ),
      //   ],
      // ),
      // ),
    );
  }
}
