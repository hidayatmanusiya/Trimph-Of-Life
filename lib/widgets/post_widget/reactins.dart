import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

reactionIcon(gif, png, txt, Color color) {
  return Reaction(
    previewIcon: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(gif))),
    ),
    icon: Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(png))),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          txt,
          style: TextStyle(color: color),
        )
      ],
    ),
  );
}
