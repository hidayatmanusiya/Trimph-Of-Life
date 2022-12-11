import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/widgets/group_widget/group_card.dart';

import 'create_group.dart';
import 'group_home_page.dart';

class GroupMain extends StatefulWidget {
  @override
  _GroupMainState createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> {
  GroupController groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    groupController.getAllGroups();
    groupController.getMyGroups();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.yellow,
            title: Text("Group Section"),
            actions: [
              IconButton(
                  icon: Icon(Icons.group_add),
                  onPressed: () {
                    Get.to(() => CreateGroup());
                  })
            ],
          ),
          body: Container(
            height: 900,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TabBar(
                      // onTap: (index) {
                      //   switch (index) {
                      //     case 0:
                      //       friendController.getAlluser();
                      //       break;
                      //     case 1:
                      //       friendController.getFriendRequestList();
                      //       break;

                      //   }
                      // },
                      indicatorColor: Colors.red,
                      // isScrollable: true,
                      labelColor: Colors.red,
                      // backgroundColor: Colors.red,
                      // unselectedBackgroundColor: Colors.grey[300],
                      // unselectedLabelStyle: TextStyle(color: Colors.black),
                      // labelStyle: TextStyle(
                      //     color: Colors.red, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: "My Group",
                        ),
                        Tab(
                          text: "All Groups",
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
/* -------------------------------- my groups ------------------------------- */

                      Container(child: GetBuilder<GroupController>(
                        builder: (_) {
                          return ListView.builder(
                              itemCount: _.myGroups.length,
                              itemBuilder: (ctx, index) {
                                var groupData = _.myGroups[index];
                                return groupCard(
                                    btnFunction: () {
                                      _.selectedGroup = groupData;
                                      Get.to(GroupHomePage());
                                    },
                                    btnText: 'View',
                                    photoLink: groupData.gropProfile,
                                    name: groupData.groupName);
                              });
                        },
                      )),

/* ------------------------------- all groups ------------------------------- */

                      Container(child: GetBuilder<GroupController>(
                        builder: (_) {
                          return ListView.builder(
                              itemCount: _.allgroups.length,
                              itemBuilder: (ctx, index) {
                                var groupData = _.allgroups[index];
                                return groupCard(
                                    btnFunction: () {
                                      _.selectedGroup = groupData;
                                      _.isUserPresentInGroup(
                                              groupData.groupRef.id)
                                          ? Get.to(GroupHomePage())
                                          : _.isUserSendRequest(
                                                  groupData.groupRef.id)
                                              ? print('request sent')
                                              : _.isUserInvitedForGroup(
                                                      groupData.groupRef.id)
                                                  ? _.userAcceptInvitation(
                                                      groupData)
                                                  : _.joinGroup(groupData);
                                    },
                                    btnColor: _.isUserPresentInGroup(
                                            groupData.groupRef.id)
                                        ? Colors.blue
                                        : _.isUserSendRequest(
                                                groupData.groupRef.id)
                                            ? Colors.orange
                                            : _.isUserInvitedForGroup(
                                                    groupData.groupRef.id)
                                                ? Colors.green
                                                : Colors.lightBlue,
                                    btnText: _.isUserPresentInGroup(
                                            groupData.groupRef.id)
                                        ? 'View'
                                        : _.isUserSendRequest(
                                                groupData.groupRef.id)
                                            ? 'Request Sent'
                                            : _.isUserInvitedForGroup(
                                                    groupData.groupRef.id)
                                                ? 'Accept Request'
                                                : 'Join Group',
                                    photoLink: groupData.gropProfile,
                                    name: groupData.groupName);
                              });
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
