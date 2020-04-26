import 'package:blocpatterntest/data/models/userData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ProfileDataRepository{
  Future<UserData> getProfileData(String profileUrl);
    Future<List<UserData>> getFollowersData(String followerUrl);
 
  }

class ProfileRepositoryImpl extends ProfileDataRepository{
  
   @override
  Future<UserData> getProfileData(profileUrl) async {
    
    var response = await http.get(profileUrl);
      Map<String, dynamic> userData = Map<String, dynamic>();
    if (response.statusCode == 200) {
      //ssprint(json.decode(response.body));
      userData = json.decode(response.body);
      
     
          UserData data  = new UserData();
         String bio = userData['bio'] == null ? "No Bio" : userData['bio'];
                    String location =
                        userData['location'] == null ? "No location" : userData['location'];
                    data.location = location;
                    data.bio = bio;
                    data.name = userData['name'];
                    data.followerCount = userData["followers"];
                    data.followingCount = userData["following"];
                    data.followingUrl = userData['following_url'];
                    data.followerUrl = userData['followers_url'];
                    data.publicRepos = userData['public_repos'];
                    data.publicGists = userData['public_gists'];
                    DateTime date = DateTime.parse(userData["updated_at"]);
                    var year = date.year;
                    var month = date.month;
                    var day = date.day;
                    var hour = date.hour;
                    var min = date.minute;
                    data.updatedAt = hour.toString() +
                        ":" +
                        min.toString() +
                        " on " +
                        day.toString() +
                        "/" +
                        month.toString() +
                        "/" +
                        year.toString();
                    data.fullName = userData["name"];
                  data.avatarUrl = userData['avatar_url'];
        return data;
    } else {
      throw Exception();
    }
  }

 
   @override
  Future<List<UserData>> getFollowersData(String followersUrl) async {
    List userData;
    
    List<UserData> userList = new List();
    var response = await http.get(followersUrl);
     
    if (response.statusCode == 200) {
      userData = json.decode(response.body);
      for (var obj in userData) {
         // print(obj.toString());
          UserData data  = new UserData();
             data.name = obj["login"];
                  data.id = obj['id'];
                  data.avatarUrl= obj['avatar_url'];
                  userList.add(data);
            
      }
      return userList;
    } else {
      throw Exception();
    }
  }
    



} 