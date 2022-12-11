import 'dart:convert';
import 'package:http/http.dart' as http;

class userData {

  userData( {this.msg,this.user_id, this.status, this.content, this.country, this.gender, this.password, this.email, this.profession, this.name, this.state, this.dob});

  final String  user_id;
  final String  status;
  final String  content;
  final String  country;
  final String  gender;
  final String password;
  final String email;
  final String profession;
  final String  name;
  final String  state;
  final String  msg;
  final String  dob;


  factory userData.fromJson(Map<String, dynamic> json){

    if(json['status']=='failed'){
      return userData(
        status: json['status'],
        user_id: '',
        content: '',
        country: '',
        gender: '',
        password: '',
        email: '',
        profession: '',
        name: '',
        state: '',
        dob:'',
        msg: json['msg']
      );
    }
    return userData(
        status: json['status'],
        user_id: json['user_id'],
        content: json['content'],
        country: json['country'],
        gender: json['gender'],
        password: json['password'],
        email: json['email'],
        profession: json['profession'],
        name: json['name'],
        state: json['state'],
        dob:json['d_o_b'],
        msg: ''
    );
  }
}