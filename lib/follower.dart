import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/screens/followerPage.dart';
import 'bloc/followers/followers_bloc.dart';
import 'data/repositories/profileData_repository.dart';

class Follower extends StatelessWidget {
   static const String route = "/follower";
    final String followerUrl;
 final String followingUrl;
     const Follower({Key key, this.followerUrl, this.followingUrl}) : super(key: key);
   
  

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Followers detail"),
         centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.share,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {})
        ],
      ),
      body:BlocProvider(
            create: (context) => FollowersBloc(repository: ProfileRepositoryImpl()),
            child: FollowersPage(followerUrl:  followerUrl,
            followingUrl: followingUrl),
    ),
    );
  }
    
}