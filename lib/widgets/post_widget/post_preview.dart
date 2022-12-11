import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/widgets/post_widget/post_widget.dart';

class PostPreview extends StatelessWidget {
  final post;
  PostPreview({this.post});
  @override
  Widget build(BuildContext context) {
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
          children: [
            PostCard(
              post: post,
            ),
          ],
        ),
      ),
    );
  }
}
