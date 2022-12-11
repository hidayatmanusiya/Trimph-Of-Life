import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/post_controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/screens/profile_view.dart';

// ignore: must_be_immutable
class CreatePostPage extends StatelessWidget {
  final actionFrom;
  CreatePostPage({this.actionFrom});
  UserController userController = Get.put(UserController());
  PostController postController = Get.put(PostController());
  GroupController groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            ElevatedButton(
                onPressed: controller.postpic != null ||
                        controller.postTextController.text != ''
                    ? () {
                        if (actionFrom == null) {
                          controller.savePost();
                        } else if (actionFrom == 'groups') {
                          controller.savePostForGroup(
                              groupController.selectedGroup, context);
                        }
                      }
                    : null,
                child: Text('Post'))
          ],
          title: Text(
            'Create Post',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ProfileView(
                            userData: userController.userData,
                          ));
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              userController.userData.profilePhoto),
                          maxRadius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          userController.userData.firstName +
                              ' ' +
                              userController.userData.lastName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //
                  TextField(
                    onChanged: (val) {
                      controller.update();
                    },
                    keyboardType: TextInputType.multiline,
                    controller: controller.postTextController,
                    maxLines: controller.postpic == null
                        ? controller.postTextController.text.length < 20
                            ? 2
                            : 8
                        : 8,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Whats in your Mind ..."),
                    style: TextStyle(
                        fontSize: controller.postpic == null
                            ? controller.postTextController.text.length < 20
                                ? 40
                                : controller.postTextController.text.length <
                                        100
                                    ? 25
                                    : 16
                            : 16),
                  ),
                  if (controller.postpic != null)
                    Container(
                      height: 220.0,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(controller.postpic),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (controller.postpic == null) {
                              controller.selectPhoto(context);
                            } else {
                              controller.deletePhoto();
                            }
                          },
                          child: Text(controller.postpic != null
                              ? 'Delete Photo'
                              : 'Upload Photo'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
