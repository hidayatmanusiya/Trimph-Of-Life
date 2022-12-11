import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friend_card_row.dart';

class AllGroupAdmins extends StatelessWidget {
  final GroupController groupController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    groupController.getGroupAdmins();
    return Scaffold(
        appBar: AppBar(
          title: Text('All Admins'),
        ),
        body: GetBuilder<GroupController>(
          builder: (controller) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var data in controller.allAdmins)
                      if (userController.userData.userId != data.userId)
                        friendCardRow(
                            icon: controller.selectedGroup.admins
                                    .contains(data.userId)
                                ? Icons.remove_moderator
                                : Icons.add_moderator,
                            btnColor: controller.selectedGroup.admins
                                    .contains(data.userId)
                                ? Colors.orangeAccent
                                : Colors.greenAccent,
                            disableButton: !controller.selectedGroup.admins
                                .contains(userController.userData.userId),
                            onTapfunction: () {
                              if (controller.selectedGroup.admins
                                  .contains(data.userId)) {
                                controller.removeAdmin(data);
                              } else {
                                controller.addAdmin(data);
                              }
                            },
                            photoLink: data.profilePhoto,
                            userData: data,
                            name: data.firstName + " " + data.lastName,
                            btnText: controller.selectedGroup.admins
                                    .contains(data.userId)
                                ? 'Remove Admin'
                                : 'Make Admin')
                  ],
                ),
              ),
            );
          },
        ));
  }
}
