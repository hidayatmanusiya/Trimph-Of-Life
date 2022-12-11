import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Container/notification_container.dart';
import 'package:triumph_life_ui/newappcode/Models/models.dart';
import '../Api/notificationApi.dart';
import '../Container/post_container.dart';
import '../Data/notificationData.dart';
import '../Messaging/main.dart';
import '../Start/login.dart';
import '../Messaging/message.dart';
import '../Data/data.dart';
import 'package:flutter_svg/svg.dart';
import '../Navigation/bottomNavigationBar.dart';

class notification extends StatefulWidget {
  const notification({Key key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

// ignore: camel_case_types
class _notificationState extends State<notification> {

  int id;
  dynamic notificationdata;
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    initialGetsavedData();
    super.initState();
  }
  void initialGetsavedData() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    id = user.getInt('userId');
    final body = {'notification': 'notification', "user_id": '${id}'};
    notificationdata=ApiServicee_friends.get_notifications(body);
    setState(() {});
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
                      Expanded(
                        flex: 2,
                        child: Container(
                          child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp_()));
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
                      textDirection: TextDirection.ltr,
                      children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text('Notifications', textDirection: TextDirection.ltr,textAlign:TextAlign.left ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(color: Color(0xffC4C4C4), thickness: 2,),
                      SizedBox(height: 10,),
                      FutureBuilder<List<notificationData>>(
                                future: notificationdata,
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData == null) {
                                    return Container(
                                      child: Center(
                                        child: Text(
                                          'loading',
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    List<notificationData> data = snapshot.data;
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: data?.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            padding:
                                            const EdgeInsets.symmetric(vertical: 8.0),
                                            color: Colors.white,
                                            child:
                                            NotificationContainer(notifications: snapshot.data[index]),
                                          );
                                        });
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.all(5),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                            AlwaysStoppedAnimation(Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                    ],
                  ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(3),
        ),
      ),
    );
  }
}