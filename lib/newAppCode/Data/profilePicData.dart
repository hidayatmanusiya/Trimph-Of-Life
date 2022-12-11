import 'dart:convert';
import 'package:http/http.dart' as http;

class profilePicData {

  profilePicData({this.pic_id, this.path, this.status, this.Profile_pic, this.msg,this.cover_pic });

  final String  pic_id;
  final String  path;
  final String status;
  final String  Profile_pic;
  final String  msg;
  final String  cover_pic;


  factory profilePicData.fromJson(Map<String, dynamic> json){

    if(json['status']=='failed'){
      return profilePicData(
          status: json['status'],
          msg: json['msg'],
          path: 'null',
          pic_id: 'null',
          Profile_pic: 'null',
          cover_pic: 'null'
      );
    }
    else if(json['Profile_pic']==null){
      return profilePicData(
          status: json['status'],
          path: json['path'],
          pic_id: json['pic_id'],
          cover_pic: json['cover_pic']
      );
    }
    return profilePicData(
      status: json['status'],
      path: json['path'],
      pic_id: json['pic_id'],
      Profile_pic: json['Profile_pic'],
    );
  }
}