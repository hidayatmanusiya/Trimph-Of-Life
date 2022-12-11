import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/data.dart';
import 'package:triumph_life_ui/newappcode/Messaging/model/message.dart';
import '../utils.dart';
import 'package:triumph_life_ui/newappcode/User/globalUser.dart' as globals;

class FirebaseApi {
  static Stream<List<friendss>> getUsers() => FirebaseFirestore.instance
      .collection('users/${globals.GlobalUserId}/friends')
      .snapshots()
      .transform(Utils.transformer(friendss.fromJsonn));

  static Future uploadMessage(String idUser, String message) async {
    int number=globals.GlobalUserId+int.parse(idUser);
    final refMessages =
        FirebaseFirestore.instance.collection('chatbox/${number}/messages');

    final newMessage = Message(
      receiverId: idUser,
      senderId: globals.GlobalUserId.toString(),
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());
    //
    // final refUsers = FirebaseFirestore.instance.collection('users');
    // await refUsers
    //     .doc(idUser)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
    FirebaseFirestore.instance
        .collection('chatbox/${globals.GlobalUserId+int.parse(idUser)}/messages')
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));


  static Future addRandomUsers(List<friendss> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users/${globals.GlobalUserId}/friends');
    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(user_id: user.user_id);
        await userDoc.set(newUser.toJson());
      }
    }
  }
}
