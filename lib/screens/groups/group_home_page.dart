import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_widget.dart';
import 'package:triumph_life_ui/widgets/post_widget/write_post_button.dart';
import 'package:triumph_life_ui/widgets/separator_widget.dart';

// import 'create_post_page.dart';
import '../create_post_page.dart';
import 'group_details_page.dart';

class GroupHomePage extends StatelessWidget {
  PostController postController = Get.put(PostController());
  GroupController groupController = Get.find();
  @override
  Widget build(BuildContext context) {
    postController.listenGroupPostScrollerScroller(
        context, groupController.selectedGroup.groupRef);
    // postController.getPostsForGroups(groupController.selectedGroup.groupRef);
    return Scaffold(
        appBar: AppBar(
          title: Text('Group Name'),
          actions: [
            IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  Get.to(GroupDetailsPage());
                })
          ],
        ),
        body: GetBuilder<PostController>(builder: (controller) {
          return Column(
            children: <Widget>[
              writepostBtn(onTapfunction: () {
                return Get.to(CreatePostPage(actionFrom: "groups"));
              }),
              SeparatorWidget(),
              // // OnlineWidget(),
              // SeparatorWidget(),

              //  StoriesWidget(),
//          for(Post post in posts) Column(
//            children: <Widget>[
//              SeparatorWidget(),
//              PostWidget(post: post),
//            ],
//          ),
              // SeparatorWidget(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print("refresh Call");
                    controller.listenGroupPostScrollerScroller(
                        context, groupController.selectedGroup.groupRef);
                    await Future.delayed(Duration(seconds: 2));
                    return true;
                  },
                  child: controller.groupAllPosts.length == 0
                      ? Center(
                          child: Text('No Data...'),
                        )
                      : ListView.builder(
                          controller: controller.groupScrollController,
                          itemCount: controller.groupAllPosts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              post: controller.groupAllPosts[index],
                            );
                          },
                        ),
                ),
              ),
              controller.isLoadingGroupFeeds || !controller.hasMoreGroupFeeds
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      color: Colors.yellowAccent,
                      child: Text(
                        !controller.hasMoreGroupFeeds
                            ? 'No More Posts'
                            : 'Loading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container()
              // for (var posts in controller.groupAllPosts)
              //   PostCard(
              //     post: posts,
              //   ),
            ],
          );
        }));
  }
}
