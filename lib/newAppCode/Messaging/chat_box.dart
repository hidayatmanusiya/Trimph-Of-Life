import 'package:flutter/material.dart';
import 'package:triumph_life_ui/newappcode/Container/message_container.dart';
import 'package:triumph_life_ui/newappcode/Data/data.dart';
import 'package:triumph_life_ui/newappcode/Models/message_model.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import '../Navigation/bottomNavigationBar.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';

import '../User/globalUser.dart';
import 'conversation.dart';

class chatBox extends StatefulWidget {
  const chatBox({Key  key}) : super(key: key);

  @override
  _chatBoxState createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body:Container(
        width: width,
        height: height,
        child: Scaffold(
          body: Container(
            color:  Color(0xffCC9B00),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child:Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child:Image(
                            alignment: Alignment.topLeft,
                            height: 161,
                            width: 333,
                            image: AssetImage('assets/logo1.png'),
                          ),
                        ),
                      ),
                        IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Icons.videocam_outlined,
                              size: 28,
                            ),
                            onPressed: () {}),
                        IconButton(
                          color: Colors.white,
                            icon: Icon(
                              Icons.call,
                              size: 28,
                            ),
                            onPressed: () {})
                    ],
                  ),
                ),
                Expanded(
                  flex: 23,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      textDirection: TextDirection.ltr,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Expanded(child:
                            ProfileAvatar(imageUrl:'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80', key: null,),
                            ),
                            Expanded(child:
                            Text(
                              'William Brook',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),),
                            Expanded(child:
                            IconButton(
                              alignment: Alignment.centerRight,
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () => print('More'),
                            ),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Color(0xffC4C4C4), thickness: 2,),
                        SizedBox(height: 10,),
                        Expanded(
                          flex: 19,
                          child:SingleChildScrollView(
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //bottomNavigationBar: BottomNavigation(0),
        ),
      ),
    );
  }
}

class mesg extends StatelessWidget {
  const mesg({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("you",textDirection: TextDirection.rtl,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            ],
          )
        ],
      ),
    );
  }
}
