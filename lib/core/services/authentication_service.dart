import 'dart:io';

import 'package:blog_app/core/viewmodels/user_model.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  File? _image;
  File? get image => _image;

  Future upload_profile_pic() async {
    final pickedFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(
        pickedFile.path,
      );
    }

    final ref =
        FirebaseStorage.instance.ref().child('${DateTime.now()}user_image');

    await ref.putFile(image).onComplete;
    String imgurl = await ref.getDownloadURL();
    return imgurl;
  }

  Future<void> signup(UserModel user, context) async {
    await auth
        .createUserWithEmailAndPassword(
            email: user.username, password: user.password)
        .then((value) {
      // ignore: avoid_print
      print("User Created");
      Firestore.instance
          .collection("users")
          .document(value.user.uid)
          .setData(user.toMap())
          .then((d) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (d) => HomeScreen()),
              (route) => false));
    });
  }

  Future login(username, password, context) async {
    await auth
        .signInWithEmailAndPassword(email: username, password: password)
        .then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (d) => HomeScreen()), (route) => false);
    });
  }
}
