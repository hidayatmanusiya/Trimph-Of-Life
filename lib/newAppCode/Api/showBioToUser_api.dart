import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/newappcode/Data/userData.dart';

class ApiService_userData {
  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/user-bio.php';

  static Future<userData> showBioToUser(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    Map<String, dynamic> jsonData = json.decode(res.toString());
    if (response.statusCode == 200) {
      return (userData.fromJson(jsonData));
    } else {
      return userData(status: 'null', user_id: 'null', content: 'null', country: 'null', gender: 'null', password: 'null', email: 'null', profession: 'null', name: 'null', state: 'null', msg: 'null');
    }
  }
}