import 'dart:async';
import 'dart:io';
import 'package:blog_app/app/router/route_constants.dart';
import 'package:blog_app/constants.dart';
import 'package:blog_app/core/services/authentication_service.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:blog_app/meta/views/signup.dart';
import 'package:blog_app/meta/widgets/bezier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  late String fcm_token;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.getToken().then((token) {
      fcm_token = token;
      print(token);
    });
    _username = TextEditingController();

    _password = TextEditingController();

    _googlesigninKey = GlobalKey<FormState>();
  }

  GlobalKey<FormState> _googlesigninKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .17),
                        Padding(
                            padding: const EdgeInsets.only(top: 0, right: 0),
                            child:
                                // Text('Login',
                                //     style: GoogleFonts.poppins(
                                //         fontSize: 40,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.black87)),
                                Align(
                              alignment: Alignment.bottomLeft,
                              child: GradientText(
                                  text: "Login",
                                  textAlign: TextAlign.start,
                                  colors: [Colors.blue, Colors.lightBlueAccent],
                                  style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87)),
                            )),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 5),
                        //     child: Text('Please login to continue',
                        //         style: GoogleFonts.poppins(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 15,
                        //             color: Color(4288914861))),
                        //   ),
                        // ),
                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Username',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: Colors.blue, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 0,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black12,
                              //     blurRadius: 6.0,
                              //     offset: Offset(0, 2),
                              //   ),
                              // ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter some username ';
                                    }
                                    return null;
                                  },
                                  controller: _username,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.grey.withOpacity(0.25),
                                    filled: true,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.blue,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                  color: Colors.blue, fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 0,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter some password ';
                                  }
                                  return null;
                                },
                                controller: _password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  fillColor: Colors.grey.withOpacity(0.25),
                                  filled: true,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Logging.... ')),
                              );
                              bool check = await Authentication().login(
                                  _username.text, _password.text, context);
                              if (check == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => HomeScreen()));
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blue,
                                      Colors.lightBlueAccent
                                    ])),
                            child: Text('Login',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Logging In...')),
                              );
                              await Authentication().googlelogin(
                                  _googlesigninKey, context, fcm_token);
                            }
                          ,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.blue,
                                        Colors.lightBlueAccent
                                      ])),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                          "assets/images/google.png",
                                        )))),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Login in with Google',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, RouteConstant.SIGNUP);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Signup()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: primarytextColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
