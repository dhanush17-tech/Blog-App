import 'package:blog_app/constants.dart';
import 'package:blog_app/meta/views/blog._page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile(this.uid);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                child: StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection("users")
                        .document(widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      var userData = snapshot.data;
                      return snapshot.data==null?Container(): Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.person,
                                    size: 40, color: Colors.white),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Profile",
                                    style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            userData!["profile_pic"]))),
                              )),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  userData["name"],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: secondarytextColor,
                                      fontSize: 55,
                                      fontFamily: "good"),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${userData["age"]} years old",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: secondarytextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pitches by user",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    letterSpacing: .6,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:"good",
                                    color: primarytextColor),
                              ),
                            ),
                          ),
                          SizedBox(height:20),
                          StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection("blogs")
                                  .where("uid", isEqualTo: widget.uid)
                                  .snapshots(),
                              builder: (context, s) {
                                return s.data==null?Container(): ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (ctx, i) =>
                                        SizedBox(height: 10),
                                    itemCount: s.data!.documents.length,
                                    itemBuilder: (context, index) {
                                      var data = s.data!.documents[index];

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
                                                      Colors.white
                                                          .withOpacity(1),
                                                      Colors.white
                                                          .withOpacity(1),
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Stack(children: [
                                                Material(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Opacity(
                                                    opacity:
                                                        0.7, //Overall Background opacity
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Color(0xFF4E82E8)
                                                                    .withOpacity(
                                                                        0.3), // Card gradients
                                                                Color(0xFF5690F6)
                                                                    .withOpacity(
                                                                        0.7)
                                                              ],
                                                                  begin: Alignment
                                                                      .topLeft, // Gradient scheme
                                                                  end: Alignment
                                                                      .bottomRight),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 0,
                                                                left: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                StreamBuilder(
                                                                    builder:
                                                                        (ctx,
                                                                            i) {
                                                                  return  GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: 5, bottom: 5),
                                                                              child: Container(
                                                                                width: 50,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(data["profileimage"]), fit: BoxFit.fill)),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(bottom: 0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width * 0.50,
                                                                                    child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.horizontal,
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
                                                                                    data["author"],
                                                                                    style: GoogleFonts.poppins(fontSize: 13, color: Color((0xFF333640)).withOpacity(0.8)),
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
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5.0,
                                                                      right: 8),
                                                              child: Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.25),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 5),
                                                                        child:
                                                                            Text(
                                                                          DateFormat('d')
                                                                              .format(data["date"].toDate())
                                                                              .toString(),
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 15,
                                                                              height: 1,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: const Color(0xFF333640)),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            3,
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data["date"].toDate())
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            height:
                                                                                1,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: const Color(0xFF333640)),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Stack(
                                                          children: [
                                                            Hero(
                                                              tag:
                                                                  "dssd+$index",
                                                              child: Material(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.25),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                                elevation: 20,
                                                                child:
                                                                    Container(
                                                                  height: 220,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .only(
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
                                                                              image: NetworkImage(data["thumbnail"]),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3,
                                                                right: 3),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
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
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (_) => BlogPage(data.documentID)));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            30,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8),
                                                                            gradient:
                                                                                LinearGradient(colors: [
                                                                              Color(0xFF1438D0),
                                                                              Colors.blue
                                                                            ])),
                                                                        child:
                                                                            Text(
                                                                          "Learn More",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontFamily:
                                                                                "good",
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.white,
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
                              })
                        ],
                      );
                    }))));
  }
}
