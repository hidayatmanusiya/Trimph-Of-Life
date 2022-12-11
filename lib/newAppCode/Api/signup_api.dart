import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String URL = 'https://ali.karenj10.sg-host.com/triumph/triumph/demo/api/signup.php';

  static Future<int> signup(body) async {
    final response = await http.post(Uri.parse(URL), body: body);
    final String res=response.body;
    if(response.body!='null'){
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try{
        if (response.statusCode == 200 && jsonData['msg']=="User Account Created Successfuly." && jsonData['status']=="Success") {
          return (jsonData['user_id']);
        } else {
          if(jsonData['msg']=="System Error Try Again Later."&&jsonData['status']=="Failed")
          {
            return -999;
          }
          else{
            if(jsonData['msg']=="Your Email Account Already Registered."&&jsonData['status']=="AlreadyExists")
            {
              return -888;
            }
          }
        }
      }catch(e){
        print(e);
      }
    }
    return -7;
  }
}