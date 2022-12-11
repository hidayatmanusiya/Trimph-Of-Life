import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService_updateBio {
  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/user-bio.php';

  static Future<bool> updateUserProfileBio(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}