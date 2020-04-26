import 'package:bloc/bloc.dart';
import 'package:blocpatterntest/bloc/followers/followers_event.dart';
import 'package:blocpatterntest/bloc/followers/followers_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:blocpatterntest/data/repositories/profileData_repository.dart';



class FollowersBloc extends Bloc<FollowersEvent, FollowersState>{
  ProfileDataRepository repository;
   FollowersBloc({this.repository});
   
  @override
FollowersState get initialState => FollowersInitialState();

  @override
Stream<FollowersState> mapEventToState(FollowersEvent event) async* {
    if(event is FetchFollowersEvent){
      yield FollowersLoadingState();
      try{
          List<UserData> data =await repository.getFollowersData(event.followerUrl);
    yield FollowersLoadedState(data:data);

      }catch(e){
        yield FollowersErrorState(message: e.toString());
      }
     
    }
    //else if(event is FetchFollowingEvent){
    //     yield FollowersLoadingState();
    //   try{
    //       List<UserData> data =await repository.getFollowingData(event.followingUrl);
    // yield FollowersLoadedState(data:data);

    //   }catch(e){
    //     yield FollowersErrorState(message: e.toString());
    //   }
    // }
}
}
