import 'package:blocpatterntest/bloc/followers/followers_bloc.dart';
import 'package:blocpatterntest/bloc/followers/followers_event.dart';
import 'package:blocpatterntest/bloc/followers/followers_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FollowersPage extends StatefulWidget {
   final String followerUrl, followingUrl;
  static const String route = '/followers';

  const FollowersPage({Key key, this.followerUrl, this.followingUrl}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState(followerUrl,followingUrl);
}

class _FollowersPageState extends State<FollowersPage> {
  FollowersBloc followerBloc;
   String followerUrl, followingUrl;

  _FollowersPageState(this.followerUrl,this.followingUrl);
  
  @override
  void initState() {
    super.initState();
    followerBloc = BlocProvider.of<FollowersBloc>(context);
    followerBloc.add(FetchFollowersEvent(followerUrl));
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:BorderSide(
                  color:Colors.purple,
                 width: 1,
                ),
              ),
            ),
            height: 60.0,
            child: Row(
              children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    followerBloc.add(FetchFollowersEvent(followerUrl));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Follower',
                      style: TextStyle(
                        fontWeight:FontWeight.bold,
                      ),),
                    ),
                  ),),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    followerBloc.add(FetchFollowersEvent(followingUrl));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Following',
                       style: TextStyle(
                        fontWeight:FontWeight.bold,
                      )),
                    ),
                  ),),
              )
            ],),
          ),
          Container(
                        child: BlocBuilder<FollowersBloc, FollowersState>(
                          builder: (context, state) {
                            if (state is FollowersInitialState) {
                              return buildLoading();
                            } else if (state is FollowersLoadingState) {
                              return buildLoading();
                            } else if (state is FollowersLoadedState) {
                              return buildFollowersList(state.data);
                            } else if (state is FollowersErrorState) {
                              return buildErrorUi(state.message);
                            }
                            return Container();
                          },
                        ),
                      ),
        ],
      ),
              );
           
          
  } 
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


Widget buildFollowersList(List<UserData> data) {
  return Expanded(
          child: SizedBox(
            height: 200.0,
            child:ListView.separated(
    separatorBuilder: (BuildContext context, int index) => Divider(
      height: 1,
    ),
    itemCount: data.length,
    itemBuilder: (BuildContext context, int pos) {
      return Padding(
        padding: EdgeInsets.all(0.0),
        child: InkWell(
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 50.0,
              child: ClipOval(
                child: Image.network(
                  data[pos].avatarUrl,
                  fit: BoxFit.fill,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.0,
            ),
            title: Text(
              data[pos].name,
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Alatsi'),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Name:' + data[pos].name),
                Spacer(),
                Text("Id:" + data[pos].id.toString()),
                Spacer()
              ],
            ),
          ),
         
        ),
      );
    },
  ),
          )
  );
  
}