import 'dart:convert';
import 'dart:io';

import 'package:blog_app/core/viewmodels/blog_upload_model.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class BlogUpload {
  BlogModel? _model;

  late String uid;
  late String profile_pic;
  late String author;
  late String thumbnail;

  getUserInfo() async {
    final ins = FirebaseAuth.instance.currentUser();
    await ins.then((FirebaseUser? value) {
      uid = value!.uid;
      print(uid);
    });
    Firestore.instance.collection("users").document(uid).get().then((value) {
      author = value["name"];
      profile_pic = value["profile_pic"];
    });
  }

  Future pickFile() async {
    File image;
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(
        pickedFile.path,
      );

      return File(
        pickedFile.path,
      );
    }
  }

  Future<bool> callOnFcmApiSendPushNotifications(
      List<String> userToken, documentId) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        "sound": "default",
        "status": "done",
        "screen": documentId,
      },
      "registration_ids": userToken,
      "collapse_key": "type_a",
      "notification": {
        "title": 'New Blog 📢',
        "body": 'Someone has got you something new to read',
      },
      // ignore: equal_keys_in_map
      //  "to": "new_blog",
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          "key=AAAAQmeQzEgt:APA91bHOKDG1jNMF-YrK7Ym58_mAENBJ-Z5p6_rNwcWNodxaH5BUntSci7WvD1YUMTSSYVhbzsldsuYLtyn4IRklzQT3gzZexFQdT1Jm8PyfZen1oBq53cyJolKGYJ5cJdzuoAvUcB4C" // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print("Done");
      return true;
    } else {
      print(response.body);
      // on failure do sth
      return false;
    }
  }

  Future uploadBlog(String title, String content, String category, File image,
      BuildContext context) async {
    await getUserInfo();
    final ref =
        FirebaseStorage.instance.ref().child('${DateTime.now()}user_image');

    await ref.putFile(image).onComplete;
    thumbnail = await ref.getDownloadURL();
    // print(_model!.author);
    // print(_model!.tauthumbnail);
    // print(_model!.uid);
    print(content);
    // print(title);
    // print(_model!.profileimage);

    final blog = BlogModel(
        title: title,
        author: author,
        category: category,
        content: content,
        wow: 0,
        likes: 0,
        date: DateTime.now(),
        uid: uid,
        thumbnail: thumbnail,
        profileimage: profile_pic);

    Firestore.instance.collection("blogs").add(blog.toMap()).then((value) {
      sendNotificationToAll(value.documentID);
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => const HomeScreen()));
    });
  }

  Future sendNotificationToAll(documentId) async {
    Firestore.instance.collection('users').getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) async {
        callOnFcmApiSendPushNotifications([doc.data["fcm_token"]], documentId);
      });
    });
  }
}
