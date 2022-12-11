import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/newappcode/Data/postData.dart';

class ApiServicee_all {
  static Future<List<postData>> fetchPost() async {
    const String URL =
        'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/fetch-post.php?';
    final response = await http.post(Uri.parse(URL));
    final abc = response.body;
    if (response.body != 'null' && response.body != '1') {
      try {
        if (response.statusCode == 200) {
          return (json.decode(abc) as List)
              .map((data) => postData.fromJson(data))
              .toList();
        }
      } catch (e) {}
    }
    return <postData>[];
  }
}
