import 'dart:convert';
import 'dart:ui';
import 'package:auto_animated/auto_animated.dart';
import 'package:blog_app/meta/views/blog._page.dart';
import 'package:blog_app/meta/views/blog_add.dart';
import 'package:blog_app/meta/views/profile.dart';
import 'package:blog_app/meta/views/user_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController? _controller;
  TabController? _tab;

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  notific() {
    _fcm.getToken().then((token) {
      print(token);
    });
    _fcm.subscribeToTopic('new_blog');
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print(json.encode(message));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => BlogPage(json.encode(message)))); // TODO optional
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      // TODO optional
    });
  }

  @override
  initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _controller = PageController(initialPage: 0);
    notific();
  }

  

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              stretch: false,
              expandedHeight: 70,
              pinned: false,
              bottom: TabBar(controller: _tab, tabs: const [
                Tab(
                    icon: Text(
                  "All",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                )),
                Tab(
                    icon: Text(
                  "Sports",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                )),
                Tab(
                    icon: Text(
                  "Cinema",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ))
              ]),
              backgroundColor: backgroundColor,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => UserSearch()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 0.0,
                          right: 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: const Color(0xFF5894FA)),
                              color: const Color(0xFF5894FA).withOpacity(0.4)),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 110,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Hero(
                                    tag: "mannn",
                                    child: Icon(Icons.search,
                                        size: 25, color: Color(0xFF5894FA)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Material(
                                        color: Colors.transparent,
                                        child: Text("Search ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: const Color(
                                                4278228470,
                                              ),
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const BlogAdd()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, right: 0),
                          child: Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.indigo,
                              ),
                              child: Icon(Icons.add, color: Colors.white)),
                        ),
                      ),
                    ),
                  ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15.0, right: 15),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             _controller!.animateToPage(0,
                  //                 duration: const Duration(milliseconds: 500),
                  //                 curve: Curves.easeIn);
                  //           },
                  //           child: Container(
                  //               width: 100,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.blue.withOpacity(0.8),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: const Align(
                  //                 alignment: Alignment.center,
                  //                 child: Text("All",
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontFamily: "good",
                  //                         fontSize: 26)),
                  //               )),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             _controller!.animateToPage(1,
                  //                 duration: const Duration(milliseconds: 500),
                  //                 curve: Curves.easeIn);
                  //           },
                  //           child: Container(
                  //               width: 100,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.blue.withOpacity(0.8),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: const Align(
                  //                 alignment: Alignment.center,
                  //                 child: Text("Sports",
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontFamily: "good",
                  //                         fontSize: 26)),
                  //               )),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             _controller!.animateToPage(2,
                  //                 duration: const Duration(milliseconds: 500),
                  //                 curve: Curves.easeIn);
                  //           },
                  //           child: Container(
                  //               width: 100,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.blue.withOpacity(0.8),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: const Align(
                  //                 alignment: Alignment.center,
                  //                 child: Text("Movies",
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontFamily: "good",
                  //                         fontSize: 26)),
                  //               )),
                  //         ),
                  //       ]),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 155,
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tab,
                        children: [
                          _allBlog(),
                          _sportsBlog(),
                          _cinemaBlog(),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _allBlog() {
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("blogs").snapshots(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.separated(
                      separatorBuilder: (
                        ctx,
                        i,
                      ) =>
                          SizedBox(height: 20),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.documents.length,
                      itemBuilder: (
                        ctx,
                        i,
                      ) {
                        var data = snapshot.data!.documents[i];

                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(1),
                                        Colors.white.withOpacity(1),
                                      ]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(children: [
                                  Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Opacity(
                                      opacity: 0.7, //Overall Background opacity
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF4E82E8).withOpacity(
                                                      0.3), // Card gradients
                                                  Color(0xFF5690F6)
                                                      .withOpacity(0.7)
                                                ],
                                                begin: Alignment
                                                    .topLeft, // Gradient scheme
                                                end: Alignment.bottomRight),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        // child: Opacity(
                                        //   opacity: 0.35,
                                        //   child: ClipRRect(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     child: ImageFiltered(
                                        //         imageFilter:
                                        //             ImageFilter.blur(
                                        //                 sigmaX: 1,
                                        //                 sigmaY: 1),
                                        //         child: Container(
                                        //           decoration:
                                        //               BoxDecoration(
                                        //                   color: Colors
                                        //                       .white),
                                        //           child: Opacity(
                                        //             opacity: 1,
                                        //             child: Container(
                                        //                 height: 370,
                                        //                 decoration:
                                        //                     BoxDecoration(
                                        //                   image: DecorationImage(
                                        //                       image: NetworkImage(
                                        //                           "https://thumbs.dreamstime.com/b/assorted-american-food-top-view-109748438.jpg"),
                                        //                       fit: BoxFit
                                        //                           .fill),
                                        //                 )),
                                        //           ),
                                        //         )),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  StreamBuilder(
                                                      builder: (ctx, i) {
                                                    return GestureDetector(
                                                      onTap: () {},
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (c) =>
                                                                              Profile(data["uid"])));
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                  child:
                                                                      Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(data["profileimage"]),
                                                                            fit: BoxFit.fill)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.50,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                              top: 0,
                                                                            ),
                                                                            child: Text(
                                                                              data["title"],
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xFF333640),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      data[
                                                                          "author"],
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Color((0xFF333640)).withOpacity(0.8)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0, right: 8),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            DateFormat('d')
                                                                .format(data[
                                                                        "date"]
                                                                    .toDate())
                                                                .toString(),
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 15,
                                                                height: 1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xFF333640)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          DateFormat('MMM')
                                                              .format(
                                                                  data["date"]
                                                                      .toDate())
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              height: 1,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xFF333640)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: "dssd+$i",
                                                child: Material(
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  ),
                                                  elevation: 20,
                                                  child: Container(
                                                    height: 220,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                data[
                                                                    "thumbnail"]),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () async {
                                                        Firestore.instance
                                                            .collection("blogs")
                                                            .document(
                                                                data.documentID)
                                                            .updateData({
                                                          "likes": FieldValue
                                                              .increment(1)
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/heart.png",
                                                        color:
                                                            Color(4290118716),
                                                        scale: 10,
                                                      )),
                                                  Text(
                                                    "${data["likes"]}",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(0xFF333640)
                                                            .withOpacity(1)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Firestore.instance
                                                        .collection("blogs")
                                                        .document(
                                                            data.documentID)
                                                        .updateData({
                                                      "wow":
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/wow.png",
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${data["wow"]}",
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                    0xFF333640)
                                                                .withOpacity(
                                                                    1)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  BlogPage(data
                                                                      .documentID)));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Color(
                                                                    0xFF1438D0),
                                                                Colors.blue
                                                              ])),
                                                      child: Text(
                                                        "Learn More",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontFamily: "good",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ])),
                          ),
                        );
                      });
            }));
  }

  Widget _cinemaBlog() {
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("blogs")
                .where("category", isEqualTo: "Cinema")
                .snapshots(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.separated(
                      separatorBuilder: (
                        ctx,
                        i,
                      ) =>
                          SizedBox(height: 20),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.documents.length,
                      itemBuilder: (
                        ctx,
                        i,
                      ) {
                        var data = snapshot.data!.documents[i];

                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(1),
                                        Colors.white.withOpacity(1),
                                      ]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(children: [
                                  Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Opacity(
                                      opacity: 0.7, //Overall Background opacity
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF4E82E8).withOpacity(
                                                      0.3), // Card gradients
                                                  Color(0xFF5690F6)
                                                      .withOpacity(0.7)
                                                ],
                                                begin: Alignment
                                                    .topLeft, // Gradient scheme
                                                end: Alignment.bottomRight),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        // child: Opacity(
                                        //   opacity: 0.35,
                                        //   child: ClipRRect(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     child: ImageFiltered(
                                        //         imageFilter:
                                        //             ImageFilter.blur(
                                        //                 sigmaX: 1,
                                        //                 sigmaY: 1),
                                        //         child: Container(
                                        //           decoration:
                                        //               BoxDecoration(
                                        //                   color: Colors
                                        //                       .white),
                                        //           child: Opacity(
                                        //             opacity: 1,
                                        //             child: Container(
                                        //                 height: 370,
                                        //                 decoration:
                                        //                     BoxDecoration(
                                        //                   image: DecorationImage(
                                        //                       image: NetworkImage(
                                        //                           "https://thumbs.dreamstime.com/b/assorted-american-food-top-view-109748438.jpg"),
                                        //                       fit: BoxFit
                                        //                           .fill),
                                        //                 )),
                                        //           ),
                                        //         )),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  StreamBuilder(
                                                      builder: (ctx, i) {
                                                    return GestureDetector(
                                                      onTap: () {},
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (c) =>
                                                                              Profile(data["uid"])));
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                  child:
                                                                      Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(data["profileimage"]),
                                                                            fit: BoxFit.fill)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.50,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                              top: 0,
                                                                            ),
                                                                            child: Text(
                                                                              data["title"],
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xFF333640),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      data[
                                                                          "author"],
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Color((0xFF333640)).withOpacity(0.8)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0, right: 8),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            DateFormat('d')
                                                                .format(data[
                                                                        "date"]
                                                                    .toDate())
                                                                .toString(),
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 15,
                                                                height: 1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xFF333640)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          DateFormat('MMM')
                                                              .format(
                                                                  data["date"]
                                                                      .toDate())
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              height: 1,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xFF333640)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: "dssd+$i",
                                                child: Material(
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  ),
                                                  elevation: 20,
                                                  child: Container(
                                                    height: 220,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                data[
                                                                    "thumbnail"]),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () async {
                                                        Firestore.instance
                                                            .collection("blogs")
                                                            .document(
                                                                data.documentID)
                                                            .updateData({
                                                          "likes": FieldValue
                                                              .increment(1)
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/heart.png",
                                                        color:
                                                            Color(4290118716),
                                                        scale: 10,
                                                      )),
                                                  Text(
                                                    "${data["likes"]}",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(0xFF333640)
                                                            .withOpacity(1)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Firestore.instance
                                                        .collection("blogs")
                                                        .document(
                                                            data.documentID)
                                                        .updateData({
                                                      "wow":
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/wow.png",
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${data["wow"]}",
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                    0xFF333640)
                                                                .withOpacity(
                                                                    1)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  BlogPage(data
                                                                      .documentID)));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Color(
                                                                    0xFF1438D0),
                                                                Colors.blue
                                                              ])),
                                                      child: Text(
                                                        "Learn More",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontFamily: "good",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ])),
                          ),
                        );
                      });
            }));
  }
}

