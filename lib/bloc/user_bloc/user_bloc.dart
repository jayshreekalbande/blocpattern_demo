import 'package:bloc/bloc.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_event.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:blocpatterntest/data/repositories/userData_repository.dart';
// import 'package:meta/meta.dart';


class UserBloc extends Bloc<UserEvent, UserState>{
   UserDataRepository repository;
   UserBloc({this.repository});
  @override
UserState get initialState => UserInitialState();

  @override
Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is FetchUserEvent){
      yield UserLoadingState();
      try{
         List<UserData> data =await repository.getUserData();
    yield UserLoadedState(data:data);

      }catch(e){
        yield UserErrorState(message: e.toString());
      }
     
    }else if (event is FetchUserSearchEvent){
      yield UserLoadingState();
      try{
        List<UserData> data = await repository.getAllSearchedUsers(event.name.toString());
        yield UserLoadedState(data:data);
      }catch(e){
        yield UserErrorState(message: e.toString());
      }
    }
}
}