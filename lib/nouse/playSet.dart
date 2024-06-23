import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/nouse/playCATqq.dart';
import 'createquizCAT.dart';

class PlaysetMY extends StatefulWidget {
  final String myemail, mypassword, cat;
  const PlaysetMY(
      {super.key,
      required this.myemail,
      required this.mypassword,
      required this.cat});

  @override
  State<PlaysetMY> createState() => _PlaysetMYState();
}

class _PlaysetMYState extends State<PlaysetMY> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  Widget foradminfloating() {
    if (widget.myemail == "gh@gmail.com" && widget.mypassword == "123456") {
      return FloatingActionButton(
        backgroundColor: Colors.grey[900],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCATQuiz(
                        cat: widget.cat,
                      )));
          print("${currentuser.email}");
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[400],
        ),
      );
    }
    return SizedBox();
  }

  bool adminORnot() {
    if (widget.myemail == "gh@gmail.com" && widget.mypassword == "123456") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.cat}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.grey[850],
        iconTheme: const IconThemeData(color: Colors.white),
        //automaticallyImplyLeading:  false, //this is for disabling the back button on appbar
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection(widget.cat).snapshots(),
              builder: (context, snapshot) {
                List<GestureDetector> quizD = [];
                if (snapshot.hasData) {
                  final quizdata = snapshot.data?.docs.reversed.toList();
                  for (var q in quizdata!) {
                    final quizrow = GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PlayCAT(
                                    quizId: q["quizId"],
                                    myemail: widget.myemail,
                                    mypassword: widget.mypassword,
                                    cat: widget.cat))));
                      },
                      child: Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              height: 160,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      q["quizImg"],
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  ///=======================delete
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: adminORnot()
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "${q["quizTitle"]}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "-${q["quizDesc"]}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                      adminORnot()
                                                          ?
                                                          // GestureDetector(
                                                          //     onTap: () {
                                                          //       FirebaseFirestore
                                                          //           .instance
                                                          //           .collection(
                                                          //               widget
                                                          //                   .cat)
                                                          //           .doc(q[
                                                          //               "quizId"])
                                                          //           .delete();
                                                          //     },
                                                          //     child: Icon(
                                                          //       Icons.delete,
                                                          //       color: Colors
                                                          //           .white,
                                                          //       size: 25,
                                                          //     ),
                                                          //   )
                                                          GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          "Confirmation"),
                                                                      content: Text(
                                                                          "Are you sure you want to delete this quiz?"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Close the dialog
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text("Cancel"),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Perform the deletion action here
                                                                            FirebaseFirestore.instance.collection(widget.cat).doc(q["quizId"]).delete();

                                                                            // Close the dialog
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text("Delete"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Text(
                                                        "${q["quizTitle"]}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "-${q["quizDesc"]}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    );
                    quizD.add(quizrow);
                  }
                }
                return Expanded(
                  child: ListView(
                    children: quizD,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: foradminfloating(),
    );
  }
}
