// import 'package:triumph_life_ui/widgets/separator_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/loading_controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/common_widgets/commonWidgetAll.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';
import 'package:triumph_life_ui/common_widgets/spaces_widgets.dart';
import 'package:triumph_life_ui/models/userModel.dart';
import 'package:triumph_life_ui/widgets/edit_button.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_widget.dart';
import 'package:triumph_life_ui/widgets/separator_widget.dart';

class ProfileView extends StatefulWidget {
  final UserModel userData;
  ProfileView({this.userData});
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Loader loader = Get.put(Loader());

  UserController userController = Get.put(UserController());
  PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    postController.listenUserPostScrollerScroller(context, widget.userData);
    var userData = widget.userData;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.black,
            // size: 14,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 260.0,
            child: Stack(
              children: <Widget>[
                if (userData.coverPhoto != null && userData.coverPhoto != '')
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    height: 160.0,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(userData.coverPhoto == '' ||
                                    userData.coverPhoto == null
                                ? placeHolder
                                : userData.coverPhoto),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(

                                  // color: Colors.grey[200],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          userData.profilePhoto == null ||
                                                  userData.profilePhoto == ''
                                              ? placeHolder
                                              : userData.profilePhoto),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Text(
                            '${userData.firstName} ${userData.lastName}' == null
                                ? "Name"
                                : '${userData.firstName} ${userData.lastName}',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                infoRow('Gender', userData.gender),
                spc20,
                infoRow('Date of Birth', userData.dob),
                spc20,
                infoRow('Email', userData.email),
                spc20,
                infoRow('Country', userData.country),
                spc20,
                infoRow('State', userData.state),
                spc20,
                infoRow('Profession', userData.profession),
                spc20,
                SizedBox(height: 15.0),
                // InkWell(
                //   onTap: () {},
                //   child: editButton("own", "Send Message"),
                // ),
              ],
            ),
          ),
//
          Divider(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ],
          ),
          SeparatorWidget(),

          GetBuilder<PostController>(builder: (pController) {
            return Container(
              height: Get.height - 150,
              // color: Colors.red,
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        print("refresh Call");
                        pController.listenUserPostScrollerScroller(
                            context, widget.userData);
                        await Future.delayed(Duration(seconds: 2));
                        return true;
                      },
                      child: pController.userPosts.length == 0
                          ? Center(
                              child: Text('No Data...'),
                            )
                          : ListView.builder(
                              controller: pController.userScrollController,
                              itemCount: pController.userPosts.length,
                              itemBuilder: (context, index) {
                                return PostCard(
                                  post: pController.userPosts[index],
                                );
                              },
                            ),
                    ),
                  ),
                  pController.isLoadingUserFeeds ||
                          !pController.hasMoreUserFeeds
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5),
                          color: Colors.yellowAccent,
                          child: Text(
                            !pController.hasMoreUserFeeds
                                ? 'No More Posts'
                                : 'Loading',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container()

                  // for (var posts in postController.userPosts)
                  //   PostCard(
                  //     post: posts,
                  //   ),
                ],
              ),
            );
          }),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text('Friends',
          //                   style: TextStyle(
          //                       fontSize: 22.0, fontWeight: FontWeight.bold)),
          //               SizedBox(height: 6.0),
          //               Text('536 friends',
          //                   style: TextStyle(
          //                       fontSize: 16.0, color: Colors.grey[800])),
          //             ],
          //           ),
          //           Text('Find Friends',
          //               style: TextStyle(fontSize: 16.0, color: Colors.blue)),
          //         ],
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/samantha.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Samantha',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/andrew.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Andrew',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/Sam Wilson.jpg'),
          //                           fit: BoxFit.cover),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Sam Wilson',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/steven.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Steven',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/greg.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Greg',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/andy.jpg'),
          //                           fit: BoxFit.cover),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Andy',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.symmetric(vertical: 15.0),
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           color: Colors.grey[300],
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         child: Center(
          //             child: Text('See All Friends',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 16.0))),
          //       ),
          //     ],
          //   ),
          // ),
          SeparatorWidget()
        ],
      )),
    );
  }
}
