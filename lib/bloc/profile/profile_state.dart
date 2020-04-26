import 'package:equatable/equatable.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
abstract class ProfileState extends Equatable{}

class ProfileInitialState extends ProfileState{
 
  @override
  List<Object> get props => null;
}

class ProfileLoadingState extends ProfileState{
 
  @override
 List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState{

   UserData data;

  ProfileLoadedState({@required this.data});

  @override
  List<Object> get props => [data];
}

class ProfileErrorState extends ProfileState{

String message;
ProfileErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}
