import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService_login {

  static Future<int> login(body) async {
    const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/login.php';
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200 &&
            jsonData['msg'] == "User Logged In Successfuly." &&
            jsonData['status'] == "Success" &&
            int.parse(jsonData['user_id']) > 0) {
          return int.parse(jsonData['user_id']);
        } else {
          if (response.statusCode == 200 &&
              jsonData['msg'] == "Incorrect Password." &&
              jsonData['status'] == "Failed") {
            return -999;
          }
          else {
            if (response.statusCode == 200 &&
                jsonData['msg'] == "User Not Logged In!!!" &&
                jsonData['status'] == "Failed") {
              return -888;
            }
          }
        }
      } catch (e) {
      }
    }
    return -7;
  }
}