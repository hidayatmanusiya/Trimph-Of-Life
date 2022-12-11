import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/friends_api.dart';
import 'package:triumph_life_ui/newappcode/Container/friends_container.dart';
import 'package:triumph_life_ui/newappcode/Container/request_container.dart';
import 'package:triumph_life_ui/newappcode/Container/suggestion_container.dart';
import 'package:triumph_life_ui/newappcode/Data/data.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/main.dart';
import 'package:triumph_life_ui/newappcode/Models/friends_model.dart';
import '../Navigation/bottomNavigationBar.dart';
import '../Messaging/message.dart';

class friends extends StatefulWidget {
  const friends({Key key}) : super(key: key);

  @override
  _friendsState createState() => _friendsState();
}

// ignore: camel_case_types
class _friendsState extends State<friends> {

  int id;
  dynamic frienddata, requestdata, suggestiondata;
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
    initialGetsavedData();
  }

  void initialGetsavedData() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    id = user.getInt('userId');
    final body = {'suggestion': 'suggestion', "user_id": '${id}'};
    final body1 = {'friends': 'friends', "user_id": '${id}'};
    final body2 = {'requests': 'requests', "user_id": '${id}'};
    suggestiondata=ApiServicee_friends.get_friends(body);
    frienddata=ApiServicee_friends.get_friends(body1);
    requestdata=ApiServicee_friends.get_friends(body2);
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
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints.expand(height: 50),
                            child: TabBar(
                              indicatorColor: Color(0xffCC9B00),
                              labelColor: Colors.black,
                                unselectedLabelColor: Colors.black38,
                                tabs: [
                                  Tab(text: "Friends",),
                                  Tab(text: "Requests"),
                                  Tab(text: "Suggestions"),
                            ]),
                          ),
                          Expanded(
                            child: Container(
                              child: TabBarView(children: [
                                Container(
                                  child: FutureBuilder<List<friendss>>(
                                    future: frienddata,
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
                                        List<friendss> data = snapshot.data;
                                        //print(data?.length);
                                        return ListView.builder(
                                            itemCount: data?.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                padding:
                                                const EdgeInsets.symmetric(vertical: 8.0),
                                                color: Colors.white,
                                                child:
                                                FriendsContainer(friend: snapshot.data[index]),
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
                                ),
                                Container(
                                  child: FutureBuilder<List<friendss>>(
                                    future: requestdata,
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
                                        List<friendss> data = snapshot.data;
                                        //print(data?.length);
                                        return ListView.builder(
                                            itemCount: data?.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                padding:
                                                const EdgeInsets.symmetric(vertical: 8.0),
                                                color: Colors.white,
                                                child:
                                                RequestContainer(request: snapshot.data[index]),
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
                                ),
                                Container(
                                  child: FutureBuilder<List<friendss>>(
                                    future: suggestiondata,
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
                                        List<friendss> data = snapshot.data;
                                        //print(data?.length);
                                        return ListView.builder(
                                            itemCount: data?.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                padding:
                                                const EdgeInsets.symmetric(vertical: 8.0),
                                                color: Colors.white,
                                                child:
                                                SuggestionContainer(suggestion: snapshot.data[index]),
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
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(1),
        ),
      ),
    );
  }
}



