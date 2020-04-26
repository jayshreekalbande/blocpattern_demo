import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{}

class FetchProfileEvent extends ProfileEvent{
final String profileUrl;

  FetchProfileEvent(this.profileUrl);
@override
  // TODO: implement props
  List<Object> get props => [profileUrl];
}

class FetchProfileSearchEvent extends ProfileEvent{
  
  final String name;
  FetchProfileSearchEvent(this.name);
  
  @override
  List<Object> get props => [name];
  
}