import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';

import 'package:triumph_life_ui/HomeScreen.dart';

import '../newappcode/Start/Login.dart';
import '../newappcode/screens/homeScreen.dart';

class ChoosePhotoScreen extends StatefulWidget {
  @override
  _ChoosePhotoScreenState createState() => _ChoosePhotoScreenState();
}

class _ChoosePhotoScreenState extends State<ChoosePhotoScreen> {
  final nameController = TextEditingController();
  UserController userController = Get.put(UserController());

  _imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        userController.profilePhoto = File(pickedFile.path);
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        userController.profilePhoto = File(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
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
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Photo',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffCC9B00)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Be creative when choosing a photo!',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color:  Color(0xffCC9B00)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor:  Color(0xffCC9B00),
                        child: userController.profilePhoto != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:
                          Image.file(
                            userController.profilePhoto,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Center(
                      child: Container(
                        height: 55,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'CHOOSE PHOTO',
                            style: TextStyle(
                                color:  Color(0xffCC9B00),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 140,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(28.0),
                      //     child: Text(
                      //       "BACK",
                      //       style: TextStyle(color: Colors.white, fontSize: 18),
                      //     ),
                      //   ),
                      // ),
                      // abi yeh karo aur sath test bhi ho jay ga sign up and login ka password email galt lihk k test karo abi
                      GestureDetector(
                        onTap: () {
                          if (userController.profilePhoto != null) {
                            userController
                                .uploadFile()
                                .then((value) => Get.to(LoginScreen()));
                          } else {
                            Get.to(LoginScreen());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            userController.profilePhoto != null
                                ? "NEXT"
                                : 'Skip',
                            style: TextStyle(color:  Color(0xffCC9B00), fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
