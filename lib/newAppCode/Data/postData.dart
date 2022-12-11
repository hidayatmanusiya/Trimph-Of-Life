import 'dart:convert';
import 'package:http/http.dart' as http;

class postData {

  postData({ this.post_id,  this.type,this.post_content2, this.post_content,  this.comment_count,this.path,this.likes_count, this.user_id, this.user_name});

  final String  user_id;
  final String  user_name;
  final String  post_id;
  final String  type;
  final String post_content;
  final String  comment_count;
  final String  path;
  final String  likes_count;
  final String  post_content2;


  factory postData.fromJson(Map<String, dynamic> json){

    if(json['post_content']==null){
      return postData(
        user_id: json['user_id'],
        user_name: json['user_name'],
        post_id: json["post_id"],
        type: json["type"],
        post_content: 'null',
        comment_count: json["comment_count"],
        path:json['path'],
        likes_count:json["likes_count"],
      );
    }
    else if(json['type']=='Image-Text'){
      return postData(
        user_id: json['user_id'],
        user_name: json['user_name'],
        post_id: json["post_id"],
        type: json["type"],
        post_content: json['post_content'],
        comment_count: json["comment_count"],
        path:json['path'],
        likes_count:json["likes_count"],
        post_content2: json['post_content2']
      );
    }
    return postData(
      user_id: json['user_id'],
      user_name: json['user_name'],
      post_id: json["post_id"],
      type: json["type"],
      post_content: json["post_content"],
      comment_count: json["comment_count"],
      path:json["path"],
      likes_count:json["likes_count"],
    );
  }
}