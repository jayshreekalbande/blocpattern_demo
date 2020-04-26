import 'package:equatable/equatable.dart';

abstract class FollowersEvent extends Equatable{}

class FetchFollowersEvent extends FollowersEvent{
final String followerUrl;

  FetchFollowersEvent(this.followerUrl);
@override
  // TODO: implement props
  List<Object> get props => [followerUrl];
}

class FetchFollowingEvent extends FollowersEvent{
  
  final String followingUrl;
  FetchFollowingEvent(this.followingUrl);
  
  @override
  List<Object> get props => [followingUrl];
  
}