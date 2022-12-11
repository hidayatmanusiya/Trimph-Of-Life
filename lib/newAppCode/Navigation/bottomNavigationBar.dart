import 'package:flutter/material.dart';
import 'package:triumph_life_ui/newappcode/screens/friends.dart';
import 'package:triumph_life_ui/newappcode/screens/homeScreen.dart';
import 'package:triumph_life_ui/newappcode/screens/info.dart';
import 'package:triumph_life_ui/newappcode/screens/notification.dart';
import 'package:triumph_life_ui/newappcode/screens/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  int _selectedIndex;
  BottomNavigation(this._selectedIndex , {Key  key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}
class _BottomNavigationState extends State<BottomNavigation> {
  final key = GlobalKey<State<BottomNavigationBar>>();
  int _selectedIndex = 0;
  static double iconeWidth = 25;
  static double iconesHeight = 25;
  double spaceBtIconeText = 8.0;
  String  useremail;
  String  userstore;
  String  userRole;
  int storeLength;
  String  app_version;
  final iconColor = Color(0xFFCC9B00);
  final selectedIconColor = Color(0xFFCC9B00);
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontFamily: "SourceSansPro-Regular");
  bool firstsyncRequired = false;
  final List<Widget> _children = [
    homeScreen(),
    friends(),
    profile(),
    notification(),
    info(),
  ];
  _BottomNavigationState(){
    loadData();
  }
  @override
  void initState()  {
    super.initState();
    checkfirstsync();
    _selectedIndex = widget._selectedIndex;
  }
  loadData()async {
  }
  checkfirstsync() async {
  }
  Future<void> _onItemTapped(int index) async {
    _selectedIndex = index;
    // it condition will use to check sync is reqired or not
    if (index < 5)
      Navigator.pushReplacement(context,PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => _children[_selectedIndex],
      ));
    if (firstsyncRequired == false && index != 2)
      setState(() {
        _selectedIndex = index;
      });
  }
  @override
  Widget build(BuildContext context) {
    checkfirstsync();
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            //spreadRadius: 1,
            //blurRadius: 1,
          ),
        ],
      ),

      child: BottomNavigationBar(
        key: key,
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              //padding: const EdgeInsets.all(7),
              child:Icon(
                Icons.home,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              //padding: const EdgeInsets.all(7),
              child:Icon(
                Icons.people,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              //padding: const EdgeInsets.all(7),
              child:Icon(
                Icons.person,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              //padding: const EdgeInsets.all(7),
              child:Icon(
                Icons.notifications,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              //padding: const EdgeInsets.all(7),
              child:Icon(
                Icons.dehaze_outlined,
              ),
            ),
            label: '',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor:  Color(0xFFCC9B00),
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}