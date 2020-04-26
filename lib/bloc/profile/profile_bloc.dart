import 'package:bloc/bloc.dart';
import 'package:blocpatterntest/bloc/profile/profile_event.dart';
import 'package:blocpatterntest/bloc/profile/profile_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:blocpatterntest/data/repositories/profileData_repository.dart';
// import 'package:meta/meta.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileDataRepository repository;
   ProfileBloc({this.repository});
   
  @override
ProfileState get initialState => ProfileInitialState();

  @override
Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if(event is FetchProfileEvent){
      yield ProfileLoadingState();
      try{
          UserData data =await repository.getProfileData(event.profileUrl);
    yield ProfileLoadedState(data:data);

      }catch(e){
        yield ProfileErrorState(message: e.toString());
      }
     
    }
}
}