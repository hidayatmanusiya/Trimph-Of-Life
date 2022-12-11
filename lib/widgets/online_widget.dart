import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/stream_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';
import 'package:triumph_life_ui/screens/live_streams/broadcast_page.dart';

class OnlineWidget extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final StreamController streamController = Get.put(StreamController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(builder: (liveController) {
      return Container(
        height: 75.0,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 15.0),
            InkWell(
              onTap: () {
                streamController.goToLive(userController.userData);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(width: 1.0, color: Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.video_call, size: 30.0, color: Colors.purple),
                    SizedBox(width: 5.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Create', style: TextStyle(color: Colors.blue)),
                        Text('Live Stream',
                            style: TextStyle(color: Colors.blue)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15.0),
            for (var live in liveController.liveList)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: InkWell(
                  onTap: () {
                    liveController.watchLive(live.id, userController.userData);
                  },
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                            live.pic == null || live.pic == ""
                                ? placeHolder
                                : live.pic),
                      ),
                      Positioned(
                        right: 1.0,
                        bottom: 1.0,
                        child: CircleAvatar(
                          radius: 6.0,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/Sam Wilson.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/greg.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/james.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/john.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/olivia.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/sophia.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/steven.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/andy.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 15.0),
            // Stack(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22.0,
            //       backgroundImage: AssetImage('assets/andrew.jpg'),
            //     ),
            //     Positioned(
            //       right: 1.0,
            //       bottom: 1.0,
            //       child: CircleAvatar(
            //         radius: 6.0,
            //         backgroundColor: Colors.green,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(width: 15.0),
          ],
        ),
      );
    });
  }
}
