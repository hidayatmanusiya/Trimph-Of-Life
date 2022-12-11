import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:triumph_life_ui/newappcode/Messaging/chat_box.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import '../Models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageContainer extends StatelessWidget {
  final Messages message;
  const MessageContainer({Key key,  this.message}) : super(key: key);

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
                _MessageHeader(message: message),
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

class _MessageHeader extends StatelessWidget {
  final Messages message;
  const _MessageHeader({Key key,  this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ProfileAvatar(imageUrl: message.user.imageUrl, key: null,),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${message.user.name}',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${message.upper_mesg} ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => chatBox()));
                        },
                    ),
                    Expanded(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: ()=>print('okay'),
                            child:Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xffCC9B00),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

