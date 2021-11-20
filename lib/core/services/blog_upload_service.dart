import 'dart:io';

import 'package:blog_app/core/viewmodels/blog_upload_model.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
    final pickedFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(
        pickedFile.path,
      );

      return File(
        pickedFile.path,
      );
    }
  }

  Future uploadBlog(String title, String content, String category,File image,BuildContext context) async {
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
        category:category,
        content: content,
        wow:0,
        likes:0,
        date: DateTime.now(),
        uid: uid,
        thumbnail: thumbnail,
        profileimage: profile_pic);
    Firestore.instance.collection("blogs").add(blog.toMap()).then((value) =>  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const HomeScreen())));
  }
}
