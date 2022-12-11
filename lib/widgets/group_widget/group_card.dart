import 'package:flutter/material.dart';
import 'package:triumph_life_ui/common_widgets/constants/constants.dart';

groupCard({name, btnColor, photoLink, btnFunction, btnText}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(photoLink == '' ? placeHolder : photoLink),
              maxRadius: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: btnColor ?? Colors.blue),
                onPressed: btnFunction,
                child: Text(btnText))
          ],
        ),
      )));
}
