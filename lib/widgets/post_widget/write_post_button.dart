import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';

writepostBtn({onTapfunction}) {
  UserController userController = Get.find();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // CircleAvatar(
        //   radius: 25.0,
        //   backgroundImage:
        //       NetworkImage(userController.userData.profilePhoto == null
        //           ? placeHolder
        //           : userController.userData.profilePhoto == ''
        //               ? placeHolder
        //               : userController.userData.profilePhoto),
        // ),
        SizedBox(width: 7.0),
        Expanded(
          child: InkWell(
            onTap: onTapfunction,
            child: Container(
              // height: 30.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                // child: Text(
                //   'Tell us what is in your mind...',
                //   textAlign: TextAlign.left,
                // ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
