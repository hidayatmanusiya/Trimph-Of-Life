import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/chat_controller.dart';
import 'package:triumph_life_ui/Controller/friends_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friend_card_row.dart';

Widget suggestedFirends() {
  return GetBuilder<FriendController>(builder: (_) {
    // _.getAlluser();
    return Container(
        child: ListView.builder(
            itemCount: _.allUserList.length,
            itemBuilder: (context, i) {
              var data = _.allUserList[i];
              return

                  // /* !_.isRequestSent(data.refrence)?*/
                  _.checkFriendorRequestReceive(data.userId)
                      ? SizedBox()
                      : friendCardRow(
                          icon: _.isRequestSent(data.refrence)
                              ? Icons.cancel_presentation_outlined
                              : Icons.arrow_forward_ios,
                          btnColor: _.isRequestSent(data.refrence)
                              ? Colors.orange
                              : Colors.grey,
                          onTapfunction: () {
                            if (!_.isRequestSent(data.refrence) &&
                                !_.actionBlocked) {
                              _.sendRequest(data.refrence, data.token);
                            } else if (_.isRequestSent(data.refrence) &&
                                !_.actionBlocked) {
                              _.cancelRequest(data.refrence);
                            }
                          },
                          photoLink: data.profilePhoto,
                          userData: data,
                          name: data.firstName + " " + data.lastName,
                          btnText: _.isRequestSent(data.refrence)
                              ? 'Cancel Request'
                              : 'Add Friend')
                  // : SizedBox()
                  ;
            }));
  });
}

Widget firends() {
  ChatController chatController = Get.put(ChatController());
  UserController userController = Get.put(UserController());

  return GetBuilder<FriendController>(builder: (_) {
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
  });
}

Widget firendsRequests() {
  return GetBuilder<FriendController>(builder: (_) {
    return Container(
        child: ListView.builder(
            itemCount: _.allRequestList.length,
            itemBuilder: (context, i) {
              var data = _.allRequestList[i];
              return !_.isRequestSent(data.refrence)
                  ? friendCardRow(
                      icon: _.isRequestAccepted(data.refrence)
                          ? Icons.supervised_user_circle
                          : Icons.check,
                      btnColor: _.isRequestAccepted(data.refrence)
                          ? Colors.green
                          : Colors.blue,
                      onTapfunction: () {
                        if (!_.isRequestAccepted(data.refrence) &&
                            !_.actionBlocked) {
                          _.requestAccept(
                            data.refrence,
                            data.token,
                          );
                        }
                      },
                      photoLink: data.profilePhoto,
                      userData: data,
                      name: data.firstName + " " + data.lastName,
                      btnText: _.isRequestAccepted(data.refrence)
                          ? 'Accepted'
                          : 'Accept')
                  : SizedBox();
            }));
  });
}
