import 'dart:convert';
import 'package:http/http.dart' as http;

class likeData{

  final String  Status_like;
  final String  id;
  final String  post_likes;
  final String  status;
  final String  post_id;

  likeData({this.Status_like, this.id, this.post_likes, this.status, this.post_id});

  factory likeData.fromJson(Map<String, dynamic> json){

    return likeData(
      Status_like: json['Status_like'],
      id: json['id'],
      status: json["status"],
      post_likes: json["post_likes"],
      post_id: json["post_id"],
    );
  }
}