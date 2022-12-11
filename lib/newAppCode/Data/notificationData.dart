import 'dart:convert';
import 'package:http/http.dart' as http;

class notificationData{

  final String  user_id;
  final String text;
  final String  name;
  final String  path;
  final String  pic;

  notificationData({this.user_id, this.name, this.path,this.pic,this.text});

  factory notificationData.fromJson(Map<String, dynamic> json){

    return notificationData(
      user_id: json['user_id'],
      name: json['name'],
      path: json["path"],
      pic: json["pic"],
      text: json["text"],
    );
  }
}