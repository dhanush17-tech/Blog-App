import 'dart:io';

import 'package:blog_app/constants.dart';
import 'package:blog_app/core/services/authentication_service.dart';
import 'package:blog_app/core/services/blog_upload_service.dart';
import 'package:blog_app/core/viewmodels/blog_upload_model.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BlogAdd extends StatefulWidget {
  const BlogAdd({Key? key}) : super(key: key);

  @override
  _BlogAddState createState() => _BlogAddState();
}

class _BlogAddState extends State<BlogAdd> {
  var image;
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  TextEditingController _category = TextEditingController();
  String? _radioValue1;

  @override
  initState() {
    super.initState();
    _title = TextEditingController();
    _content = TextEditingController();
    _category = TextEditingController();
    _radioValue1 = _radioValue1;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Upload Blog",
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Title of the blog',
                        style: GoogleFonts.poppins(
                            color: secondarytextColor, fontSize: 18),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 0,
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _title,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.25),
                              filled: true,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              // prefixIcon: const Icon(
                              //   Icons.lock_outline,
                              //   color: Colors.blue,
                              // ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Photo of the blog',
                        style: GoogleFonts.poppins(
                            color: secondarytextColor, fontSize: 18),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      image = await BlogUpload().pickFile();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue.withOpacity(0.8),
                      child: image == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Icon(
                                    Icons.upload_file,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 100,
                                  )),
                            )
                          : Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: FileImage(
                                        image,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Content',
                        style: GoogleFonts.poppins(
                            color: secondarytextColor, fontSize: 18),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 200,
                      child: TextField(
                        controller: _content,
                        style: TextStyle(color: Colors.white),
                        maxLines: 10000,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          fillColor: Colors.grey.withOpacity(0.25),
                          filled: true,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          // prefixIcon: const Icon(
                          //   Icons.lock_outline,
                          //   color: Colors.blue,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Category',
                        style: GoogleFonts.poppins(
                            color: secondarytextColor, fontSize: 18),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData.dark(),
                            child: Radio<String>(
                              hoverColor: Colors.pink,
                              value: "Cinema",
                              groupValue: _radioValue1,
                              onChanged: (val) {
                                setState(() {
                                  _radioValue1 = val!;
                                });
                              },
                            ),
                          ),
                          Text('Cinema',
                              style: GoogleFonts.poppins(
                                  color: Color(4278228470),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData.dark(),
                              child: Radio<String>(
                                value: "Sports",
                                groupValue: _radioValue1,
                                onChanged: (val) {
                                  setState(() {
                                    _radioValue1 = val!;
                                    print(_radioValue1);
                                  });
                                },
                              ),
                            ),
                            Text('Sports',
                                style: GoogleFonts.poppins(
                                    color: Color(4278228470),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          ]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {

                      BlogUpload().uploadBlog(_title.text, _content.text,
                          _radioValue1!, image, context);


                      showDialog(
                          context: context,
                          builder: (sf) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 0, left: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Dialog(
                                  insetAnimationCurve: Curves.easeIn,
                                  insetAnimationDuration: Duration(seconds: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(4278857608),
                                            Color(4278256230)
                                          ],
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Container(
                                        height: 150,
                                        child: Lottie.asset(
                                          "assets/images/done.json",
                                          repeat: false,
                                        )),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.blue, Colors.lightBlueAccent])),
                      child: Text('Add Blog',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
