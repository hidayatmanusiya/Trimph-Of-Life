import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friend_card_row.dart';

class AllGroupRequests extends StatelessWidget {
  final GroupController groupController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    groupController.getJoinRequestMembers();
    return Scaffold(
        appBar: AppBar(
          title: Text('All Requests'),
        ),
        body: GetBuilder<GroupController>(
          builder: (controller) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var data in controller.joinRequestMembers)
                      if (userController.userData.userId != data.userId)
                        friendCardRow(
                            icon: controller.joinRequestMembers.contains(data)
                                ? Icons.add_to_photos_rounded
                                : Icons.check,
                            btnColor:
                                controller.joinRequestMembers.contains(data)
                                    ? Colors.blueAccent
                                    : Colors.greenAccent,
                            disableButton: !controller.selectedGroup.admins
                                .contains(userController.userData.userId),
                            onTapfunction: () {
                              if (controller.joinRequestMembers
                                  .contains(data)) {
                                controller.acceptJoinRequest(data);
                              } else {}
                            },
                            photoLink: data.profilePhoto,
                            userData: data,
                            name: data.firstName + " " + data.lastName,
                            btnText:
                                controller.joinRequestMembers.contains(data)
                                    ? 'Accept Request'
                                    : 'Accepted')
                  ],
                ),
              ),
            );
          },
        ));
  }
}
