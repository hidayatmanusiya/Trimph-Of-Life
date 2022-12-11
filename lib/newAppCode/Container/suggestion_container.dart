import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/friends_api.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import '../Models/suggestion_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SuggestionContainer extends StatelessWidget {
  final friendss suggestion;
  SuggestionContainer({Key key,  this.suggestion}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _suggestionHeader(suggestion: suggestion),
                const SizedBox(height: 4.0),
                const Divider(color: Color(0xffC4C4C4), thickness: 1,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _suggestionHeader extends StatelessWidget {
  final friendss suggestion;
  _suggestionHeader({Key key,  this.suggestion,this.id}) : super(key: key);
  final double profileheight = 100;


  int id;
  @override
  void initState() {
    initialGetsavedData();
  }

  void initialGetsavedData() async {

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //ProfileAvatar(imageUrl: suggestion.user.imageUrl, key: null,),
        CircleAvatar(
        radius: profileheight / 4,
        //backgroundImage: AssetImage('assets/images.jpg'),
        child: CachedNetworkImage(
          imageUrl: suggestion .path.toString() +
              suggestion .pic.toString(),
          imageBuilder:
              (context, imageProvider) =>
              Container(
                width: profileheight,
                height: profileheight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover),
                ),
              ),
          placeholder: (context, url) =>
              CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              buildProfileImage(),
        ),
      ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${suggestion.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '12 mutual friends',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async{
                  final SharedPreferences user = await SharedPreferences.getInstance();
                  id = user.getInt('userId');
                  final body = {'sent': 'sent', "user_id": '${id}',"friend_id":'${suggestion.user_id}'};
                  ApiServicee_friends.get_friends(body);

                },
                child: Container(
                  height: 20,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:Icon(
                  Icons.person_add_alt_1_outlined,
                  color: Colors.blue,
                ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildProfileImage() => CircleAvatar(
    radius: profileheight / 4,
    backgroundImage: AssetImage('assets/images.jpg'),
    //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
  );
}

