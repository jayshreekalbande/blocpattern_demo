import 'package:equatable/equatable.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
abstract class FollowersState extends Equatable{}

class FollowersInitialState extends FollowersState{
 
  @override
  List<Object> get props => null;
}

class FollowersLoadingState extends FollowersState{
 
  @override
 List<Object> get props => [];
}

class FollowersLoadedState extends FollowersState{

  List<UserData> data;

  FollowersLoadedState({@required this.data});

  @override
  List<Object> get props => [data];
}

// class FollowingLoadedState extends FollowersState{

//  Lsit<UserData> data;

//   FollowingLoadedState({@required this.data});

//   @override
//   List<Object> get props => [data];
// }


class FollowersErrorState extends FollowersState{

String message;
FollowersErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}
