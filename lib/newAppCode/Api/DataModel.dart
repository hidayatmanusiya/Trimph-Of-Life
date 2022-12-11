import 'dart:convert';

DataModel DataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String DataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  String status="";
  String msg="";
  String user_id="";

  DataModel({
     this.status,
     this.msg,
     this.user_id,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    status: json["status"],
    msg: json["msg"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "status": this.status,
    "msg": this.msg,
    "user_id": this.user_id

  };
}


