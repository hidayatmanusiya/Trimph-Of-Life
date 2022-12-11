import 'package:flutter/material.dart';

postImage(context, String imageURL, double width, double height) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image(
        image: NetworkImage(imageURL),

        // imageUrl: imageURL,
        // placeholder: (context, url) => Container(
        //   transform: Matrix4.translationValues(0.0, 0.0, 0.0),
        //   child: Container(
        //       width: width,
        //       height: height,
        //       child: Center(child: new CircularProgressIndicator())),
        // ),
        // errorWidget: (context, url, error) => new Icon(Icons.error),
        // width: 500,
        // height: 300,
        // fit: BoxFit.cover,
      ),
    ),
  );
}
