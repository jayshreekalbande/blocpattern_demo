import 'package:blocpatterntest/data/models/userData.dart';
import 'package:http/http.dart' as http;
import 'package:blocpatterntest/res/strings.dart';
import 'dart:convert';

abstract class UserDataRepository{
  Future<List<UserData>> getUserData();
   Future<List<UserData>> getAllSearchedUsers(String name);
  

}

class UserRepositoryImpl extends UserDataRepository{

@override
 Future<List<UserData>> getAllSearchedUsers(String name) async {
    List<UserData> userList = new List();
    var response =
        await http.get("https://api.github.com/search/users?q=" + name);

    if (response.statusCode == 200) {
      print(response.body);
      var searchedUser = json.decode(response.body);
      List searchedList = searchedUser["items"];
      for (var obj in searchedList) {
        UserData users = new UserData();
        users.id = obj['id'];
        users.avatarUrl = obj['avatar_url'];
        users.name = obj['login'];
        users.profileUrl = obj['url'];
        userList.add(users);
      }
      return userList;
    } else {
      throw Exception();
    }
  }
    @override
  Future<List<UserData>> getUserData() async {
    List userData;
    List<UserData> userList = new List();
    var response = await http.get(AppString.URL_USERS);
    
    if (response.statusCode == 200) {
     
      userData = json.decode(response.body);
      for (var obj in userData) {
 //   print(obj.toString());
    UserData data  = new UserData();
        data.id = obj['id'];
        data.avatarUrl = obj['avatar_url'];
        data.name = obj['login'];
        data.profileUrl =obj['url'];
        userList.add(data );
      }
      return userList;
    } else {
      throw Exception();
    }
  }

    

}