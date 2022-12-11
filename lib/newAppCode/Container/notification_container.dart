import 'package:flutter/material.dart';
import '../Data/notificationData.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationContainer extends StatelessWidget {
  final notificationData notifications;
  const NotificationContainer({Key  key,  this.notifications}) : super(key: key);

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
                _NotificationHeader(notifications: notifications),
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

class _NotificationHeader extends StatelessWidget {
  final notificationData notifications;
  const _NotificationHeader({Key  key,  this.notifications}) : super(key: key);
  final double profileheight = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //ProfileAvatar(imageUrl: notifications.user.imageUrl, key: null,),
          CircleAvatar(
            radius: profileheight / 4,
            //backgroundImage: AssetImage('assets/images.jpg'),
            child: CachedNetworkImage(
              imageUrl: notifications.path.toString() +
                  notifications.pic.toString(),
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
                  '${notifications.name}  ${notifications.text}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '12 min ago',
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

