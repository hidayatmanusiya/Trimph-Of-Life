import 'package:meta/meta.dart';
import 'package:triumph_life_ui/newappcode/Models/user_model.dart';

class Friends {
  final User user;
  final String time;
  final String time_type;

  const Friends( {
     this.user,
     this.time,
     this.time_type,
  }
  );
}