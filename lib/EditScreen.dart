import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/common_widgets/button_widget.dart';
import 'package:triumph_life_ui/common_widgets/text_field.dart';

import 'common_widgets/spaces_widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Loader loader = Get.put(Loader());
  UserController userController = Get.put(UserController());

  // Cover imageee

  //     _imgFromCameraCover() async {
  //   final pickedFileCover = await ImagePicker()
  //       .getImage(source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     if (pickedFileCover != null) {
  //       userController.profilePhoto = File(pickedFileCover.path);
  //     }
  //   });
  // }

  // _imgFromGalleryCover() async {
  //   final pickedFileCover = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     if (pickedFileCover != null) {
  //       userController.profilePhoto = File(pickedFileCover.path);
  //     }
  //   });
  // }

  // void _showPickerCover(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGalleryCover();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     _imgFromCameraCover();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  //   static String p =
  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  // File pickedImageCover;

  // PickedFile _imageCover;
  // Future<void> getImage({ImageSource source}) async {
  //   _imageCover = await ImagePicker().getImage(source: source);
  //   if (_imageCover != null) {
  //     setState(() {
  //       pickedImageCover = File(_image.path);
  //     });
  //   }
  // }

  User user;

  Future<String> uploadImageCover({File imageCover}) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("UserImageCover/${user.uid}");
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(imageCover);
    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => SnapshotMetadata);
    String imageUrlCover = await snapshot.ref.getDownloadURL();
    return imageUrlCover;
  }

  // bool isEdit = false;
  // void userDetailUpdate() async {
  //   setState(() {
  //     isEdit = true;
  //   });
  //   String imageUrlCover = pickedImageCover == null
  //       ? await _uploadImage(image: pickedImageCover)
  //       : userController.userData.lastName;

  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .update({
  //     'FirstName': userController.passwordController.text,
  //     'LastName': userController.lastNameController.text,
  //     'email': email.text,
  //     'userImage': imageUrlCover,
  //   });

  //   setState(() {
  //     isEdit = false;
  //   });
  // }

  // RegExp regExp = new RegExp(p);

//ProfilePhoto

  _imgFromCamera(String photoPic) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        photoPic == "profilePhoto"
            ? userController.profilePhoto = File(pickedFile.path)
            : userController.coverPhoto = File(pickedFile.path);
      }
    });
  }

  _imgFromGallery(String photoPic) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        photoPic == "profilePhoto"
            ? userController.profilePhoto = File(pickedFile.path)
            : userController.coverPhoto = File(pickedFile.path);
      }
    });
  }

  void _showPicker(String photo) {
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
                        _imgFromGallery(photo);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(photo);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  File pickedImage;
  File pickedCoverImage;

  // Future<void> getImage({ImageSource source}) async {
  //   _image = await ImagePicker().getImage(source: source);
  //   if (_image != null) {
  //     setState(() {
  //       pickedImage = File(_image.path);
  //     });
  //   }
  // }

  // User user;

  Future<String> _uploadImage({File image}) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("UserImage/${user.uid}");
    firebase_storage.UploadTask uploadTask = storageReference.putFile(image);
    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => SnapshotMetadata);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  bool isEdit = false;
  void userDetailUpdate() async {
    setState(() {
      isEdit = true;
    });
    String imageUrl = pickedImage == null
        ? await _uploadImage(image: pickedImage)
        : userController.userData.lastName;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'FirstName': userController.firstNameController.text,
      'LastName': userController.lastNameController.text,
      'email': email.text,
      'userImage': imageUrl,
    });

    setState(() {
      isEdit = false;
    });
  }

  RegExp regExp = new RegExp(p);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> myDialogBox(context) {
  //   return showDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: [
  //                 ListTile(
  //                   leading: Icon(Icons.camera_alt),
  //                   title: Text("Pick Form Camera"),
  //                   onTap: () {
  //                     getImage(source: ImageSource.camera);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(Icons.photo_library),
  //                   title: Text("Pick Form Gallery"),
  //                   onTap: () {
  //                     getImage(source: ImageSource.gallery);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void vaildation() async {
  //   if (userController.emailController.text.isEmpty &&
  //       userController.passwordController.text.isEmpty) {
  //     FirebaseAuth.instance.signOut();
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Both Flied Are Empty"),
  //       ),
  //     );
  //   } else if (userController.passwordController.text.isEmpty) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Password Is Empty"),
  //       ),
  //     );
  //   } else if (userController.emailController.text.isEmpty) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Email Is Empty"),
  //       ),
  //     );
  //   } else if (!regExp.hasMatch(userController.emailController.text)) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Please Try Vaild Email"),
  //       ),
  //     );
  //   } else if (userController.passwordController.text.isEmpty) {
  //     scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text("Password Is Empty"),
  //       ),
  //     );
  //   } else {
  //     userDetailUpdate();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Edit Profile"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: GetBuilder<UserController>(
          builder: (_) {
            return Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _.formKeySignUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 320.0,
                        child: Stack(
                          children: <Widget>[
                            // Container(
                            //   margin: EdgeInsets.symmetric(
                            //       horizontal: 15.0, vertical: 15.0),
                            //   height: 180.0,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //           image: AssetImage('assets/cover.jpg'),
                            //           fit: BoxFit.fitWidth),
                            //       borderRadius: BorderRadius.circular(10.0)),
                            // ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 15.0),
                                height: 180.0,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/cover.jpg'),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: userController.profilePhoto != null
                                    ? Container(
                                        //           margin: EdgeInsets.symmetric(
                                        // horizontal: 15.0, vertical: 15.0),
                                        child: Stack(children: [
                                          Positioned(
                                            child: Image.file(
                                              userController.coverPhoto ??
                                                  Image.asset(
                                                      "assets/cover.jpg"),
                                              width: Get.width,
                                              height: 180,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Positioned(
                                              top: 40,
                                              left: 150,
                                              child: IconButton(
                                                  icon: Icon(Icons.camera_alt),
                                                  onPressed: () {
                                                    _showPicker("coverPhoto");
                                                  })),
                                        ]),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: NetworkImage(
                                              _.userData.coverPhoto ?? '',
                                            ),
                                          ),
                                          // borderRadius:
                                          //     BorderRadius.circular(
                                          //         50)
                                        ),
                                        width: Get.width,
                                        height: 180,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showPicker("coverPhoto");
                                          },
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                              ),
                            ),

                            // Container(
                            //   margin: EdgeInsets.symmetric(
                            //       horizontal: 15.0, vertical: 15.0),
                            //   height: 180.0,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //           image: AssetImage('assets/cover.jpg'),
                            //           fit: BoxFit.fitWidth),
                            //       borderRadius: BorderRadius.circular(10.0)),
                            // ),
                            Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Color(0xffFDCF09),
                                      child: userController.profilePhoto != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Stack(children: [
                                                Positioned(
                                                  child: Image.file(
                                                    userController.profilePhoto,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 30,
                                                    left: 20,
                                                    child: IconButton(
                                                        icon: Icon(
                                                            Icons.camera_alt),
                                                        onPressed: () {
                                                          _showPicker(
                                                              "profilePhoto");
                                                        })),
                                              ]),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.grey[200],
                                                  image: DecorationImage(
                                                    image: NetworkImage(_
                                                            .userData
                                                            .profilePhoto ??
                                                        ''),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              width: 100,
                                              height: 100,
                                              child: GestureDetector(
                                                onTap: () {
                                                  _showPicker("profilePhoto");
                                                },
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundImage: NetworkImage(
                                  //       _.userData.profilePhoto ?? ''),
                                  //   radius: 70.0,
                                  // ),
                                  SizedBox(height: 20.0),
                                  // Text(
                                  //     '${_.userData.firstName} ${_.userData.lastName}' ==
                                  //             null
                                  //         ? "helo"
                                  //         : '${_.userData.firstName} ${_.userData.lastName}',
                                  //     style: TextStyle(
                                  //         fontSize: 24.0,
                                  //         fontWeight: FontWeight.bold)),
                                  // SizedBox(height: 20.0),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: <Widget>[
                                  //     Container(
                                  //       height: 40.0,
                                  //       width: MediaQuery.of(context).size.width - 80,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.blue,
                                  //           borderRadius: BorderRadius.circular(5.0)),
                                  //       child: Center(
                                  //           child: Text('Add to Story',
                                  //               style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontWeight: FontWeight.bold,
                                  //                   fontSize: 16.0))),
                                  //     ),
                                  //     Container(
                                  //       height: 40.0,
                                  //       width: 45.0,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.grey[300],
                                  //           borderRadius: BorderRadius.circular(5.0)),
                                  //       child: Icon(Icons.more_horiz),
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // Center(
                      //   child: GestureDetector(
                      //     child: CircleAvatar(
                      //       radius: 55,
                      //       backgroundColor: Color(0xffFDCF09),
                      //       child: userController.profilePhoto != null
                      //           ? ClipRRect(
                      //               borderRadius: BorderRadius.circular(50),
                      //               child: Stack(children: [
                      //                 Positioned(
                      //                   child: Image.file(
                      //                     userController.profilePhoto,
                      //                     width: 100,
                      //                     height: 100,
                      //                     fit: BoxFit.contain,
                      //                   ),
                      //                 ),
                      //                 Positioned(
                      //                     top: 30,
                      //                     left: 20,
                      //                     child: IconButton(
                      //                         icon: Icon(Icons.camera_alt),
                      //                         onPressed: () {
                      //                           _showPicker(context);
                      //                         })),
                      //               ]),
                      //             )
                      //           : Container(
                      //               decoration: BoxDecoration(
                      //                   // color: Colors.grey[200],
                      //                   image: DecorationImage(
                      //                     image: NetworkImage(
                      //                         _.userData.profilePhoto ?? ''),
                      //                   ),
                      //                   borderRadius:
                      //                       BorderRadius.circular(50)),
                      //               width: 100,
                      //               height: 100,
                      //               child: GestureDetector(
                      //                 onTap: () {
                      //                   _showPicker(context);
                      //                 },
                      //                 child: Icon(
                      //                   Icons.camera_alt,
                      //                   color: Colors.grey[800],
                      //                 ),
                      //               ),
                      //             ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // // _buildTopPart(),
                      // GestureDetector(
                      //   onTap: () {
                      //     _showPicker(context);
                      //   },
                      //   child: Center(
                      //     child: Container(
                      //       height: 55,
                      //       width: 150,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           'CHOOSE PHOTO',
                      //           style: TextStyle(
                      //               color: Color(0xfffbd405),
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 16),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
/* ------------------------------- new ui data ------------------------------ */
                      textBox(
                        controller: _.firstNameController,
                        hint: _.userData.firstName,
                        validator: (input) {
                          if (input.length < 4) {
                            return 'First name Should be contain atleast 4 letter';
                          }
                        },
                        onSave: (input) {
                          _.userData.firstName = input;
                        },
                      ),
                      spc20,
                      textBox(
                        controller: _.lastNameController,
                        hint: _.userData.lastName,
                        // validator: (input) {
                        //   if (input.length < 4) {
                        //     return 'First name Should be contain atleast 4 letter';
                        //   }
                        // },
                        onSave: (input) {
                          _.userData.lastName = input;
                        },
                      ),
                      spc20,
                      // textBox(
                      //   controller: _.emailController,
                      //   hint: 'Email',
                      //   validator: (input) {
                      //     if (input.isEmpty) {
                      //       return 'Please Enter a Email';
                      //     } else if (!RegExp(
                      //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //         .hasMatch(input)) {
                      //       return 'Please Enter a Valid Email';
                      //     }
                      //   },
                      //   onSave: (input) {
                      //     _.userData.email = input;
                      //   },
                      // ),
                      // spc20,
                      // textBox(
                      //     hint: 'Password',
                      //     validator: (input) {
                      //       if (input.length < 8) {
                      //         return 'Password Should be  Contain Atleast 8 digit';
                      //       }
                      //     },
                      //     controller: _.passwordController),
                      // spc20,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: Container(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Date Of Birth'),
                      //         Text(
                      //           _.userData.dob ?? 'Select Date',
                      //           style: TextStyle(
                      //             color: _.userData.dob == null
                      //                 ? Colors.red
                      //                 : Colors.black,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // spc20,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: Container(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Gender'),
                      //         Text(_.gender),
                      //         DropdownButton(
                      //           iconSize: 30,
                      //           items: <String>['Male', 'Female', 'Other']
                      //               .map((String value) {
                      //             return new DropdownMenuItem<String>(
                      //               value: value,
                      //               child: new Text(value),
                      //             );
                      //           }).toList(),
                      //           onChanged: (selectedVal) {
                      //             _.gender = selectedVal;
                      //             _.update();
                      //             _.userData.gender = selectedVal;
                      //           },
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // spc20,
                      textBox(
                        controller: _.countryController,
                        hint: _.userData.country,
                        validator: (input) {
                          if (input == '') {
                            return 'Please Enter Country Name';
                          }
                        },
                        onSave: (input) {
                          _.userData.country = input;
                        },
                      ),
                      spc20,
                      textBox(
                        controller: _.stateController,
                        hint: _.userData.state,
                        validator: (input) {
                          if (input == '') {
                            return 'Please Enter State';
                          }
                        },
                        onSave: (input) {
                          _.userData.state = input;
                        },
                      ),
                      spc20,
                      textBox(
                        hint: _.userData.profession,
                        controller: _.professionController,
                        validator: (input) {
                          if (input == '') {
                            return 'Enter Your Profession';
                          }
                        },
                        onSave: (input) {
                          _.userData.profession = input;
                        },
                      ),
                      spc20,
                      buttonBox(
                        txt: 'Update Profile',
                        onTap: () {
                          if (userController.profilePhoto != null) {
                            userController.uploadFiles();
                          }
                          print("Done");
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
