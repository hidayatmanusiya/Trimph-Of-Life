import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/Controller/friends_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friend_card_row.dart';

class FriendPage extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final UserController userController = Get.put(UserController());
  final FriendController friendController = Get.put(FriendController());
  @override
  Widget build(BuildContext context) {
    friendController.getFriensList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Container(child: GetBuilder<FriendController>(builder: (_) {
        return Container(
            child: ListView.builder(
                itemCount: _.allFriendList.length,
                itemBuilder: (context, i) {
                  var data = _.allFriendList[i];
                  return

                      // /* !_.isRequestSent(data.refrence)?*/
                      friendCardRow(
                          icon: Icons.messenger,
                          btnColor: Colors.blueAccent,
                          onTapfunction: () {
                            chatController.isChatAvailable(
                                userController.userData.userId, data.userId);
                            // if (!_.isRequestAccepted(data.refrence)) {
                            //   _.requestAccept(data.refrence);
                            // }
                          },
                          photoLink: data.profilePhoto,
                          userData: data,
                          name: data.firstName + " " + data.lastName,
                          btnText: 'Message')
                      // : SizedBox()
                      ;
                }));
      })),
    );
  }
}
