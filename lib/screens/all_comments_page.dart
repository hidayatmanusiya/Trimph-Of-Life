import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/comment_controller.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';
import 'package:triumph_life_ui/widgets/time_stamp_to_string.dart';

// ignore: must_be_immutable
class AllCommentPage extends StatelessWidget {
  TextEditingController commentTextController = TextEditingController();
  CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'All Comments',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
                onPressed: () {
                  commentController.getAllComments();
                })
          ],
        ),
        body: GetBuilder<CommentController>(builder: (controller) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var comment in controller.commentList)
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      comment.userphoto == null ||
                                              comment.userphoto == ''
                                          ? placeHolder
                                          : comment.userphoto),
                                  radius: 15.0,
                                ),
                                SizedBox(width: 7.0),
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(comment.userName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0)),
                                              Text(
                                                  comment.time == null
                                                      ? 'now'
                                                      : timestampToString(
                                                          comment.time),
                                                  style:
                                                      TextStyle(fontSize: 12.0))
                                            ],
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(comment.comment,
                                              maxLines: 4,
                                              style: TextStyle(fontSize: 12.0))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    maxLines: null,
                    controller: commentTextController,
                    decoration: InputDecoration(
                      hintText: "Write Comment...",
                      suffix: IconButton(
                          icon: Icon(Icons.send_rounded),
                          onPressed: () {
                            //post Comment
                            if (commentTextController.text != null) {
                              commentController.postComment(
                                commentTextController.text,
                              );
                            }
                            commentTextController.text = '';
                          }),
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    onChanged: (message) {
                      //HelloSifat
                    },
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
