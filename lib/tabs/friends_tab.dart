import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/friends_controller.dart';
import 'package:triumph_life_ui/widgets/friendTab_widgets/friends_tab_view.dart';

// ignore: must_be_immutable
class FriendsTab extends StatefulWidget {
  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  FriendController friendController = Get.put(FriendController());
  @override
  // ignore: must_call_super
  void initState() {
    friendController.getallData();
  }

  @override
  Widget build(BuildContext context) {
    friendController.getallData();
    return 
    DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            height: 900,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TabBar(
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            friendController.getAlluser();
                            break;
                          case 1:
                            friendController.getFriendRequestList();
                            break;
                          case 2:
                            friendController.getFriensList();
                            break;
                        }
                      },
                      indicatorColor: Colors.red,
                      isScrollable: true,
                      labelColor: Colors.red,
                      // backgroundColor: Colors.red,
                      // unselectedBackgroundColor: Colors.grey[300],
                      // unselectedLabelStyle: TextStyle(color: Colors.black),
                      // labelStyle: TextStyle(
                      //     color: Colors.red, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          // child: InkWell(
                          //     onTap: () {
                          //       friendController.getAlluser();
                          //     },
                          //     child: Text('tapp')),
                          // icon: Icon(Icons.directions_car),
                          text: "Suggested Friends",
                        ),
                        Tab(
                          // icon: Icon(Icons.directions_transit),
                          text: "Friends Request",
                        ),
                        Tab(
                          // icon: Icon(Icons.directions_transit),
                          text: "Friends",
                        )
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      suggestedFirends(),
                      firendsRequests(),
                      firends(),
                      // Center(
                      //   child: Icon(Icons.directions_bike),
                      // ),
                      // Center(
                      //   child: Icon(Icons.directions_bike),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        );

    // Text('Friends',
    //     style:
    //         TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
    // SizedBox(height: 15.0),
    // Row(
    //   children: <Widget>[
    //     Container(
    //       padding:
    //           EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    //       decoration: BoxDecoration(
    //           color: Colors.grey[300],
    //           borderRadius: BorderRadius.circular(30.0)),
    //       child: Text('Suggestions',
    //           style: TextStyle(
    //               fontSize: 17.0, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(width: 10.0),
    //     Container(
    //       padding:
    //           EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    //       decoration: BoxDecoration(
    //           color: Colors.grey[300],
    //           borderRadius: BorderRadius.circular(30.0)),
    //       child: Text('All Friends',
    //           style: TextStyle(
    //               fontSize: 17.0, fontWeight: FontWeight.bold)),
    //     )
    //   ],
    // ),

    // Divider(height: 30.0),

//            Row(
//              children: <Widget>[
//                Text('Friend Requests', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
//
//                SizedBox(width: 10.0),
//
//                Text('8', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold, color: Colors.red)),
//              ],
//            ),

//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/chris.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Chris', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/adelle.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Adelle', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/dan.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Danny smith', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/eddison.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Eddison', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/jeremy.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Jeremy', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/joey.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Joey', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/kalle.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Kalle Jackson', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/marcus.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Marcus Fenix', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            Divider(height: 30.0),
//
//            Text('People You May Know', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/mathew.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Mathew', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/joey.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Joey', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/adelle.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Adelle', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/timothy.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Timothy', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/jeremy.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Jeremy', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//
//            SizedBox(height: 20.0),
//
//            Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: AssetImage('assets/tanya.jpg'),
//                  radius: 40.0,
//                ),
//                SizedBox(width: 20.0),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Tanya', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 15.0),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.blue,
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//                        ),
//                        SizedBox(width: 10.0),
//                        Container(
//                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//                        ),
//                      ],
//                    )
//                  ],
//                )
//              ],
//            ),
//            SizedBox(height: 20.0)
  }
}
