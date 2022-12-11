import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/upload_post.dart';
import 'package:triumph_life_ui/newappcode/screens/linkPost.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'homeScreen.dart';

class CreatePostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreatePostPage();
  }
}

class _CreatePostPage extends State<CreatePostPage> {
  bool isTextFiledFocus = false;
  TextEditingController content = new TextEditingController(text: "");

  int  id;

  _CreatePostPage(){
    id=0;
  }
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }
  void initialGetsavedData() async{
    final SharedPreferences user=await SharedPreferences.getInstance();
    id=user.getInt('userId');
  }

  File image=File('');
  void cameraa() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      image = File(picked.path);
    });
  }

  void galleryy() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.gallery,maxHeight: 400);
    setState(() {
      image = File(picked.path);
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          // ignore: deprecated_member_use
        actions: [
          RaisedButton(
            color: Color(0xffCC9B00),
            child: Text("Post"),
            onPressed: () {
              if(content.text!=''&&image.path=='')
                {
                  {
                    final body={'post':'post','content':content.text,'type':'Text','user_id':'$id'};
                    ApiService_uploadPost.upload_post(body).then((success){
                      if(success){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
                      }
                    });
                  }
              }
              else if(content.text==''&&image.path!='')
              {
                {
                  final body={'post':'post','pic':image.path,'type':'Image','user_id':'$id'};
                  ApiService_uploadPost.upload_post(body).then((success){
                    if(success){
                      print(success);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
                    }
                  });
                }
              }
              else if(content.text!=''&&image.path!='')
              {
                {
                  final body={'post':'post','content':content.text,'type':'Image-Text','user_id':'$id','pic':image.path};
                  ApiService_uploadPost.upload_post(body).then((success){
                    if(success){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
                    }
                  });
                }
              }
              else{
                showDialog(
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Please write Something'),
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
            },
          ),
        ],
        title: Text(
          'Create Post',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Focus(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: content,
                    maxLines: null,
                    //maxLines: content == null ? content.text.length < 20 ? 2 : 8 : 8,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type something"),
                    onChanged: (val){},
                    textInputAction: TextInputAction.next,
                  ),
                  onFocusChange: (hasFocus) {
                    setState(() async{
                      content.text!=''?isTextFiledFocus = hasFocus:isTextFiledFocus=false;
                      bool _validURL = Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4").isAbsolute;
                      print(_validURL);
                      final fileName = await VideoThumbnail.thumbnailFile(
                          video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                          thumbnailPath: ("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
                      imageFormat: ImageFormat.WEBP,
                      maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
                      quality: 75,
                      );
                    });
                  },
                ),
                image.path != '' ? Image.file(image) : Text(""),
                SizedBox(height: 20,),
                Row(
                  children: [
                    MaterialButton(
                      height: 38,
                      minWidth: 170,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      color: Color(0xffCC9B00),
                      onPressed: ()async
                      {
                        _showImageDialog(context);
                      },
                      child: Text('UPLOAD PHOTO', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Montserrat')),
                    ),
                    // IconButton(onPressed: ()=> {
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DemoHome()))
                    // }, icon: Icon(Icons.ac_unit,),)
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );

  }

  _showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () {
                  galleryy();
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () {
                  cameraa();
                  Navigator.pop(context);
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


