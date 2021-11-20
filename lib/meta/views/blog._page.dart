import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class BlogPage extends StatefulWidget {
  String documentId;
  BlogPage(this.documentId);
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("blogs")
                .document(widget.documentId)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              return snapshot.data==null?Container(): Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        data!["title"],
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(data["thumbnail"]),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Flexible(
                    flex: 3,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "${data["content"]}",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "good",
                                  color: secondarytextColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
