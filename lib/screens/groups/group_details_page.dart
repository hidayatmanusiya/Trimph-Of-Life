import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/screens/groups/all_group_Admins.dart';
import 'package:triumph_life_ui/screens/groups/friends_for_group_invitation.dart';

import 'all_group_members.dart';
import 'all_group_requests.dart';

class GroupDetailsPage extends StatelessWidget {
  final GroupController groupController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    groupController.getGroup10Members();
    groupController.getGroupAllMembers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<GroupController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ElevatedButton(
                    //         onPressed: () {}, child: Text('View Members')),
                    //     ElevatedButton(
                    //         onPressed: () {
                    //           Get.to(AllGroupAdmins());
                    //         },
                    //         child: Text('View Admins')),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ElevatedButton(
                    //         onPressed: () {
                    //           Get.to(FriendsForGroupInvitation());
                    //         },
                    //         child: Text('invite a user')),
                    //     ElevatedButton(
                    //         onPressed: () {
                    //           Get.to(AllGroupRequests());
                    //         },
                    //         child: Text('Join Requests')),
                    //   ],
                    // ),
                    _customText('about', size: 18, weight: FontWeight.bold),
                    space,
                    _customText(_.selectedGroup.description, size: 14), space,
                    _customText(
                      'Group Rules From Admin',
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    space,
                    _customText(
                        _.selectedGroup.rules == ''
                            ? 'No group rule define by admin'
                            : _.selectedGroup.rules,
                        size: 14),
                    space,
                    Row(
                      children: [
                        Icon(Icons.public),
                        _customText(
                          _.selectedGroup.privacy,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                      ],
                    ),
                    space,
                    _customText('Any user can join the group', size: 14),
                    space,

                    // Row(
                    //   // crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _customText('Members',
                    //         size: 18, weight: FontWeight.bold),
                    //     TextButton(onPressed: () {}, child: Text('See All'))
                    //   ],
                    // ),
                    space,
                    TextButton(
                        onPressed: () {
                          Get.to(AllGroupMember());
                        },
                        child: Text('See All Members',
                            style: TextStyle(fontSize: 12))),
                    Container(
                      height: 70,

                      // width: 200,
                      child: ListView.builder(
                          itemCount: _.group10User.length > 10
                              ? 10
                              : _.group10User.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            var _userData = _.group10User[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(_userData.profilePhoto),
                                  ),
                                  _customText(_userData.firstName ?? '',
                                      size: 10)
                                ],
                              ),
                            );
                          }),
                    ),
                    space,
                    if (_.selectedGroup.admins
                        .contains(userController.userData.userId))
                      Container(
                        // height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                space,
                                _customText('Admin Panel',
                                    size: 18, weight: FontWeight.bold),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // TextButton(
                                    //     onPressed: () {
                                    //       Get.to(AllGroupMember());
                                    //     },
                                    //     child: Text('View Members',
                                    //         style: TextStyle(fontSize: 12))),
                                    TextButton(
                                        onPressed: () {
                                          Get.to(AllGroupAdmins());
                                        },
                                        child: Text('View Admins',
                                            style: TextStyle(fontSize: 12))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.to(FriendsForGroupInvitation());
                                        },
                                        child: Text('invite a user',
                                            style: TextStyle(fontSize: 12))),
                                    TextButton(
                                        onPressed: () {
                                          Get.to(AllGroupRequests());
                                        },
                                        child: Text('Join Requests',
                                            style: TextStyle(fontSize: 12))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () {
                              _.leaveGroup();
                            },
                            child: Text('Leave Group')),
                      ],
                    ),
                    space,
                    // Text('abc'),
                  ],
                );
              },
            )),
      ),
    );
  }
}

var space = SizedBox(
  height: 10,
);

Widget _customText(txt, {double size = 16, weight = FontWeight.normal}) {
  return Text(
    txt,
    style: TextStyle(fontSize: size, fontWeight: weight),
  );
}
