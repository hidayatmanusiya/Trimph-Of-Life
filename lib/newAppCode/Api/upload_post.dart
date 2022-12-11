import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiService_uploadPost {

  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/add-post.php';
  static Future<bool> upload_post(body) async {

    if(body['type']=='Image-Text'||body['type']=='Image'){
      var imageUploadRequest = http.MultipartRequest('POST', Uri.parse(URL));
      imageUploadRequest.fields.addAll({
        'post': '${body['post']}',
        'content': '${body['content']}',
        'type': '${body['type']}',
        'user_id': '${body['user_id']}'
      });
      //var picture = http.MultipartFile.fromBytes('pic', (await rootBundle.load('${body['pic']}')).buffer.asUint8List(),);
      imageUploadRequest.files.add(await http.MultipartFile.fromPath('pic', '${body['pic']}'));
      http.StreamedResponse response = await imageUploadRequest.send();
      final String res=await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return true;
      }
    }
    else{
      final response = await http.post(Uri.parse(URL), body: body);
      final String res=response.body;
      Map<String, dynamic> jsonData = json.decode(res.toString());
      if (response.statusCode == 200) {
        return true;
      }
    }
    return false;
  }
}