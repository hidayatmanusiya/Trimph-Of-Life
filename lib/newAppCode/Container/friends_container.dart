import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import '../Models/Friends_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FriendsContainer extends StatelessWidget {
  final friendss friend;
  const FriendsContainer({Key key,  this.friend}) : super(key: key);

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
                _FriendsHeader(friend: friend),
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

class _FriendsHeader extends StatelessWidget {
  final friendss friend;
  const _FriendsHeader({Key key,  this.friend}) : super(key: key);
  final double profileheight = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //friend.pic=='null'?:ProfileAvatar(imageUrl:'${friend.path}+${friend.pic}' , key: null,),
          CircleAvatar(
            radius: profileheight / 4,
            //backgroundImage: AssetImage('assets/images.jpg'),
            child: CachedNetworkImage(
              imageUrl: friend.path.toString() +
                  friend.pic.toString(),
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
                  '${friend.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Active 12 min ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      ' ago',
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

