import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiService_uploadProfile {

  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/profile-pic.php';
  static Future<bool> uploadProfilePic(body) async {
    var imageUploadRequest = http.MultipartRequest('POST', Uri.parse(URL));
    imageUploadRequest.fields.addAll({
      'update': '${body['update']}',
      'user_id': '${body['user_id']}'
    });
    imageUploadRequest.files.add(await http.MultipartFile.fromPath('pic', '${body['pic']}'));
    http.StreamedResponse response = await imageUploadRequest.send();
    final String res=await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return true;
    }
    return false;

  }
}