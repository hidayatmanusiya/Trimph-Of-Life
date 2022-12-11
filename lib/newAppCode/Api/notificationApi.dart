import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triumph_life_ui/newappcode/Data/notificationData.dart';

class ApiServicee_friends {
  static Future<List<notificationData>> get_notifications(body) async {
    const String URL =
        'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/notification.php';
    final response = await http.post(Uri.parse(URL), body: body);
    final abc = response.body;
    if (response.body != 'null' && response.body != '1') {
      try {
        if (response.statusCode == 200) {
          return (json.decode(abc) as List).map((data) => notificationData.fromJson(data)).toList();
        }
      } catch (e) {}
    }
    return <notificationData>[];
  }
}