Widget _sportsBlog() {
  return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("blogs")
              .where("category", isEqualTo: "Sports")
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.separated(
                    separatorBuilder: (
                      ctx,
                      i,
                    ) =>
                        SizedBox(height: 20),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.documents.length,
                    itemBuilder: (
                      ctx,
                      i,
                    ) {
                      var data = snapshot.data!.documents[i];

                      return Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 0),
                          child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(1),
                                      Colors.white.withOpacity(1),
                                    ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(children: [
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Opacity(
                                    opacity: 0.7, //Overall Background opacity
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF4E82E8).withOpacity(
                                                    0.3), // Card gradients
                                                Color(0xFF5690F6)
                                                    .withOpacity(0.7)
                                              ],
                                              begin: Alignment
                                                  .topLeft, // Gradient scheme
                                              end: Alignment.bottomRight),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // child: Opacity(
                                      //   opacity: 0.35,
                                      //   child: ClipRRect(
                                      //     borderRadius:
                                      //         BorderRadius.circular(20),
                                      //     child: ImageFiltered(
                                      //         imageFilter:
                                      //             ImageFilter.blur(
                                      //                 sigmaX: 1,
                                      //                 sigmaY: 1),
                                      //         child: Container(
                                      //           decoration:
                                      //               BoxDecoration(
                                      //                   color: Colors
                                      //                       .white),
                                      //           child: Opacity(
                                      //             opacity: 1,
                                      //             child: Container(
                                      //                 height: 370,
                                      //                 decoration:
                                      //                     BoxDecoration(
                                      //                   image: DecorationImage(
                                      //                       image: NetworkImage(
                                      //                           "https://thumbs.dreamstime.com/b/assorted-american-food-top-view-109748438.jpg"),
                                      //                       fit: BoxFit
                                      //                           .fill),
                                      //                 )),
                                      //           ),
                                      //         )),
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StreamBuilder(
                                                    builder: (ctx, i) {
                                                  return GestureDetector(
                                                    onTap: () {},
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (c) =>
                                                                                Profile(data["uid"])));
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                child:
                                                                    Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(data[
                                                                              "profileimage"]),
                                                                          fit: BoxFit
                                                                              .fill)),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.50,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                            top:
                                                                                0,
                                                                          ),
                                                                          child: Text(
                                                                            data["title"],
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xFF333640),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    data[
                                                                        "author"],
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            13,
                                                                        color: Color((0xFF333640))
                                                                            .withOpacity(0.8)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  );
                                                }),
                                              ],
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, right: 8),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          DateFormat('d')
                                                              .format(
                                                                  data["date"]
                                                                      .toDate())
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              height: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xFF333640)),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        DateFormat('MMM')
                                                            .format(data["date"]
                                                                .toDate())
                                                            .toString(),
                                                        style: GoogleFonts.poppins(
                                                            height: 1,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFF333640)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Stack(
                                          children: [
                                            Hero(
                                              tag: "dssd+$i",
                                              child: Material(
                                                color: Colors.white
                                                    .withOpacity(0.25),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                                elevation: 20,
                                                child: Container(
                                                  height: 220,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                      ),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              data[
                                                                  "thumbnail"]),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, right: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () async {
                                                      Firestore.instance
                                                          .collection("blogs")
                                                          .document(
                                                              data.documentID)
                                                          .updateData({
                                                        "likes": FieldValue
                                                            .increment(1)
                                                      });
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/heart.png",
                                                      color: Color(4290118716),
                                                      scale: 10,
                                                    )),
                                                Text(
                                                  "${data["likes"]}",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF333640)
                                                          .withOpacity(1)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Firestore.instance
                                                      .collection("blogs")
                                                      .document(data.documentID)
                                                      .updateData({
                                                    "wow":
                                                        FieldValue.increment(1)
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/wow.png",
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "${data["wow"]}",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                                  0xFF333640)
                                                              .withOpacity(1)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                BlogPage(data
                                                                    .documentID)));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 100,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color(0xFF1438D0),
                                                              Colors.blue
                                                            ])),
                                                    child: Text(
                                                      "Learn More",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: "good",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ])),
                        ),
                      );
                    });
          }));
}
