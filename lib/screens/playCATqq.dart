import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/services/database.dart';
import 'package:login_ui_quiz/screens/resultCAT.dart';

class PlayCAT extends StatefulWidget {
  final String quizId;
  final String myemail, mypassword, cat;
  const PlayCAT(
      {required this.quizId,
      required this.myemail,
      required this.mypassword,
      required this.cat});

  @override
  State<PlayCAT> createState() => _PlayCATState();
}

class _PlayCATState extends State<PlayCAT> {
  bool show = false, show1 = false, show2 = false, show3 = false, show4 = false;
  bool gestureonoff = true;
  int count = 0;
  int correctanswer = 0, incorrectanswer = 0, notattempted = 0;
  var colrow1 = 1, colrow2 = 1, colrow3 = 1, colrow4 = 1;
  int sec = 0, fortimercountofquestions = 0;
  double mywidth = 60;
  Timer? timer;
  getontheload() async {
    QuizStream =
        await DatabaseServices().getCATquizquestion(widget.quizId, widget.cat);
    setState(() {});
  }

  @override
  void initState() {
    print("${widget.quizId}");
    getontheload();
    starttimer(); //-------------------------------------------------start timer
//start timer
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Widget iconcorrect() {
    return const CircleAvatar(
      radius: 15,
      backgroundColor: Colors.green,
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  Widget iconwrong() {
    return const CircleAvatar(
      radius: 15,
      backgroundColor: Colors.red,
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }

//for timer
  starttimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sec = sec + 1;
      });
      if (sec > 60) {
        controller.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceInOut);
        show = false;
        show1 = false;
        show2 = false;
        show3 = false;
        show4 = false;

        setState(() {
          gestureonoff = true;
        });
        sec = 0;
        count = count + 1;
        if (count >= fortimercountofquestions) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => ResultCATPage(
                        correctanswer: correctanswer,
                        incorrectanswer: incorrectanswer,
                        count: fortimercountofquestions,
                        myemail: widget.myemail.toString(),
                        mypassword: widget.mypassword.toString(),
                      ))));
        }
      }
    });
  }

  // ignore: non_constant_identifier_names
  Stream? QuizStream;
  PageController controller = PageController();
  Widget allQuiz() {
    return StreamBuilder(
        stream: QuizStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    fortimercountofquestions = snapshot.data.docs.length;
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 0), //adjusting space betwn question and bar
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.grey[850],
                      ),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.deepPurple, width: 1.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                ds["question"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //changing ...........................................1..........
                          GestureDetector(
                            onTap: gestureonoff
                                ? () {
                                    colrow1 = ds["option1"].toString().length;
                                    show =
                                        true; //show means any one option is selected
                                    show1 =
                                        true; //show3 means option 3 is selected
                                    if (ds["correctoption"] == ds["option1"]) {
                                      correctanswer = correctanswer + 1;
                                    } else {
                                      incorrectanswer = incorrectanswer + 1;
                                    }
                                    setState(() {
                                      gestureonoff = false;
                                    });
                                  }
                                : null,
                            child: show
                                ? Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: ds["correctoption"] ==
                                                    ds["option1"]
                                                ? Colors.green
                                                : Colors.red,
                                            width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: show1
                                        ? (colrow1 >
                                                25) //reverse condition one and the same (>25 <25)
                                            ? Column(
                                                children: [
                                                  Text(
                                                    ds["option1"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show1
                                                      ? ds["correctoption"] ==
                                                              ds["option1"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ds["option1"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show1
                                                      ? ds["correctoption"] ==
                                                              ds["option1"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                        : Text(
                                            ds["option1"],
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                : Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      ds["option1"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                          ),

                          //changing ends.......................................1..........
                          const SizedBox(
                            height: 30,
                          ),
                          //changing ...........................................2..........
                          GestureDetector(
                            onTap: gestureonoff
                                ? () {
                                    colrow2 = ds["option2"].toString().length;
                                    show =
                                        true; //show means any one option is selected
                                    show2 =
                                        true; //show3 means option 3 is selected
                                    if (ds["correctoption"] == ds["option2"]) {
                                      correctanswer = correctanswer + 1;
                                    } else {
                                      incorrectanswer = incorrectanswer + 1;
                                    }
                                    setState(() {
                                      gestureonoff = false;
                                    });
                                  }
                                : null,
                            child: show
                                ? Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: ds["correctoption"] ==
                                                    ds["option2"]
                                                ? Colors.green
                                                : Colors.red,
                                            width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: show2
                                        ? (colrow2 >
                                                25) //reverse condition one and the same (>25 <25)
                                            ? Column(
                                                children: [
                                                  Text(
                                                    ds["option2"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show2
                                                      ? ds["correctoption"] ==
                                                              ds["option2"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ds["option2"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show2
                                                      ? ds["correctoption"] ==
                                                              ds["option2"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                        : Text(
                                            ds["option2"],
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                : Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      ds["option2"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                          ),

                          //changing ends.......................................2..........
                          const SizedBox(
                            height: 30,
                          ),

                          //changing ...........................................3..........
                          GestureDetector(
                            onTap: gestureonoff
                                ? () {
                                    colrow3 = ds["option3"].toString().length;
                                    show =
                                        true; //show means any one option is selected
                                    show3 =
                                        true; //show3 means option 3 is selected
                                    if (ds["correctoption"] == ds["option3"]) {
                                      correctanswer = correctanswer + 1;
                                    } else {
                                      incorrectanswer = incorrectanswer + 1;
                                    }
                                    setState(() {
                                      gestureonoff = false;
                                    });
                                  }
                                : null,
                            child: show
                                ? Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: ds["correctoption"] ==
                                                    ds["option3"]
                                                ? Colors.green
                                                : Colors.red,
                                            width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: show3
                                        ? (colrow3 >
                                                25) //reverse condition one and the same (>25 <25)
                                            ? Column(
                                                children: [
                                                  Text(
                                                    ds["option3"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show3
                                                      ? ds["correctoption"] ==
                                                              ds["option3"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ds["option3"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show3
                                                      ? ds["correctoption"] ==
                                                              ds["option3"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                        : Text(
                                            ds["option3"],
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                : Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      ds["option3"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                          ),

                          //changing ends.......................................3..........
                          const SizedBox(
                            height: 30,
                          ),
                          //changing ...........................................4..........
                          GestureDetector(
                            onTap: gestureonoff
                                ? () {
                                    colrow4 = ds["option4"].toString().length;
                                    show =
                                        true; //show means any one option is selected
                                    show4 =
                                        true; //show3 means option 3 is selected
                                    if (ds["correctoption"] == ds["option4"]) {
                                      correctanswer = correctanswer + 1;
                                    } else {
                                      incorrectanswer = incorrectanswer + 1;
                                    }

                                    setState(() {
                                      gestureonoff = false;
                                    });
                                  }
                                : null,
                            child: show
                                ? Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: ds["correctoption"] ==
                                                    ds["option4"]
                                                ? Colors.green
                                                : Colors.red,
                                            width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: show4
                                        ? (colrow4 >
                                                25) //reverse condition one and the same (>25 <25)
                                            ? Column(
                                                children: [
                                                  Text(
                                                    ds["option4"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show4
                                                      ? ds["correctoption"] ==
                                                              ds["option4"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ds["option4"],
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  show4
                                                      ? ds["correctoption"] ==
                                                              ds["option4"]
                                                          ? iconcorrect()
                                                          : iconwrong()
                                                      : const SizedBox.shrink(),
                                                ],
                                              )
                                        : Text(
                                            ds["option4"],
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                : Container(
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      ds["option4"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                          ),

                          //changing ends.......................................4..........
                          const SizedBox(
                            height: 50,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     show = false;
                          //     show1 = false;
                          //     show2 = false;
                          //     show3 = false;
                          //     show4 = false;
                          //     count = count + 1;
                          //     setState(() {
                          //       gestureonoff = true;
                          //     });
                          //     if (count >= snapshot.data.docs.length) {
                          //       Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: ((context) => ResultCATPage(
                          //                     correctanswer: correctanswer,
                          //                     count: index + 1,
                          //                     myemail:
                          //                         widget.myemail.toString(),
                          //                     mypassword:
                          //                         widget.mypassword.toString(),
                          //                   ))));
                          //     } else {
                          //       controller.nextPage(
                          //           duration: const Duration(milliseconds: 200),
                          //           curve: Curves.bounceInOut);
                          //     }
                          //   },
                          //   child:

                          //   Container(
                          //     padding: const EdgeInsets.all(15),
                          //     width: MediaQuery.of(context).size.width,
                          //     decoration: BoxDecoration(
                          //         color: Colors.grey[400],
                          //         border: Border.all(
                          //             color: Colors.black, width: 1.5),
                          //         borderRadius: BorderRadius.circular(20)),
                          //     child: const Center(
                          //         child: Text(
                          //       "Next",
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w400),
                          //     )),
                          //   ),
                          // ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: ElevatedButton(
                              onPressed: () {
                                show = false;
                                show1 = false;
                                show2 = false;
                                show3 = false;
                                show4 = false;
                                count = count + 1;
                                sec = 0;
                                // fortimercountofquestions =
                                //     snapshot.data.docs.length;//no need
                                setState(() {
                                  gestureonoff = true;
                                });
                                if (count >= snapshot.data.docs.length) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => ResultCATPage(
                                                correctanswer: correctanswer,
                                                incorrectanswer:
                                                    incorrectanswer,
                                                count: index + 1,
                                                myemail:
                                                    widget.myemail.toString(),
                                                mypassword: widget.mypassword
                                                    .toString(),
                                              ))));
                                } else {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.bounceInOut);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.grey[100],
                                elevation: 20,
                                shadowColor: Colors.black54,
                                minimumSize: const Size.fromHeight(60),
                              ),
                              child: const Text(
                                "N E X T",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("P L A Y ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.grey[850],
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      // ignore: avoid_unnecessary_containers
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey[400],
          // child:
          // WebsafeSvg.asset("assets/images/bg.svg", fit: BoxFit.cover),
          // Text(""),
        ),
        Container(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 17.0),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Text(
              //         "$sec",
              //         style: TextStyle(color: Colors.black, fontSize: 18),
              //       ),
              //       SizedBox(
              //         width: 60,
              //         height: 60,
              //         child: CircularProgressIndicator(
              //           value: sec / 60,
              //           valueColor: const AlwaysStoppedAnimation(Colors.black),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
//circular timer -------------------------------end--------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) => Container(
                          // from 0 to 1 it takes 60s

                          width: constraints.maxWidth * 0.0085 * (sec * 2),
                          ////tukka lagla hahaha 0.06 cha * 60 wrong
                          ///constraints.maxWidth * 0.009 * (sec * 2) try try try but dont cry

                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],

                              //  [Colors.green, Colors.red],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20 / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${(sec).round()} sec",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.timer)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

//bar timer ----------------------------end---------------------------------
              Text(
                "QUESTION ${count + 1}/$fortimercountofquestions",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: allQuiz(),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
