import 'package:meta/meta.dart';
import 'package:triumph_life_ui/newappcode/Models/user_model.dart';

class Request {
  final User user;
  final int mutual;

  const Request( {
     this.user,
     this.mutual
  }
      );
}