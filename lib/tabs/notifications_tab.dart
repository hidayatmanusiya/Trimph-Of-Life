import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/notification_controller.dart';
import 'package:triumph_life_ui/widgets/notification_widget.dart';

// ignore: must_be_immutable
class NotificationsTab extends StatelessWidget {
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    notificationController.getNotification();
    return Scaffold(
      body: GetBuilder<NotificationController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                      child: Text('Notifications',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _.notificationList.length,
                          itemBuilder: (context, i) {
                            return notificationList(
                                data: _.notificationList[i]);
                          }),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
