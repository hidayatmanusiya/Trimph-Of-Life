import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/newappcode/Data/likeData.dart';
import 'package:triumph_life_ui/newappcode/Data/cmtData.dart';

class ApiService_like_comment {
  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/like-cmnt.php';

  static Future<likeData> like(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    Map<String, dynamic> jsonData = json.decode(res.toString());
    if (response.statusCode == 200) {
      return (likeData.fromJson(jsonData));
    } else {
      return likeData(Status_like: 'null', post_id: 'null', id: 'null', post_likes: 'null',status: 'null');
    }
  }

  static Future<cmtData> cmt(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    Map<String, dynamic> jsonData = json.decode(res.toString());
    if (response.statusCode == 200) {
      return (cmtData.fromJson(jsonData));
    } else {
      return cmtData(status: 'null',post_coment:0);
    }
  }
}