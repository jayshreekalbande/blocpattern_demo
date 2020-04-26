
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocpatterntest/bloc/profile/profile_bloc.dart';
import 'package:blocpatterntest/bloc/profile/profile_event.dart';
import 'package:blocpatterntest/bloc/profile/profile_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:blocpatterntest/follower.dart';

class UserDetailsPage extends StatefulWidget {
   final String profileUrl;
  static const String route = '/follower';

  const UserDetailsPage({Key key, this.profileUrl, String followerUrl, String followingUrl}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState(profileUrl);
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  ProfileBloc profileBloc;
   String profileUrl;
  _UserDetailsPageState(this.profileUrl);
  
  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent(profileUrl));
  }

@override
  Widget build(BuildContext context) {
    return  Scaffold(
               appBar: AppBar(
        title: Text("Profile"),
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
             body:  SafeArea(
             child: Container(
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileInitialState) {
                          return buildLoading();
                        } else if (state is ProfileLoadingState) {
                          return buildLoading();
                        } else if (state is ProfileLoadedState) {
                          return buildProfileList(state.data,context);
                        } else if (state is ProfileErrorState) {
                          return buildErrorUi(state.message);
                        }
                        return Container();
                      },
                    ),
                  ),
              ),
              );
           
          
  } 
}
Widget userDetailTile(String _title, String _subtitle) {
  return ListTile(
    dense: true,
    title: Text(_title),
    subtitle: Text(_subtitle),
  );
}
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }


Widget buildProfileList(UserData data,BuildContext context) {
  return Padding(
           padding: const EdgeInsets.all(8.0),
           //onPressed: () {print("You've tapped me!");},
           
          child: InkWell(
       onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Follower(
              followerUrl:data.followerUrl,
              followingUrl:data.followerUrl,
            ),
            
          ),
        );
        print("You've tapped me!");
        },
      child: Card(
        color: Colors.blueGrey.shade50,
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            ClipOval(
              child: Image.network(
               data.avatarUrl,
                fit: BoxFit.fill,
                height: 130.0,
                width: 130.0,
              ),
              
            ),
           Text(
              data.fullName,
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Alatsi'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on),
                Text(
                  data.location,
                ),
              ],
            ),
           Padding(
    padding: const EdgeInsets.all(12.0),
    
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[
        Text(
          'Followers '+data.followerCount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "|",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          'Following  '+data.followingCount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ),
    
  ),
 
  Container(
    color: Colors.white,
    
    child: Column(
      children: <Widget>[
        userDetailTile("Bio:", data.name),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Public Repository:", data.publicRepos.toString()),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Public Gists:", data.publicGists.toString()),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Updated At:", data.updatedAt)
      ],
      
    ),
  ),
  
          ],
        ),
        
      ),
      
      
    ),
    
  );
  
}
 





