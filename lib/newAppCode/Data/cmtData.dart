import 'dart:convert';
import 'package:http/http.dart' as http;

class cmtData{

  final int  post_coment;
  final String  status;

  cmtData({this.status, this.post_coment});

  factory cmtData.fromJson(Map<String, dynamic> json){

    return cmtData(
      status: json["status"],
      post_coment: json["post_coment"],
    );
  }
}