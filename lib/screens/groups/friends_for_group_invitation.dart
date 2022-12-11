import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/friends_controller.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friend_card_row.dart';

class FriendsForGroupInvitation extends StatelessWidget {
  final GroupController groupController = Get.find();
  final UserController userController = Get.find();
  final FriendController friendController = Get.put(FriendController());
  @override
  Widget build(BuildContext context) {
    friendController.getFriensList();
    groupController.getGroupAdmins();
    return Scaffold(
        appBar: AppBar(
          title: Text('All Friends'),
        ),
        body: GetBuilder<FriendController>(
          builder: (controller) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var data in friendController.allFriendList)
                      // if (userController.userData.userId != data.userId)
                      friendCardRow(
                          icon: Icons.add,
                          btnColor: Colors.greenAccent,
                          onTapfunction: () {
                            groupController.checkUserForInvitation(data);
                          },
                          photoLink: data.profilePhoto,
                          userData: data,
                          name: data.firstName + " " + data.lastName,
                          btnText: 'Invite')
                  ],
                ),
              ),
            );
          },
        ));
  }
}
