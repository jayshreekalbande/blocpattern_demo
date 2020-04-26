import 'package:equatable/equatable.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
abstract class UserState extends Equatable{}

class UserInitialState extends UserState{
 
  @override
  List<Object> get props => null;
}

class UserLoadingState extends UserState{
 
  @override
 List<Object> get props => [];
}

class UserLoadedState extends UserState{

   List<UserData> data;

  UserLoadedState({@required this.data});

  @override
  List<Object> get props => [data];
}

class UserErrorState extends UserState{

String message;
UserErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}
