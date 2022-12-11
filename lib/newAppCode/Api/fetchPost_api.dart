import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/newappcode/Data/postData.dart';

class ApiServicee {

  static Future<List<postData>> fetchPost(body) async {
    const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/fetch-post.php?';
    final response = await http.post(Uri.parse(URL));
    final abc=response.body;
    print(1111);
    if(response.body!='null'&&response.body!='1') {
      try {
        if (response.statusCode == 200) {
          print(1111111);
          //final a=(json.decode(abc) as List).map((data) => postData.fromJson(data)).toList();
          return  (json.decode(abc) as List).map((data) => postData.fromJson(data)).toList();
        }
      } catch (e) {
      }
    }
    return <postData>[];
  }
}



