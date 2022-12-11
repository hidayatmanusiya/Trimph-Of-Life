import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';

import 'create_event.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.yellow,
            title: Text("Event Section"),
            actions: [
              IconButton(
                  icon: Icon(Icons.add_location_rounded),
                  onPressed: () {
                    Get.to(CreateEvent());
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
                          text: "My Events",
                        ),
                        Tab(
                          text: "All Events",
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
                          return Container();
                        },
                      )),

/* ------------------------------- all groups ------------------------------- */

                      Container(child: GetBuilder<GroupController>(
                        builder: (_) {
                          return Container();
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
