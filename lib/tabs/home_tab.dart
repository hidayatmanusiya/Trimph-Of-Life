// import 'package:triumph_life_ui/models/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/screens/create_post_page.dart';
import 'package:triumph_life_ui/sifat_changes/database_user_block.dart';
import 'package:triumph_life_ui/sifat_changes/model_user_block.dart';
// import 'package:triumph_life_ui/widgets/post_widget.dart';
// import 'package:triumph_life_ui/widgets/stories_widget.dart';
import 'package:triumph_life_ui/widgets/online_widget.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_widget.dart';
import 'package:triumph_life_ui/widgets/post_widget/write_post_button.dart';
import 'package:triumph_life_ui/widgets/separator_widget.dart';

// ignore: must_be_immutable
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  PostController postController = Get.put(PostController());

  DatabaseUserBlock databaseUserBlock = DatabaseUserBlock();
  List<ModelUserBlock> _list = [];

  @override
  void initState() {
    super.initState();
    GetDatabase();
  }

  void GetDatabase() {
    databaseUserBlock.initializeDatabase().then((value) {
      databaseUserBlock.getAllPrayerTimes().then((value) {
        _list = value;
        _list.forEach((element) {
          print("HelloAmir--list element ${element.user_id}");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // postController.getPosts();
    // void _writePost() {
    //   Get.to(WritePost());
    // }

    return GetBuilder<PostController>(builder: (controller) {
      return Scaffold(
        body: Column(
          children: [
            // writepostBtn(onTapfunction: () {
            //   return Get.to(CreatePostPage());
            // }),
            SeparatorWidget(),
            OnlineWidget(),
            // SeparatorWidget(),

            //  StoriesWidget(),
//          for(Post post in posts) Column(
//            children: <Widget>[
//              SepgotWidgs//              PostWidget(post: post),
//            ],
//          ),
            // SeparatorWidget(),
            /* -------------------------------------------------------------------------- */
            // Expanded(
            //   child: PaginateFirestore(
            //     itemBuilderType:
            //         PaginateBuilderType.listView, // listview and gridview
            //     // orderBy is compulsary to enable pagination
            //     query: FirebaseFirestore.instance
            //         .collection('Posts')
            //         .orderBy('time', descending: true),
            //     isLive: true, // to fetch real-time data
            //     itemBuilder: (index, context, documentSnapshot) {
            //       var post = PostModel.fromDocumentSnapShot(documentSnapshot);
            //       // groupAllPosts.add(post);
            //       //get likes
            //       controller.getLike(post);
            //       controller.getWow(post);
            //       controller.getHaha(post);
            //       controller.getSad(post);
            //       controller.getAngry(post);
            //       controller.getLove(post);
            //       controller.update();
            //       return PostCard(
            //         post: post,
            //       );
            //     },
            //   ),
            // ),
            /* -------------------------------------------------------------------------- */
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  print("refresh Call");
                  controller.listenHomePostScrollerScroller(context);
                  await Future.delayed(Duration(seconds: 2));
                  return true;
                },
                child: controller.allPosts.length == 0
                    ? Center(
                    //    child: Text('No Data...'),
                      )
                    : ListView.builder(
                        controller: controller.homeFeedScrollController,
                        itemCount: controller.allPosts.length,
                        itemBuilder: (context, index) {
                          // return PostCard(
                          //   post: controller.allPosts[index],
                          // );
                          bool isBlocked = false;
                          _list.forEach((element) {
                            if (controller.allPosts[index].userId ==
                                element.user_id) {
                              isBlocked = true;
                            }
                          });
                          if (isBlocked) {
                            print("HelloAmir--list blocked");
                            return Container(
                                // width: 120,
                                // height: 120,
                                // color: Colors.orange,
                                );
                          } else {
                            print("HelloAmir--list not blocked");
                            return PostCard(
                              post: controller.allPosts[index],
                            );
                          }
                        },
                      ),
              ),
            ),
            controller.isLoadingHomeFeeds || !controller.hasMoreHomeFeeds
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    color: Colors.yellowAccent,
                    // child: Text(
                    //   !controller.hasMoreHomeFeeds
                    //       ? 'No More Posts'
                    //       : 'Loading',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  )
                : Container()

            // for (var posts in controller.allPosts)
            //   PostCard(
            //     post: posts,
            //   ),
            /* -------------------------------------------------------------------------- */
          ],
        ),
      );
    });
  }
}

//     );
//   }
// }
