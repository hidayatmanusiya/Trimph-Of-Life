import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/group_Controller.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/common_widgets/button_widget.dart';
import 'package:triumph_life_ui/common_widgets/spaces_widgets.dart';
import 'package:triumph_life_ui/common_widgets/text_field.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  UserController userController = Get.put(UserController());
  GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
        ),
        body: Form(
          key: _.groupFormKey,
          child: Container(
            // height: Get.height,
            // width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _.imgFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: _.groupPhoto != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _.groupPhoto,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                  _heading('GroupName'),
                  textBox(
                    hint: "Name",
                    validator: _.groupNameValidator,
                    onSave: (input) {
                      _.groupName = input;
                    },
                  ),
                  spc20,
                  _heading('Description'),
                  textBox(
                    hint: "Description",
                    maxLine: null,
                    onSave: (input) {
                      _.description = input;
                    },
                  ),
                  spc20,
                  _heading('Privacy'),
                  Container(
                    height: 100,
                    width: Get.width,
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          items: _.data.keys.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Icon(_.data[val]),
                                  ),
                                  Text(val),
                                ],
                              ),
                            );
                          }).toList(),
                          hint: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(_.selectedIcon ??
                                    _.data.values.toList()[0]),
                              ),
                              Text(_.selectedType ?? _.data.keys.toList()[0]),
                            ],
                          ),
                          onChanged: (String val) {
                            _.selectedType = val;
                            _.selectedIcon = _.data[val];
                            _.update();
                          }),
                    ),
                  ),
                  // spc20,
                  _checkBox('Share Group Post', (val) {
                    _.shareGroupPost = val;
                    _.update();
                  }, _.shareGroupPost),
                  spc20,
                  _checkBox('Share Post In Group', (val) {
                    _.sharePostInGroup = val;
                    _.update();
                  }, _.sharePostInGroup),
                  spc20,
                  _heading('Rules'),
                  textBox(
                    maxLine: 5,
                    hint: "Rules No.1 ...",
                    onSave: (input) {
                      _.rules = input;
                    },
                  ),
                  spc20,
                  buttonBox(
                      txt: "Create Group",
                      onTap: () {
                        _.createGroup();
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _checkBox(txt, onPressFunction, val) {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.greenAccent,
            activeColor: Colors.red,
            value: val,
            onChanged: onPressFunction),
        Expanded(child: Text(txt))
      ],
    );
  }

  _heading(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
