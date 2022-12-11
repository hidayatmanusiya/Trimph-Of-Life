import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triumph_life_ui/widgets/common_widgets.dart/utils.dart';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  Container linearProgress() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple),
      ),
    );
  }

  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  File file;
  bool isUploading = false;
  String postId = Utils.getRandomString(9);

  handleTakePhoto() async {
    Navigator.pop(context);
    final imageFileFromCamera = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (imageFileFromCamera != null) {
        file = File(imageFileFromCamera.path);
      }
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    final imageFileFromGallery = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (imageFileFromGallery != null) {
        file = File(imageFileFromGallery.path);
      }
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create Post"),
          children: <Widget>[
            SimpleDialogOption(
                child: Text("Photo with Camera"), onPressed: handleTakePhoto),
            SimpleDialogOption(
                child: Text("Image from Gallery"),
                onPressed: handleChooseFromGallery),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  Container buildSplashScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SvgPicture.asset('assets/images/upload.svg', height: 260.0),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
                color: Colors.deepOrange,
                onPressed: () => selectImage(context)),
          ),
        ],
      ),
    );
  }

  clearImage() {
    setState(() {
      captionController.clear();
      file = null;
    });
  }

  // compressImage() async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
  //   final compressedImageFile = File('$path/img_$postId.jpg')
  //     ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
  //   setState(() {
  //     file = compressedImageFile;
  //   });
  // }

  // Future<String> uploadImage(imageFile) async {
  //   StorageUploadTask uploadTask =
  //       storageRef.child("post_$postId.jpg").putFile(imageFile);
  //   StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
  //   String downloadUrl = await storageSnap.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // createPostInFirestore(
  //     {String mediaUrl, String location, String description}) {
  //   postsRef
  //       .document(widget.currentUser.id)
  //       .collection("userPosts")
  //       .document(postId)
  //       .setData({
  //     "postId": postId,
  //     "ownerId": widget.currentUser.id,
  //     "username": widget.currentUser.username,
  //     "mediaUrl": mediaUrl,
  //     "description": description,
  //     "location": location,
  //     "timestamp": timestamp,
  //     "likes": {},
  //   });
  // }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    // await compressImage();
    // String mediaUrl = await uploadImage(file);
    // createPostInFirestore(
    //   mediaUrl: mediaUrl,
    //   location: locationController.text,
    //   description: captionController.text,
    // );
    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = Utils.getRandomString(9);
    });
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: clearImage),
        title: Text(
          "Caption Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("images/life.png"),
              // CachedNetworkImageProvider("images/life.png"),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "Write a caption...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where was this photo taken?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Container(
          //   width: 200.0,
          //   height: 100.0,
          //   alignment: Alignment.center,
          //   child:
          //    RaisedButton.icon(
          //     label: Text(
          //       "Use Current Location",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(30.0),
          //     ),
          //     color: Colors.blue,
          //     onPressed: getUserLocation,
          //     icon: Icon(
          //       Icons.my_location,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // getUserLocation() async {
  //   Position position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   List<Placemark> placemarks = await Geolocator()
  //       .placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark placemark = placemarks[0];
  //   String completeAddress =
  //       '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
  //   print(completeAddress);
  //   String formattedAddress = "${placemark.locality}, ${placemark.country}";
  //   locationController.text = formattedAddress;
  // }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}

// class WritePost extends StatefulWidget {
//   @override
//   _WritePostState createState() => _WritePostState();
// }

// class _WritePostState extends State<WritePost> {
//    TextEditingController writingTextController = TextEditingController();
//   final FocusNode _nodeText1 = FocusNode();
//   FocusNode writingTextFocus = FocusNode();
//   bool _isLoading = false;
//   File _postImageFile;
//    KeyboardActionsConfig _buildConfig(BuildContext context) {
//     return KeyboardActionsConfig(
//       keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
//       keyboardBarColor: Colors.grey[200],
//       nextFocus: true,
//       actions: [
//         KeyboardActionsItem(
//           displayArrows: false,
//           focusNode: _nodeText1,
//         ),
//         KeyboardActionsItem(
//           displayArrows: false,
//           focusNode: writingTextFocus,
//           toolbarButtons: [
//             (node) {
//               return GestureDetector(
//                 onTap: () {
//                   print('Select Image');
//                   // _getImageAndCrop();
//                   _showSelectionDialog(context);
//                 },
//                 child: Container(
//                   color: Colors.red[200],
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.add_photo_alternate, size: 28),
//                       Text(
//                         "Add Image",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ],
//         ),
//       ],
//     );
//   }
//   void _postToFB() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String postID = Utils.getRandomString(8) + Random().nextInt(500).toString();
//     String postImageURL;
//     // if (_postImageFile != null) {
//     //   postImageURL = await FBStorage.uploadPostImages(
//     //       postID: postID, postImageFile: _postImageFile);
//     // }
//     // FBCloudStore.sendPostInFirebase(postID, writingTextController.text,
//     //     widget.myData, postImageURL ?? 'NONE');

