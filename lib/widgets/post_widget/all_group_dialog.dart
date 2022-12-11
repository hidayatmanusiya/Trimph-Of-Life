import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/widgets/group_widget/group_card.dart';

class AllGroupDialog extends StatelessWidget {
  final post;
  AllGroupDialog({this.post});
  final GroupController groupController = Get.put(GroupController());
  final PostController postController = Get.find();
  @override
  Widget build(BuildContext context) {
    groupController.getMyGroups();
    return Container(
      height: 600,
      child: AlertDialog(
          contentPadding: EdgeInsets.all(2),
          content: GetBuilder<GroupController>(builder: (_) {
            return Container(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var groupData in _.myGroups)
                      groupCard(
                          btnFunction: () {
                            if (groupData.sharePostsInGroup) {
                              Get.back();
                              postController.sharePostInGroup(post, groupData);
                            } else {
                              Get.snackbar('Not Allowed',
                                  'You can not share post in this group');
                            }
                          },
                          btnText: 'Share',
                          photoLink: groupData.gropProfile,
                          name: groupData.groupName)
                  ],
                ),
              ),
            );
          })),
    );
  }
}
