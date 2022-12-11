import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triumph_life_ui/newappcode/Api/deletePost_api.dart';
import 'package:triumph_life_ui/newappcode/Api/like_comment_api.dart';
import 'package:triumph_life_ui/newappcode/Api/viewProfilePic_api.dart';
import 'package:triumph_life_ui/newappcode/Data/postData.dart';
import 'package:triumph_life_ui/newappcode/Data/profilePicData.dart';
import 'package:triumph_life_ui/newappcode/Start/login.dart';
import 'package:triumph_life_ui/newappcode/screens/homeScreen.dart';
import 'package:triumph_life_ui/newappcode/widgets/profile_avator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostContainer extends StatelessWidget {
  final postData post;
  PostContainer({Key key,  this.post}) : super(key: key);
  int id;
  @override
  void initState(){
    setState(){};
    initialGetsavedData();
  }
  //final  body={'showprofile':'show',"user_id":'${post.user_id}'};
  void initialGetsavedData() async{
    final SharedPreferences user=await SharedPreferences.getInstance();
    id=user.getInt('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PostHeader(post: post),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8),),
            post.type =='Text'?Text(post.post_content):
            post.type =='Image'?Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: CachedNetworkImage(imageUrl: post.path.toString()+post.post_content.toString()),):
            post.type =='Cover-Pic'?Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: CachedNetworkImage(imageUrl: post.path.toString()+post.post_content.toString()),):
            post.type =='Image-Text'?Column(
                children:[Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(post.post_content,textAlign: TextAlign.left,),
                ],),SizedBox(height: 4,),Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: CachedNetworkImage(imageUrl: post.path.toString()+post.post_content2.toString()))]):Text('Error'),
            //post.imageUrl != 'null' ? const SizedBox.shrink() : const SizedBox(height: 6.0),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8),),
          ],
        ),
      ),
    //post.path != 'null'? Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: CachedNetworkImage(imageUrl: '$post.path+$post.post_content'),): const SizedBox.shrink(),
    Padding(padding: const EdgeInsets.symmetric(vertical: 0), child: _PostStats(post: post,active_id:'${id}'),),
    ],
    ),
    );

  }
}

class _PostStats extends StatefulWidget {
   postData post;
  final like_commentData;
  final String active_id;
  _PostStats({Key  key, this.post,this.like_commentData, this.active_id}) : super(key: key);

  @override
  State<_PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {

  String load='',like='',load1='',cmt='';
  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController abc=new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write a comment'),
            content: TextField(
              onChanged: (value) {

              },
              controller: abc,
              decoration: InputDecoration(hintText: "Type here"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Color(0xffCC9B00),
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  final body={'cmt':'${abc.text}','id':'${widget.active_id}','post_id':'${widget.post.post_id}' };
                  ApiService_like_comment.cmt(body).then((value) {
                    setState((){
                      load1=value.post_coment.toString();
                      cmt='null';
                    });
                  });
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  void share() async {
    final box = context.findRenderObject() as RenderBox;

    // subject is optional but it will be used
    // only when sharing content over email
    await Share.share("Share by",
        subject: "Triumph of Life",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 50,),
            Expanded(child:
            Text(
              like=='null'?  '${load} Likes':load==''?'${widget.post.likes_count} Likes':'0 Like',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
            ),
            ),
            Expanded(child:
            Text(
              cmt=='null'?  '${load1} Comments':load1==''?'${widget.post.comment_count} Comments':'0 Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            ),
            Expanded(child:
            Text(
              '0 Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            ),
          ],
        ),
        const Divider(color: Color(0xffC4C4C4), thickness: 1,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
                  child: MaterialButton(
                    onPressed:()async{
                      final body={'likepost':'likepost','id':'${widget.active_id}','post_id':'${widget.post.post_id}' };
                      ApiService_like_comment.like(body).then((value){
                        setState((){
                          load=value.post_likes.toString();
                          like='null';
                        });
                      });
                    },
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Color(0xffCC9B00),
                        size: 20.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Like'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 3,),
            Material(
                  child: MaterialButton(
                    onPressed: (){
                      _displayTextInputDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 25.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            color: Color(0xffCC9B00),
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text('Comment'),
                        ],
                      ),
                    ),
                  ),
                ),
            SizedBox(width: 3,),
            Material(
                  child: InkWell(
                    onTap: share,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 25.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.screen_share_outlined,
                            color: Color(0xffCC9B00),
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text('Share'),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
        const Divider(color: Color(0xffC4C4C4), thickness: 1,),
      ],
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;
  const _PostButton({Key  key,  this.icon,  this.label,  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {

  final postData post;
  _PostHeader({Key  key,  this.post}) : super(key: key);
  int  abc=0;
  final double profileheight=114;
  @override
  void initState(){
    setState(){};
    initialGetsavedData();
  }
  void initialGetsavedData() async{
    final SharedPreferences user=await SharedPreferences.getInstance();
     abc=user.getInt('userId');
  }

  @override
  Widget build(BuildContext context) {
    final  body={'showprofile':'show',"user_id":'${post.user_id}'};
    return Container(
      child: Row(
        children: [
          //ProfileAvatar(imageUrl: post.user.imageUrl, key: null,),
          FutureBuilder <profilePicData>(
            future: ApiServices.viewProfilePic(body),
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                profilePicData  data = snapshot.data;
                return CircleAvatar(
                  radius: profileheight/5,
                  //backgroundImage: AssetImage('assets/images.jpg'),
                  child:CachedNetworkImage(
                    imageUrl: data .path.toString()+data.Profile_pic.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      width: profileheight,
                      height: profileheight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: profileheight/5,
                      backgroundImage: AssetImage('assets/images.jpg'),
                    ),
                  ),
                );
              }
              return CircleAvatar(
                radius: profileheight/5,
                backgroundImage: AssetImage('assets/images.jpg'),
              );
            },
          ),
        //CircleAvatar(radius: 18, backgroundImage: AssetImage('assets/images.jpg'), key: null,),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post.user_name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '12 min • ',
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
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
               {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: ((context) {
                      return SimpleDialog(
                        children: <Widget>[
                          SimpleDialogOption(
                            child: Text('Delete post'),
                            onPressed: () async{
                              final SharedPreferences user=await SharedPreferences.getInstance();
                              abc=user.getInt('userId');
                              if(abc==int.parse('${post.user_id}')){
                                final body={'post_id':'${post.post_id}','user_id':'${post.user_id}'};
                                ApiService_deletePost.deletePost(body);
                                setState(){};
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
                              }
                              else {
                                showDialog(
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('You cannot be able to delete this post'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      )
                                    ],
                                  ),
                                  context: context,
                                );
                              }
                              },
                          ),
                          SimpleDialogOption(
                            child: Text('Edit post'),
                            onPressed: () {},
                          ),
                          SimpleDialogOption(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    }));
              }
            },
          ),
        ],
      ),
    );
  }

}
