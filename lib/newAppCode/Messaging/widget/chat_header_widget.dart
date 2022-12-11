import 'package:cached_network_image/cached_network_image.dart';
import 'package:triumph_life_ui/newappcode/Data/friendsData.dart';
import 'package:triumph_life_ui/newappcode/Messaging/model/user.dart';
import 'package:triumph_life_ui/newappcode/Messaging/page/chat_page.dart';
import 'package:flutter/material.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<friendss> users;
  final double profileheight = 100;
  const ChatHeaderWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Triumph Of Life',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.search),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: users[index]),
                          ));
                        },
                        child: CircleAvatar(
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
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
  Widget buildProfileImage() => CircleAvatar(
    radius: profileheight / 4,
    backgroundImage: AssetImage('assets/images.jpg'),
    //child:  Image.asset('assets/images.jpg',fit: BoxFit.fill,height: coverheight),key: null,
  );
}
