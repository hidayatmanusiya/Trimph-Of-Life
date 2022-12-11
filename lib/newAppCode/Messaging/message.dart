import 'package:flutter/material.dart';
import 'package:triumph_life_ui/newappcode/Container/message_container.dart';
import 'package:triumph_life_ui/newappcode/Data/data.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';

import '../Navigation/bottomNavigationBar.dart';

class message extends StatefulWidget {
  const message({Key  key}) : super(key: key);

  @override
  _messageState createState() => _messageState();
}

// ignore: camel_case_types
class _messageState extends State<message> {
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
                      Expanded(
                        flex: 2,
                        child: Container(
                          child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => message()));
                              },
                              child:Image(
                                alignment: Alignment.topRight,
                                height: 53.97,
                                width: 96,
                                image: AssetImage('assets/chat.png'),
                              )
                          ),
                        ),
                      ),
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
                            Text('Chats', textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Divider(color: Color(0xffC4C4C4), thickness: 2,),
                        SizedBox(height: 10,),
                        Expanded(
                          flex: 19,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                MessageContainer(message: messages[0]),
                                MessageContainer(message: messages[1]),
                                MessageContainer(message: messages[2]),
                                MessageContainer(message: messages[3]),
                                MessageContainer(message: messages[4]),
                                MessageContainer(message: messages[5]),
                                MessageContainer(message: messages[6]),
                                MessageContainer(message: messages[7]),
                                MessageContainer(message: messages[0]),
                                MessageContainer(message: messages[8]),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(0),
        ),
      ),
    );
  }
}