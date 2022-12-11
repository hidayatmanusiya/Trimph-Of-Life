class ModelUserBlock {
  int id;
  String user_id;

  ModelUserBlock({this.user_id});

  factory ModelUserBlock.fromMap(Map<String, dynamic> json) => ModelUserBlock(
        // id: json["id"],
        user_id: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        "user_id": user_id,
      };
}
