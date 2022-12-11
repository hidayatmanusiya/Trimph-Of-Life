import 'package:meta/meta.dart';

class User {
  final String name;
  final String imageUrl;
  final String gender;
  final String address;
  final String date;
  final String month;
  final String year;
  final String proffesion;


  const User( {
     this.gender,  this.address,  this.date,  this.month,  this.year,  this.proffesion,
     this.name,
     this.imageUrl,
  });
}