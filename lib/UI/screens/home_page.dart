
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_bloc.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_event.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_state.dart';
import 'package:blocpatterntest/data/models/userData.dart';

import 'package:blocpatterntest/profile.dart';


class HomePage extends StatefulWidget {
 static const String route = "/profile";
 @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc userBloc; //create Instance of bloc
  String searchText;
   var _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              appBar: AppBar(
                title: Text(
                  "GitHub User",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0, fontFamily: "Acme"),
                ),
                 centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      height: 48.0,
                      child: searchBar(),
                    ),
                  ),
               ),
              body: SafeArea(
                  
                  child: Container(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserInitialState) {
                          return buildLoading();
                        } else if (state is UserLoadingState) {
                          return buildLoading();
                        } else if (state is UserLoadedState) {
                          return buildUserList(state.data);
                        } else if (state is UserErrorState) {
                          return buildErrorUi(state.message);
                        }
                        return Container();
                      },
                    ),
                  ),
              ),
            );
}


  Widget searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0,top: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          setState(() {
            searchText = text;
            userBloc.add(FetchUserSearchEvent(searchText));
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                    userBloc.add(FetchUserEvent());
                  });
                }),
            hintText: 'Enter a search term'),
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


Widget buildUserList(List<UserData> data) {
  return ListView.separated(
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
                Text('id:' + data[pos].id.toString()),
                Spacer(),
                //Text("Score:" + data[pos].score.toString()),
                Spacer()
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              profileUrl:data[pos].profileUrl,
            ),
            
          ),
        );
              },
        ),
      );
    },
    );
}
 



