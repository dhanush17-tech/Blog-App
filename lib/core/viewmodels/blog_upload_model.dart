import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  BlogModel(
      {required this.title,
      required this.author,
      required this.likes,
      required this.wow,
      required this.thumbnail,
      required this.content,
      required this.uid,
      required this.profileimage,
      required this.category,
      required this.date});

  factory BlogModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data;

    return BlogModel(
        title: data['title'] as String,
        author: data['author'] as String,
        content: data['content'] as String,
        thumbnail: data['thumbnail'] as String,
        category: data["category"] as String,
        profileimage: data['profileimage'] as String,
        uid: data["uid"] as String,
        wow: data["wow"] as int,
        likes: data["likes"] as int,
        date: data["date"] as DateTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'date': date,
      "uid": uid,
      'thumbnail': thumbnail,
      'category': category,
      "profileimage": profileimage,
      "content": content,
      "wow": wow,
      "likes": likes
    };
  }

  final String title;
  late final String author;
  final DateTime date;
  String uid;
  String category;
  int wow;
  int likes;
  String thumbnail;
  String content;
  String profileimage;

// Map<String, dynamic> toMap() {
//   return {
//     'title': title,
//     'author': author,
//     'thumbnail': thumbnail,
//     'link': link,
//   };
// }
}
