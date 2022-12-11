import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:triumph_life_ui/Controller/stream_controller.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';

import 'appId.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;

  const BroadcastPage({Key key, this.channelName, this.isBroadcaster})
      : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  StreamController streamController = Get.find();
  final _users = <int>[];
  RtcEngine _engine;
  bool muted = false;
  bool showMessages = true;
  bool showMessage = true;
  bool isChanelJoined = false;
  /* -------------------------------------------------------------------------- */
  bool showComment = false, fullScreen = false, isWritingComment = false;

  /* -------------------------------------------------------------------------- */

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (widget.isBroadcaster) {
          streamController.addDataInLive();
        }
        setState(() {
          print('onJoinChannel: $channel, uid: $uid');
          isChanelJoined = true;
        });
      },
      leaveChannel: (stats) {
        setState(() {
          print('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          print('userJoined: $uid');

          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          print('userOffline: $uid');
          _users.remove(uid);
          streamController.removeDataFromLive(streamController.userChanel);
        });
      },
    ));

    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(builder: (liveController) {
      return WillPopScope(
        onWillPop: () {
          widget.isBroadcaster
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: new Text("Warning"),
                        content:
                            new Text("Are you sure to end the Live Stream"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text('Yes'),
                            onPressed: () {
                              _onCallEnd(context);
                              Get.back();
                              Get.back();
                              // streamController.removeDataFromLive(
                              //     streamController.userLiveData.id);
                            },
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No"),
                          )
                        ],
                      ))
              : Get.back();
          return;
        },
        child: Scaffold(
          body: Center(
            child: liveController.userChanel == ''
                ? Text('User goes Offline')
                : Stack(
                    children: <Widget>[
                      _broadcastView(),
                      // _toolbar(),
                      // if (showMessage)
                      //   Positioned(
                      //       top: 50,
                      //       bottom: 0,
                      //       left: 0,
                      //       right: 0,
                      //       child: Container(
                      //         color: Colors.black12,
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               'here is messages',
                      //               style: TextStyle(
                      //                   fontSize: 20, color: Colors.white),
                      //             )
                      //           ],
                      //         ),
                      //       ))
                      Positioned(
                        top: 50,
                        left: 00,
                        right: 00,
                        child: Container(
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                !widget.isBroadcaster && widget.isBroadcaster
                                    ? InkWell(
                                        onTap: () {
                                          liveController.sendMessage();
                                          setState(() {
                                            fullScreen = !fullScreen;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 8),
                                            child: Text(
                                              fullScreen
                                                  ? 'Half Screen'
                                                  : 'Full Screen',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(width: 40),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showComment = !showComment;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: !showComment
                                            ? Colors.blue
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: Text(
                                        showComment
                                            ? 'Hide Comment'
                                            : 'Show Comment',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (showComment)
                        Positioned(
                          left: 10,
                          top: 90,
                          bottom: widget.isBroadcaster ? 130 : 20,
                          right: 60,
                          child: Container(
                            // color: Colors.bl
                            child: Column(
                              children: [
                                Expanded(
                                  child: PaginateFirestore(
                                    itemBuilderType: PaginateBuilderType
                                        .listView, // listview and gridview
                                    reverse: true,
                                    // orderBy is compulsary to enable pagination
                                    query: FirebaseFirestore.instance
                                        .collection('Lives')
                                        .doc(liveController.userChanel)
                                        .collection('LiveChat')
                                        .orderBy('time', descending: true),
                                    isLive: true,
                                    emptyDisplay: SizedBox(),

                                    // reverse: true, // to fetch real-time data
                                    itemBuilder:
                                        (index, context, documentSnapshot) {
                                      // groupAllPosts.add(post);
                                      //get likes

                                      return messageCard(
                                          imageLink: documentSnapshot
                                              .data()['picture'],
                                          name: documentSnapshot.data()['name'],
                                          message: documentSnapshot
                                              .data()['message']);
                                    },
                                  ),
                                  // child: SingleChildScrollView(
                                  //   child: Column(
                                  //     children: [
                                  //       messageCard(message: 'hahhahah' * 13),
                                  //       messageCard(message: 'hahhahah' * 3),
                                  //       messageCard(message: 'hahhahah' * 53),
                                  //       messageCard(message: 'hahhahah' * 3),
                                  //       messageCard(message: 'hahhahah' * 13),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                                if (!widget.isBroadcaster)
                                  messageField(
                                      onSendFunction: () {
                                        liveController.sendMessage();
                                      },
                                      controller:
                                          liveController.messageTextController,
                                      fillBlackColor: true)
                              ],
                            ),
                          ),
                        ),
                      if (widget.isBroadcaster)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              color: Colors.black54,
                              child: Column(
                                children: [
                                  if (isWritingComment)
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: messageField(
                                            onSendFunction: () {
                                              liveController.sendMessage();
                                            },
                                            controller: liveController
                                                .messageTextController)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isWritingComment =
                                                !isWritingComment;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 8),
                                            child: Text(
                                              isWritingComment
                                                  ? 'Dismis Comment'
                                                  : 'Write Comment',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _onToggleMute();
                                          },
                                          icon: Icon(
                                            muted ? Icons.mic_off : Icons.mic,
                                            color: muted
                                                ? Colors.red
                                                : Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            _onSwitchCamera();
                                          },
                                          icon: Icon(
                                            Icons.switch_camera,
                                            color: Colors.white,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoAlertDialog(
                                                    title: new Text("Warning"),
                                                    content: new Text(
                                                        "Are you sure to end the Live Stream"),
                                                    actions: <Widget>[
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        child: Text('Yes'),
                                                        onPressed: () {
                                                          _onCallEnd(context);
                                                          Get.back();

                                                          // streamController
                                                          // .removeDataFromLive(
                                                          //     streamController
                                                          //         .userLiveData
                                                          //         .id);
                                                          // Get.back();
                                                        },
                                                      ),
                                                      CupertinoDialogAction(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text("No"),
                                                      )
                                                    ],
                                                  ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 8),
                                            child: Text(
                                              'End Stream',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )),
                        ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 50,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8),
                              child: Text(
                                'Live',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  Widget messageField({controller, onSendFunction, fillBlackColor = false}) {
    return Container(
        decoration: BoxDecoration(
            color: fillBlackColor ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onSendFunction,
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white70),
                hintText: "Write something here...",
              ),
            ),
          ),
        ));
  }

  // Widget _toolbar() {
  //   return widget.isBroadcaster
  //       ? Container(
  //           alignment: Alignment.bottomCenter,
  //           padding: const EdgeInsets.symmetric(vertical: 48),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               RawMaterialButton(
  //                 onPressed: _onToggleMute,
  //                 child: Icon(
  //                   muted ? Icons.mic_off : Icons.mic,
  //                   color: muted ? Colors.white : Colors.blueAccent,
  //                   size: 20.0,
  //                 ),
  //                 shape: CircleBorder(),
  //                 elevation: 2.0,
  //                 fillColor: muted ? Colors.blueAccent : Colors.white,
  //                 padding: const EdgeInsets.all(12.0),
  //               ),
  //               RawMaterialButton(
  //                 onPressed: () => _onCallEnd(context),
  //                 child: Icon(
  //                   Icons.call_end,
  //                   color: Colors.white,
  //                   size: 35.0,
  //                 ),
  //                 shape: CircleBorder(),
  //                 elevation: 2.0,
  //                 fillColor: Colors.redAccent,
  //                 padding: const EdgeInsets.all(15.0),
  //               ),
  //               RawMaterialButton(
  //                 onPressed: _onSwitchCamera,
  //                 child: Icon(
  //                   Icons.switch_camera,
  //                   color: Colors.blueAccent,
  //                   size: 20.0,
  //                 ),
  //                 shape: CircleBorder(),
  //                 elevation: 2.0,
  //                 fillColor: Colors.white,
  //                 padding: const EdgeInsets.all(12.0),
  //               ),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    // if (isChanelJoined && _users.isEmpty && !widget.isBroadcaster) {
    //   streamController.removeDataFromLive(streamController.userChanel);
    // }
    // setState(() {});
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  Widget messageCard({name = '', imageLink = '', message = ''}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(
        backgroundColor: Colors.black12,
        backgroundImage:
            NetworkImage(imageLink == '' ? placeHolder : imageLink),
        radius: 20.0,
      ),
      Expanded(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                  ],
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    streamController.removeDataFromLive(streamController.userLiveData.id);
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}
