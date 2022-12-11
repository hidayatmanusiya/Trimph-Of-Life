import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Start/signupone.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import '../../Controller/user_cntroller.dart';
import '../Api/signup_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/models/userModel.dart';

class SignUpTwo extends StatefulWidget {

  const SignUpTwo({Key key}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {

  UserController userController = Get.put(UserController());
  static String name='', email='', password='';
  String datebirth;
  SharedPreferences SignupData;
  UserModel userData2 = UserModel();
  bool flag=false;
  DateTime selectedDate = DateTime.now();
  String url = "http://triumph.worldviewit.com/demo/api/signup.php";
  final TextStyle _textInputStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  final TextStyle _hintStyle = TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15, fontFamily: 'Montserrat');
  static  TextEditingController gender = new TextEditingController(text: "");
  static TextEditingController country = new TextEditingController(text: "");
  static TextEditingController state = new TextEditingController(text: "");
  static TextEditingController profession = new TextEditingController(text: "");


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }

  void initialGetsavedData() async {
    flag=false;
    SignupData = await SharedPreferences.getInstance();
    name = (SignupData.getString('userName') ?? '');
    email = (SignupData.getString('userEmail') ?? '');
    password = (SignupData.getString('userPassword') ?? '');

  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      helpText: "SELECT DATE OF BIRTH",
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2022),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffCC9B00), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.grey, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child,
        );
      },

    );
    if (selected != null && selected != selectedDate)
      setState(() {
        flag=true;
        print(flag);
        selectedDate = selected;
      });
    else{
      print(flag);
      flag=false;
    }
  }

  Future addUserData() async {
    String currentUserId;
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

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseMessaging.subscribeToTopic("Topic");
    String token = await firebaseMessaging.getToken();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    SharedPreferences data;
    data = await SharedPreferences.getInstance();
  //  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String pass = (SignupData.getString('pass') ?? '');

     try {
       var user = await firebaseAuth.createUserWithEmailAndPassword(
           email: email, password:pass);

       currentUserId = user.user.uid.toString();
       // update();

       // addUserData().then((val) {
       //   // loader.loadingDismiss();
       //   // Get.to(ChoosePhotoScreen());
       //   Get.snackbar('Success', 'Sign up SuccessFully');
       // });
     } catch (e) {
       // errorMessage = e.message;
       // loader.loadingDismiss();
       // update();
       Get.snackbar('Error', e.message);
     }


    // String user_id = (data.getString('userId') ?? '');

     FirebaseFirestore.instance.collection('Users').doc(currentUserId).set(
       {
         'FirstName': name.toString(),
         'Country': country.text.toString(),
         'UserId': currentUserId,
         'Email': email,
         'DOB': "23-12-1991",
        // 'DOB': selectedDate.day.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.year.toString(),
         'Gender': gender.text.toString(),
         "JoinOn": "",
         "LastName": name.toString(),
         "Profession": profession.text.toString(),
         "State": state.text.toString(),
         "CoverPhoto": "",
         "ProfilePhoto": "",
         "token": token,
       },
     );





     return true;
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
                  // key: _.formKeySignUp,
                  child:
                  Container(
                    width: width1,
                    height: height1,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                              child: Image(
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
                            height: MediaQuery
                                .of(context)
                                .size
                                .height - 200,
                            width: width1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)
                              ),
                            ),
                            child: SingleChildScrollView(
                              child:Column(
                                children: [
                                  SizedBox(height: 15),
                                  Container(
                                    child: Text('Sign Up', style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 35,
                                        fontFamily: 'Montserrat'),),
                                  ),
                                  SizedBox(height: 15),
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
                                      controller: gender,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.transgender,
                                          color: Color(0xffCC9B00),
                                        ),
                                        contentPadding: EdgeInsets.all(13),
                                        hintText: 'Gender',
                                        hintStyle: _textInputStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      height: 44,
                                      width: 920,
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.perm_contact_calendar_sharp,
                                            color: Color(0xffCC9B00),
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Date of Birth', style: TextStyle(
                                              color: Colors.black.withOpacity(0.3),
                                              fontSize: 13,
                                              fontFamily: 'Montserrat'),),
                                        ],
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    //padding:EdgeInsets.only(left: 120,right: 120),
                                    height: 44,
                                    width: width1,
                                    child: Row(

                                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // ElevatedButton(
                                        //   onPressed: () {
                                        //     _selectDate(context);
                                        //   },
                                        //   child: Text("Choose Date"),
                                        // ),
                                        //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                        Expanded(
                                          child: Container(
                                            height: 44,
                                            width: 60,
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
                                                onTap: (){
                                                  _selectDate(context);
                                                  setState(() {});
                                                },
                                                controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.day.toString()),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.all(13),
                                                  hintText: 'Day',
                                                  hintStyle: _textInputStyle,
                                                )
                                            ),
                                          ),),
                                        //SizedBox(width: 10,),
                                        Expanded(
                                          child: Container(
                                            height: 44,
                                            width: 60,
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
                                                onTap: (){
                                                  _selectDate(context);
                                                  setState(() {});
                                                },
                                                controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.month.toString()),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.all(13),
                                                  hintText: 'Month',
                                                  hintStyle: _textInputStyle,
                                                )
                                            ),
                                          ),),
                                        //SizedBox(width: 10,),
                                        Expanded(
                                          child: Container(
                                            height: 44,
                                            width: 100,
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
                                                onTap: (){
                                                  _selectDate(context);
                                                  setState(() {});
                                                },

                                                controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.year.toString()),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.all(13),
                                                  hintText: 'Year',
                                                  hintStyle: _textInputStyle,
                                                )
                                            ),
                                          ),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                      controller: country,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.location_on_rounded,
                                          color: Color(0xffCC9B00),
                                        ),
                                        contentPadding: EdgeInsets.all(13),
                                        hintText: 'Country',
                                        hintStyle: _textInputStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                      controller: state,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.location_on_rounded,
                                          color: Color(0xffCC9B00),
                                        ),
                                        contentPadding: EdgeInsets.all(13),
                                        hintText: 'State',
                                        hintStyle: _hintStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                      controller: profession,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.work_outline_outlined,
                                          color: Color(0xffCC9B00),
                                        ),
                                        contentPadding: EdgeInsets.all(13),
                                        hintText: 'Profession',
                                        hintStyle: _textInputStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: MaterialButton(
                                      height: 44,
                                      minWidth: 220,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      color: Color(0xffCC9B00),
                                      onPressed: () async {
                                        SignupData.setString("email_f", email.toString());
                                        SignupData.setString("password_f", password.toString());
                                        SignupData.setString("name_f", name.toString());
                                        SignupData.setString("gender_f", gender.text.toString());
                                        //String datebirth=selectedDate.day.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.year.toString()).toString()
                                        datebirth=selectedDate.day.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.year.toString();
                                        SignupData.setString("date_f", datebirth);
                                        SignupData.setString("country_f", country.text.toString());
                                        SignupData.setString("state_f", state.text.toString());
                                        SignupData.setString("profession_f", profession.text.toString());
                                        _.signUp();
                                        // ApiService.signup(body).then((success) {
                                        //   if (success.toInt() > 0) {
                                        //     // final FormState formState =
                                        //     //     _.formKeySignUp.currentState;
                                        //     // if (formState.validate())
                                        //     // {
                                        //     //   print('Form is validate');
                                        //     //   // if (_.userData.dob != null) {
                                        //     //   _.signUp();
                                        //     //   // } else {
                                        //     //   //    Get.snackbar('Date Of Birth',
                                        //     //   //        'Please Select Date of Birth',
                                        //     //   //        colorText: Colors.black,
                                        //     //   //        backgroundColor: Colors.red);
                                        //     //   //}
                                        //     // } else {
                                        //     //   print('Form is not Validate');
                                        //     // }
                                        //     //_.signUp();
                                        //
                                        //
                                        //     Get.snackbar('Success', 'Sign up SuccessFully');
                                        //
                                        //
                                        //
                                        //
                                        //     // addUserData();
                                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                        //   }
                                        //   else {
                                        //     if (success == -999) {
                                        //       showDialog(
                                        //         builder: (context) =>
                                        //             AlertDialog(
                                        //               backgroundColor: Colors.white,
                                        //               title: Text(
                                        //                   "System Error Try Again Later."),
                                        //               actions: <Widget>[
                                        //                 FlatButton(
                                        //                   onPressed: () {
                                        //                     Navigator.pop(context);
                                        //                   },
                                        //                   child: Text('OK'),
                                        //                 )
                                        //               ],
                                        //             ),
                                        //         context: context,
                                        //       );
                                        //     }
                                        //     else {
                                        //       if (success == -888) {
                                        //         showDialog(
                                        //           builder: (context) =>
                                        //               AlertDialog(
                                        //                 title: Text(
                                        //                     "Your Email Account Already Registered."),
                                        //                 actions: <Widget>[
                                        //                   FlatButton(
                                        //                     onPressed: () {
                                        //                       Navigator.of(context)
                                        //                           .push(
                                        //                           MaterialPageRoute(
                                        //                               builder: (
                                        //                                   context) =>
                                        //                                   SignUpOne()));
                                        //                     },
                                        //                     child: Text('OK'),
                                        //                   )
                                        //                 ],
                                        //               ),
                                        //           context: context,
                                        //         );
                                        //       }
                                        //       else{
                                        //         if(success==-7){
                                        //           showDialog(
                                        //             builder: (context) => AlertDialog(
                                        //               backgroundColor: Colors.white,
                                        //               title: Text('Incorrect credentials'),
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
                                        //       }
                                        //     }
                                        //   };
                                        // });
                                      },
                                      child: Text('Sign up', style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'Montserrat')),
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



      //
      // Container(
      //   width: width1,
      //   height: height1,
      //   child: Stack(
      //     children: [
      //       Positioned(
      //         top: 0,
      //         right: 0,
      //         left: 0,
      //         child: Container(
      //             child: Image(
      //               alignment: Alignment.topCenter,
      //               height: 180,
      //               width: 100,
      //               image: AssetImage('assets/logo.png'),
      //             )
      //         ),
      //       ),
      //       Positioned(
      //         top: 200,
      //         right: 0,
      //         left: 0,
      //         bottom: 0,
      //         child: Container(
      //           height: MediaQuery
      //               .of(context)
      //               .size
      //               .height - 200,
      //           width: width1,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(50),
      //                 topRight: Radius.circular(50)
      //             ),
      //           ),
      //           child: SingleChildScrollView(
      //             child:Column(
      //             children: [
      //               SizedBox(height: 15),
      //               Container(
      //                 child: Text('Sign Up', style: TextStyle(
      //                     fontWeight: FontWeight.w900,
      //                     fontSize: 35,
      //                     fontFamily: 'Montserrat'),),
      //               ),
      //               SizedBox(height: 15),
      //               Container(
      //                 height: 44,
      //                 width: 920,
      //                 margin: EdgeInsets.symmetric(horizontal: 20),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(5),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black.withOpacity(0.3),
      //                       spreadRadius: 3,
      //                       blurRadius: 3,
      //                       // offset: const Offset(0, 10),
      //                     ),
      //                   ],
      //                 ),
      //                 child: TextField(
      //                   controller: gender,
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     prefixIcon: Icon(
      //                       Icons.transgender,
      //                       color: Color(0xffCC9B00),
      //                     ),
      //                     contentPadding: EdgeInsets.all(13),
      //                     hintText: 'Gender',
      //                     hintStyle: _textInputStyle,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 10),
      //               Container(
      //                   height: 44,
      //                   width: 920,
      //                   margin: EdgeInsets.symmetric(horizontal: 20),
      //                   child: Row(
      //                     children: [
      //                       Icon(
      //                         Icons.perm_contact_calendar_sharp,
      //                         color: Color(0xffCC9B00),
      //                       ),
      //                       SizedBox(width: 10,),
      //                       Text('Date of Birth', style: TextStyle(
      //                           color: Colors.black.withOpacity(0.3),
      //                           fontSize: 13,
      //                           fontFamily: 'Montserrat'),),
      //                     ],
      //                   )
      //               ),
      //               SizedBox(height: 10),
      //               Container(
      //                 //padding:EdgeInsets.only(left: 120,right: 120),
      //                 height: 44,
      //                 width: width1,
      //                 child: Row(
      //
      //                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: <Widget>[
      //                     // ElevatedButton(
      //                     //   onPressed: () {
      //                     //     _selectDate(context);
      //                     //   },
      //                     //   child: Text("Choose Date"),
      //                     // ),
      //                     //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
      //                     Expanded(
      //                       child: Container(
      //                       height: 44,
      //                       width: 60,
      //                       margin: EdgeInsets.symmetric(horizontal: 20),
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(5),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black.withOpacity(0.3),
      //                             spreadRadius: 3,
      //                             blurRadius: 3,
      //                             // offset: const Offset(0, 10),
      //                           ),
      //                         ],
      //                       ),
      //                       child: new TextField(
      //                         onTap: (){
      //                           _selectDate(context);
      //                           setState(() {});
      //                           },
      //                           controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.day.toString()),
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.all(13),
      //                             hintText: 'Day',
      //                             hintStyle: _textInputStyle,
      //                           )
      //                       ),
      //                     ),),
      //                     //SizedBox(width: 10,),
      //                     Expanded(
      //                       child: Container(
      //                       height: 44,
      //                       width: 60,
      //                       margin: EdgeInsets.symmetric(horizontal: 20),
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(5),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black.withOpacity(0.3),
      //                             spreadRadius: 3,
      //                             blurRadius: 3,
      //                             // offset: const Offset(0, 10),
      //                           ),
      //                         ],
      //                       ),
      //                       child: new TextField(
      //                           onTap: (){
      //                             _selectDate(context);
      //                             setState(() {});
      //                           },
      //                           controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.month.toString()),
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.all(13),
      //                             hintText: 'Month',
      //                             hintStyle: _textInputStyle,
      //                           )
      //                       ),
      //                     ),),
      //                     //SizedBox(width: 10,),
      //                     Expanded(
      //                       child: Container(
      //                       height: 44,
      //                       width: 100,
      //                       margin: EdgeInsets.symmetric(horizontal: 20),
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(5),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black.withOpacity(0.3),
      //                             spreadRadius: 3,
      //                             blurRadius: 3,
      //                             // offset: const Offset(0, 10),
      //                           ),
      //                         ],
      //                       ),
      //                       child: new TextField(
      //                           onTap: (){
      //                             _selectDate(context);
      //                             setState(() {});
      //                           },
      //
      //                           controller: flag==false?TextEditingController(text: ''):TextEditingController(text: selectedDate.year.toString()),
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.all(13),
      //                             hintText: 'Year',
      //                             hintStyle: _textInputStyle,
      //                           )
      //                       ),
      //                     ),),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Container(
      //                 height: 44,
      //                 width: 920,
      //                 margin: EdgeInsets.symmetric(horizontal: 20),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(5),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black.withOpacity(0.3),
      //                       spreadRadius: 3,
      //                       blurRadius: 3,
      //                       // offset: const Offset(0, 10),
      //                     ),
      //                   ],
      //                 ),
      //                 child: TextField(
      //                   controller: country,
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     prefixIcon: Icon(
      //                       Icons.location_on_rounded,
      //                       color: Color(0xffCC9B00),
      //                     ),
      //                     contentPadding: EdgeInsets.all(13),
      //                     hintText: 'Country',
      //                     hintStyle: _textInputStyle,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Container(
      //                 height: 44,
      //                 width: 920,
      //                 margin: EdgeInsets.symmetric(horizontal: 20),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(5),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black.withOpacity(0.3),
      //                       spreadRadius: 3,
      //                       blurRadius: 3,
      //                       // offset: const Offset(0, 10),
      //                     ),
      //                   ],
      //                 ),
      //                 child: TextField(
      //                   controller: state,
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     prefixIcon: Icon(
      //                       Icons.location_on_rounded,
      //                       color: Color(0xffCC9B00),
      //                     ),
      //                     contentPadding: EdgeInsets.all(13),
      //                     hintText: 'State',
      //                     hintStyle: _hintStyle,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Container(
      //                 height: 44,
      //                 width: 920,
      //                 margin: EdgeInsets.symmetric(horizontal: 20),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(5),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black.withOpacity(0.3),
      //                       spreadRadius: 3,
      //                       blurRadius: 3,
      //                       // offset: const Offset(0, 10),
      //                     ),
      //                   ],
      //                 ),
      //                 child: TextField(
      //                   controller: profession,
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     prefixIcon: Icon(
      //                       Icons.work_outline_outlined,
      //                       color: Color(0xffCC9B00),
      //                     ),
      //                     contentPadding: EdgeInsets.all(13),
      //                     hintText: 'Profession',
      //                     hintStyle: _textInputStyle,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Container(
      //                 child: MaterialButton(
      //                   height: 44,
      //                   minWidth: 220,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(20.0))),
      //                   color: Color(0xffCC9B00),
      //                   onPressed: () async {
      //                     //await submitData(name, email,password,gender.text,dd.text+"-"+mm.text+"-"+yyyy.text,country.text,state.text,profession.text, url);
      //                     final body = {
      //                       "create": "create",
      //                       "email": email.toString(),
      //                       "password": password.toString(),
      //                       'name': name.toString(),
      //                       "gender": gender.text.toString(),
      //                       'date': "23" + "-" + "12" + "-" + "1991",
      //                    //   'date': (selectedDate.day.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.year.toString()).toString(),
      //                       "country": country.text.toString(),
      //                       "state": state.text.toString(),
      //                       'profession': profession.text.toString(),
      //                     };
      //                     print(body);
      //                     ApiService.signup(body).then((success) {
      //                       if (success.toInt() > 0) {
      //
      //                         addUserData().then((val) {
      //                           //loader.loadingDismiss();
      //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChoosePhotoScreen()));
      //                           Get.snackbar('Success', 'Sign up SuccessFully');
      //                         });
      //                        // addUserData();
      //                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
      //                       }
      //                       else {
      //                         if (success == -999) {
      //                           showDialog(
      //                             builder: (context) =>
      //                                 AlertDialog(
      //                                   backgroundColor: Colors.white,
      //                                   title: Text(
      //                                       "System Error Try Again Later."),
      //                                   actions: <Widget>[
      //                                     FlatButton(
      //                                       onPressed: () {
      //                                         Navigator.pop(context);
      //                                       },
      //                                       child: Text('OK'),
      //                                     )
      //                                   ],
      //                                 ),
      //                             context: context,
      //                           );
      //                         }
      //                         else {
      //                           if (success == -888) {
      //                             showDialog(
      //                               builder: (context) =>
      //                                   AlertDialog(
      //                                     title: Text(
      //                                         "Your Email Account Already Registered."),
      //                                     actions: <Widget>[
      //                                       FlatButton(
      //                                         onPressed: () {
      //                                           Navigator.of(context)
      //                                               .push(
      //                                               MaterialPageRoute(
      //                                                   builder: (
      //                                                       context) =>
      //                                                       SignUpOne()));
      //                                         },
      //                                         child: Text('OK'),
      //                                       )
      //                                     ],
      //                                   ),
      //                               context: context,
      //                             );
      //                           }
      //                           else{
      //                             if(success==-7){
      //                               showDialog(
      //                                 builder: (context) => AlertDialog(
      //                                   backgroundColor: Colors.white,
      //                                   title: Text('Incorrect credentials'),
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
      //                           }
      //                         }
      //                       };
      //                     });
      //                   },
      //                   child: Text('Sign up', style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 15,
      //                       fontFamily: 'Montserrat')),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

}