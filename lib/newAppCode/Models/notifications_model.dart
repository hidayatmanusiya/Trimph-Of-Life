import 'package:meta/meta.dart';
import 'package:triumph_life_ui/newappcode/Models/user_model.dart';

class Notifications {
  final User user;
  final String time;
  final String time_type;

  const Notifications( {
     this.user,
     this.time,
     this.time_type,
}
);
}