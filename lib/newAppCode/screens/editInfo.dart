import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/coverPhotoUpdate_api.dart';
import 'package:triumph_life_ui/newappcode/Api/showBioToUser_api.dart';
import 'package:triumph_life_ui/newappcode/Api/updateUserProfileBio_api.dart';
import 'package:triumph_life_ui/newappcode/Api/uploadProfilePicture_api.dart';
import 'package:triumph_life_ui/newappcode/Api/viewProfilePic_api.dart';
import 'package:triumph_life_ui/newappcode/Data/profilePicData.dart';
import 'package:triumph_life_ui/newappcode/Data/userData.dart';
import 'dart:async';
import 'dart:io';

import 'package:triumph_life_ui/newappcode/screens/profile.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


   PickedFile imageFile;

   SharedPreferences user;
  int id;
  dynamic userdata,profiledata;
  String name1='',email1='',password1='',dob1='',state1='',country1='',gender1='',profession1='',bio1='';

  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }

  void initialGetsavedData() async {
    user = await SharedPreferences.getInstance();
    id=user.getInt('userId');
    final  body2={'view':'view',"user_id":'${id}'};
    final  body={'showprofile':'show',"user_id":'${id}'};
    setState(() {
      profiledata=ApiServices.viewProfilePic(body);
      userdata=ApiService_userData.showBioToUser(body2);
      ApiService_userData.showBioToUser(body2).then((value){
        name1=value.name.toString();
        email1=value.email.toString();
        password1=value.password.toString();
        dob1=value.dob.toString();
        state1=value.state.toString();
        country1=value.country.toString();
        bio1='';
        profession1=value.profession.toString();
      });
    });
  }

  File image=File('');
  void cameraa() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      image = File(picked.path);
      if(image.path!=''){
        final body={'update':'update','user_id':'$id','pic':image.path};
        print(body);
        ApiService_uploadProfile.uploadProfilePic(body).then((success){
          if(success){
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
            });
          }
        });
      }
    });
  }

  void galleryy() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.gallery,maxHeight: 400);
    setState(() {
      image = File(picked.path);
      if(image.path!=''){
        final body={'update':'update','user_id':'$id','pic':image.path};
        ApiService_uploadProfile.uploadProfilePic(body).then((success){
          if(success){
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
            });
          }
        });
      }
    });
  }
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController profession = new TextEditingController();
  TextEditingController bio = new TextEditingController();
  void update(int key,String textt){
    if(key==1){
      name1=textt;
    }else if(key==2){
      email1=textt;
    }
    else if(key==3){
      password1=textt;
    }
    else if(key==4){
      dob1=textt;
    }
    else if(key==5){
      state1=textt;
    }
    else if(key==6){
      country1=textt;
    }
    else if(key==7){
      gender1=textt;
    }
    else if(key==8){
      profession1=textt;
    }
    else if(key==9){
      bio1=textt;
    }
  }
  final double profileheight=114;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        elevation: 1,
        title: Text('Edit Profile',style: TextStyle(fontSize: 18,letterSpacing: 2,fontWeight: FontWeight.w900,color: Colors.black),),
        leading: GestureDetector(
          child: Icon(Icons.close, color: Colors.black),
          onTap: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.done, color: Color(0xffCC9B00)),
            ),
            onTap: () {
              showDialog(
                builder: (context) =>
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                          "Are you sure?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            final  body={'ubio':'ubio',"detail":'ok',"user_id":'${id}',"gender":'${gender1}',"date":'${dob1}',"password":'${password1}',"email":'${email1}',"name":'${name1}',"state":'${state1}',"profession":'${profession1}',"country":'${country1}'};
                            ApiService_updateBio.updateUserProfileBio(body).then((success){
                              if(success){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile()));
                              }
                            });
                          },
                          child: Text('Confirm',style: TextStyle(color: Color(0xffCC9B00)),),
                        ),
                      ],
                    ),
                context: context,
              );
            },
          )
        ],
      ),
      body:Container(
    color: Colors.white,
    child:ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child:FutureBuilder <profilePicData>(
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
                  ),
                  onTap: (){
                    _showImageDialog();
                  }
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text('Change Photo',
                      style: TextStyle(
                          color: Color(0xffCC9B00),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                onTap:() {
                  _showImageDialog();
                }
              )
            ],
          ),

          FutureBuilder <userData>(
              future: userdata,
              builder:(BuildContext context,AsyncSnapshot snapshot){
                if (snapshot.hasData) {
                  userData data = snapshot.data;
                   name.text = "${data?.name}";
                   email.text = "${data?.email}";
                   password.text = "${data?.password}";
                   dob.text =  "${data?.status}";
                   state.text = "${data?.state}";
                   country.text = "${data?.country}";
                   gender.text = "${data?.gender}";
                   profession.text = "${data?.profession}";
                   bio.text = "${data?.content}";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.name}',
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),
                          ),
                          onChanged: ((value) {
                            setState(() {
                              name.text = value;
                              update(1, name.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.email}',
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              email.text = value;
                              update(2, email.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.password}',
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              password.text = value;
                              update(3, password.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.gender}', labelText: 'Gender',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              gender.text = value;
                              update(7, gender.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.content}', labelText: 'Bio',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              bio.text = value;
                              update(9, bio.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.msg}', labelText: 'Date of Birth',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              dob.text = value;
                              update(4, dob.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.state}', labelText: 'State',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              state.text = value;
                              update(5, state.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.country}', labelText: 'Country',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              country.text = value;
                              update(6, country.text);
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '${data?.profession}', labelText: 'Profession',
                            labelStyle: TextStyle(
                              color: Color(0xffCC9B00),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCC9B00),),
                            ),),
                          onChanged: ((value) {
                            setState(() {
                              profession.text = value;
                              update(8, profession.text);
                            });
                          }),
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  );
                }
                return Column();
              }
          ),

        ],
      ),
      ),
    );
  }


  Widget buildProfileImage()=> CircleAvatar(
    radius: profileheight/2,
    backgroundImage: AssetImage('assets/images.jpg'),
    //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
  );

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
                  galleryy();
                },
              ),
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () {
                  cameraa();
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





