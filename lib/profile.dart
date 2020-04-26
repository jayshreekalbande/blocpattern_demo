import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/screens/user_details.dart';
import 'bloc/profile/profile_bloc.dart';

import 'data/repositories/profileData_repository.dart';

class Profile extends StatelessWidget {
   static const String route = "/profile";
    final String profileUrl;
    const Profile({Key key, this.profileUrl}) : super(key: key);
    
    //final UserData profileUrl;
    // Profile({this.profileUrl});

  @override
  Widget build(BuildContext context) {
  //  final UserData data = ModalRoute.of(context).settings.arguments;
   // String profileUrl = data.profileUrl;
    return Scaffold(
     
      body:BlocProvider(
            create: (context) => ProfileBloc(repository: ProfileRepositoryImpl()),
            child: UserDetailsPage(profileUrl: profileUrl,),
    ),
    );
  }
    
}