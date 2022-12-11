import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/models/group_model.dart';
import 'package:triumph_life_ui/models/notification_model.dart';
import 'package:intl/intl.dart';
import 'package:triumph_life_ui/models/post_model.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/screens/groups/group_home_page.dart';
import 'package:triumph_life_ui/screens/profile_view.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_preview.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_widget.dart';

notificationList({NotificationsModel data, function}) {
  NotificationController notificationController = Get.find();
  UserController userController = Get.find();
  GroupController groupController = Get.put(GroupController());
  return data.notificationType == null
      ? SizedBox()
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
          child: InkWell(
            onTap: () async {
              if (data.notificationType == 'Friend') {
                var doc = await data.action1Ref.get();
                Get.to(ProfileView(
                  userData: UserModel.fromDocumentSnapshot(doc),
                ));
              } else if (data.notificationType == 'Group') {
                if (userController.myGroups.contains(data.action1Ref.id)) {
                  var doc = await data.action1Ref.get();
                  groupController.selectedGroup =
                      GroupModel.fromDocumentSnapShot(doc);
                  Get.to(GroupHomePage());
                }
              } else if (data.notificationType == 'Post') {
                var doc = await data.action1Ref.get();
                Get.to(PostPreview(
                  post: PostModel.fromDocumentSnapShot(doc),
                ));
              } else {}
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: data.notificationType == null
                          ? Colors.green
                          : data.notificationType == 'Friend'
                              ? Colors.green
                              : data.notificationType == 'Group'
                                  ? Colors.red
                                  : data.subtype == 'Reaction'
                                      ? Colors.deepPurpleAccent
                                      : Colors.blue,
                    ),
                    width: 5,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35,
                          child: Text(
                            data.description,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              data.notificationType == null
                                  ? Icons.supervised_user_circle_rounded
                                  : data.notificationType == null
                                      ? Icons.supervised_user_circle_rounded
                                      : data.notificationType == 'Friend'
                                          ? Icons.supervised_user_circle_rounded
                                          : data.notificationType == 'Group'
                                              ? Icons.group
                                              : data.subtype == 'Reaction'
                                                  ? Icons.thumb_up_alt_sharp
                                                  : Icons.message,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                DateFormat('h:mm:a')
                                    .format(data.time.toDate())
                                    .toString(),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            if (!data.buttonDisable)
                              InkWell(
                                onTap: () {
                                  if (data.notificationType == 'Friend' &&
                                      data.subtype == 'Request Sent') {
                                    notificationController
                                        .acceptRequestFromNotification(
                                            data.action1Ref,
                                            data.notificationRef);
                                  } else if (data.notificationType == 'Group' &&
                                      data.subtype == 'Invite') {
                                    notificationController
                                        .acceptGroupJoinRequestFromNotification(
                                            data.action1Ref,
                                            data.notificationRef);
                                  }
                                },
                                child: Text(
                                  'Accept Request',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        data.notificationRef.delete();
                      })
                ],
              ),
            ),
          ),
        );
}
