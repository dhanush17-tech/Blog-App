import 'dart:io';

import 'package:blog_app/core/viewmodels/user_model.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  File? _image;
  File? get image => _image;

  Future upload_profile_pic() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
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

  Future googlelogin(GlobalKey<FormState> _googlesigninKey,
      BuildContext context, fcm_token) async {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("My title"),
    //       content: Text("This is my message."),
    //       actions: [
    //         TextButton(
    //           child: Text("OK"),
    //           onPressed: () {},
    //         ),
    //       ],
    //     );
    //   },
    // );

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController _age = TextEditingController();
    String _imageurl;
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: gSA.accessToken,
        idToken: gSA.idToken,
      );
      AuthResult authResult = await _auth.signInWithCredential(credential);
      if (authResult.additionalUserInfo.isNewUser) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color(4278190106),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                title: Text('Tell us a bit about yourself',
                    style: TextStyle(color: Colors.white)),
                content: StatefulBuilder(
                    builder: (BuildContext ctx, StateSetter setState) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 120,
                      child: Column(
                        children: [
                          Expanded(
                            child: Form(
                              key: _googlesigninKey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: "Your Age ",
                                        hintStyle:
                                            TextStyle(color: Color(4278228470)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(4278228470)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(4278228470)),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(4278228470)),
                                        ),
                                      ),
                                      validator: (val) => val!.length == 0
                                          ? "Please Enter A Valid Text"
                                          : null,
                                      controller: _age,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await authResult.user
                          .delete()
                          .then((value) => print("deleted"));
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_googlesigninKey.currentState!.validate()) {
                        await _auth.currentUser().then((value) {
                          List<String> spiltList = value.displayName.split(" ");
                          List<String> indexList = [];
                          for (int i = 0; i < spiltList.length; i++) {
                            for (int j = 0; j < spiltList[i].length + i; j++) {
                              indexList.add(
                                  spiltList[i].substring(0, j).toLowerCase());
                            }
                          }

                          final user = UserModel(
                              username: value.email,
                              name: value.displayName,
                              password: "",
                              age: _age.text,
                              profile_pic: value.photoUrl,
                              searchkey: indexList,
                              fcm_token: fcm_token,
                              posts: []);
                          Firestore.instance
                              .collection("users")
                              .document(value.uid)
                              .setData(user.toMap())
                              .then((value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                  (route) => false));

                          Navigator.pop(context);
                        });

                        // await gotostart();
                      }
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                ],
              );
            });
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      }
    } catch (e) {
      print(e);
    }
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
