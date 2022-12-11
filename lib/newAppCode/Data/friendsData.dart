import 'dart:convert';
import 'package:http/http.dart' as http;

class friendss{

  final String  user_id;
  final String  name;
  final String  path;
  final String  pic;

  friendss({this.user_id, this.name, this.path,this.pic});

  friendss copyWith({
    String user_id,
    String name,
    String urlAvatar,
    String lastMessageTime,
  }) =>
      friendss(
        user_id: user_id ?? this.user_id,
        name: name ?? this.name,
        path: urlAvatar ?? this.path,
        pic: pic ?? this.pic,
      );

  static friendss fromJsonn(Map<String, dynamic> json) => friendss(
    user_id: json['user_id'],
    name: json['name'],
    path: json['path'],
    pic: json["pic"],
  );

  factory friendss.fromJson(Map<String, dynamic> json){

    return friendss(
      user_id: json['user_id'],
      name: json['name'],
      path: json["path"],
      pic: json["pic"],
    );
  }
  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'name': name,
    'path': path,
    'pic': pic,
  };
}