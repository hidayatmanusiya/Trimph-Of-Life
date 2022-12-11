import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import '../Api/friends_api.dart';
import '../Models/request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RequestContainer extends StatelessWidget {
  final friendss request;
  const RequestContainer({Key  key,   this.request}) : super(key: key);

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
                _RequestHeader(request: request),
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

class _RequestHeader extends StatelessWidget {
  final friendss request;
  _RequestHeader({Key  key,   this.request, this.id}) : super(key: key);
  final double profileheight = 100;
  int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //ProfileAvatar(imageUrl: request.user.imageUrl, key: null,),
          CircleAvatar(
            radius: profileheight / 4,
            //backgroundImage: AssetImage('assets/images.jpg'),
            child: CachedNetworkImage(
              imageUrl: request.path.toString() +
                  request.pic.toString(),
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
                  '${request.name}',
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
                onTap: () async {
                  final SharedPreferences user = await SharedPreferences.getInstance();
                  id = user.getInt('userId');
                  final body = {'accept': 'accept', "user_id": '${id}',"friend_id":'${request.user_id}'};
                  ApiServicee_friends.get_friends(body);
                },
                child: Container(
                  height: 20,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffCC9B00),
                  ),
                  child: Text(' Accept',style: TextStyle(color: Colors.white,fontSize: 12),),
                ),
              ),
              InkWell(
                onTap: () async {
                  final SharedPreferences user = await SharedPreferences.getInstance();
                  id = user.getInt('userId');
                  final body = {'reject': 'reject', "user_id": '${id}',"friend_id":'${request.user_id}'};
                  ApiServicee_friends.get_friends(body);
                },
                child:Text('Ignore',style: TextStyle(color: Colors.black.withOpacity(0.4)),),
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

