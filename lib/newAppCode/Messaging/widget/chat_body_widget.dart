import 'package:cached_network_image/cached_network_image.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/model/user.dart';
import 'package:triumph_life_ui/newappcode/Messaging/page/chat_page.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<friendss> users;
  final double profileheight = 100;
  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
              },
              leading:CircleAvatar(
              radius: profileheight / 4,
              child: CachedNetworkImage(
                imageUrl: users[index].path.toString() +
                    users[index].pic.toString(),
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
              title: Text(user.name),
            ),
          );
        },
        itemCount: users.length,
      );
  Widget buildProfileImage() => CircleAvatar(
    radius: profileheight / 4,
    backgroundImage: AssetImage('assets/images.jpg'),
    //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
  );
}
