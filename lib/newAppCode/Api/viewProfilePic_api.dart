import 'dart:convert';
import 'package:triumph_life_ui/newappcode/Data/profilePicData.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/profile-pic.php';

  static Future<profilePicData> viewProfilePic(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    Map<String, dynamic> jsonData = json.decode(res.toString());
    if (response.statusCode == 200) {
      return (profilePicData.fromJson(jsonData));
    } else {
      return profilePicData(pic_id: 'null', path: 'null', status: 'null', Profile_pic: 'null',cover_pic: 'null');
    }
  }
}