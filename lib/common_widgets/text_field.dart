import 'package:flutter/material.dart';

Widget textBox(
    {hint = '',
    validator,
    controller,
    maxLine = 1,
    texthide = false,
    onSave,
    keyboardtype = TextInputType.text}) {
  return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Flexible(
            child: new TextFormField(
              obscureText: texthide,
              onSaved: onSave,
              controller: controller,
              validator: validator,
              keyboardType: keyboardtype, maxLines: maxLine,
              decoration: InputDecoration(
                fillColor: Colors.blue,
                hintText: '$hint',
              ),
//                            controller: nameController,
            ),
          ),
        ],
      ));
}