//     setState(() {
//       _isLoading = false;
//     });
//     Navigator.pop(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return
//   Scaffold(
//       appBar: AppBar(
//         title: Text('Writing Post'),
//         centerTitle: true,
//         actions: <Widget>[
//           InkWell(
//              onTap: () => _postToFB(),
//                       child: Container(

//                 child: Text(
//                   'Post',
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 )),
//           )
//         ],
//       ),
//       body: Stack(
//           children: <Widget>[
//             KeyboardActions(
//       config: _buildConfig(context),
//       child: Column(
//         children: <Widget>[
//           Container(
//               width: size.width,
//               height: size.height -
//                   MediaQuery.of(context).viewInsets.bottom -
//                   80,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 14.0, left: 10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                               width: 100,
//                               height: 200,
//                               child:
//                           _postImageFile != null ?
//                               Image.file(
//                            _postImageFile,
//                             width: 200,
//                             height:300,
//                             fit: BoxFit.contain,
//                           ):Text("Nevery Say Never"),
//                               //  Image.asset(

//                               //     // 'images/${widget.myData.myThumbnail}')
//                               //     ),
//                         ),
//                        ),
//                         Text(
//                           "widget.myData.Email",
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                     TextFormField(
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       autofocus: true,
//                       focusNode: writingTextFocus,
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         focusColor: Colors.white,
//                         hoverColor: Colors.white,
//                         border: InputBorder.none,
//                         hintText: 'Writing anything.',
//                         hintMaxLines: 4,
//                       ),
//                       controller: writingTextController,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                     ),
//                     _postImageFile != null
//                         ? Container(
//                            height: 300,
//                            width: Get.width,
//                             child: Image.file(_postImageFile, fit: BoxFit.cover,),

//                           )

//                         // ? Container(
//                         //     height: 500,
//                         //     width: 500,
//                         //     child: Image.file(
//                         //       _postImageFile,
//                         //       fit: BoxFit.fill,
//                         //     ),
//                         //   )
//                         : Container(),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//             ),
//             Utils.loadingCircle(_isLoading),
//           ],
//         ),
//     );
//   }
//   Future<void> _showSelectionDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: Text("From where do you want to take the photo?"),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     GestureDetector(
//                       child: Text("Gallery"),
//                       onTap: () {
//                         _getImageGallery();
//                         Navigator.pop(context);
//                       },
//                     ),
//                     Padding(padding: EdgeInsets.all(8.0)),
//                     GestureDetector(
//                       child: Text("Camera"),
//                       onTap: () {
//                         _getImageCamera();
//                         Navigator.pop(context);
//                       },
//                     )
//                   ],
//                 ),
//               ));
//         });
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _getImageGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _getImageCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   final picker = ImagePicker();
//   File _image;
//   Future<void> _getImageGallery() async {
//     final imageFileFromGallery = await
//       ImagePicker()
//           .getImage(source: ImageSource.gallery, imageQuality: 50);

//     if (imageFileFromGallery != null) {
//       _postImageFile = File(imageFileFromGallery.path);
//       File cropImageFile = await Utils.cropImageFile(
//           _image); //await cropImageFile(imageFileFromGallery);
//       if (cropImageFile != null) {
//         setState(() {
//           _postImageFile = cropImageFile;
//         });
//       }
//     }

//     // await ImagePicker.pickImage(source: ImageSource.gallery);

//     // if (imageFileFromGallery != null) {
//     //   _postImageFile = File(imageFileFromGallery.path);
//     // File cropImageFile = await Utils.cropImageFile(
//     //     _image); //await cropImageFile(imageFileFromGallery);
//     // if (cropImageFile != null) {
//     //   setState(() {
//     //     _postImageFile = cropImageFile;
//     //   });
//     // }
//     // }
//   }

//   Future<void> _getImageCamera() async {
//     final imageFileFromCamera =
//         await
//         ImagePicker()
//           .getImage(source: ImageSource.camera, imageQuality: 50);
//     if (imageFileFromCamera != null) {
//       _postImageFile = File(imageFileFromCamera.path);
//       // File cropImageFile = await Utils.cropImageFile(
//       //     _image); //await cropImageFile(imageFileFromGallery);
//       // if (cropImageFile != null) {
//       //   setState(() {
//       //     _postImageFile = cropImageFile;
//       //   });
//       // }
//     }

//     // await ImagePicker.pickImage(source: ImageSource.gallery);

//     // if (imageFileFromGallery != null) {
//     //   _postImageFile= File(imageFileFromGallery.path);
//     // File cropImageFile = await Utils.cropImageFile(
//     //     _image); //await cropImageFile(imageFileFromGallery);
//     // if (cropImageFile != null) {
//     //   setState(() {
//     //     _postImageFile = cropImageFile;
//     //   });
//     // }
//     // }
//   }

//   _cropImage(filePath) async {
//     File croppedImage = await ImageCropper.cropImage(
//       sourcePath: filePath,
//       maxWidth: 1080,
//       maxHeight: 1080,
//     );
//     if (croppedImage != null) {
//       _postImageFile = croppedImage;
//       setState(() {});
//     }
//   }
// }
