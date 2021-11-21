import 'package:firebase_messaging/firebase_messaging.dart';


class UserModel {
  UserModel(
      {required this.username,
      required this.name,
      required this.password,
      required this.searchkey,
      required this.age,
        required this.fcm_token,
      required this.profile_pic,
      required this.posts});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
        username: data['title'] as String,
        fcm_token:data["fcm_token"] as String ,
        searchkey: data["searchkey"] as List,
        name: data['author'] as String,
        password: data['password'] as String,
        age: data['thumbnail'] as String,
        profile_pic: data["profile_pic"] as String,
        posts: data['posts'] as List);
  }

  Map<String, dynamic> toMap() {
    List<String> spiltList = name.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < spiltList.length; i++) {
      for (int j = 0; j < spiltList[i].length + i; j++) {
        indexList.add(spiltList[i].substring(0, j).toLowerCase());
      }
    }


    return <String, dynamic>{
      'username': username,
      'name': name,
      'age': age,
      "fcm_token":fcm_token,
      "profile_pic": profile_pic,
      'password': password,
      "searchkey": indexList,
    };
  }

  final String username;
  final String name;
   String fcm_token;
  final String age;
  final String password;
  final String profile_pic;
  final List posts;
  List searchkey;
}
