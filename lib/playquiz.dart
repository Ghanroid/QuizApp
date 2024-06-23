import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/database.dart';
import 'package:login_ui_quiz/resultpage.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  final String myemail, mypassword;
  const PlayQuiz(
      {required this.quizId, required this.myemail, required this.mypassword});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  bool show = false, show1 = false, show2 = false, show3 = false, show4 = false;
  bool gestureonoff = true;
  int count = 0;
  int correctanswer = 0;
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       child: Column(
  //         children: [
  //           StreamBuilder(
  //             stream: FirebaseFirestore.instance
  //                 .collection("Quiz")
  //                 .doc(widget.quizId)
  //                 .collection("QNA")
  //                 .snapshots(),
  //             builder: (context, snapshot) {
  //               List<Container> quizD = [];
  //               if (snapshot.hasData) {
  //                 final quizdata = snapshot.data?.docs.reversed.toList();
  //                 for (var q in quizdata!) {
  //                   final quizrow = Container(
  //                     margin: const EdgeInsets.only(bottom: 10),
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             q["question"],
  //                             style: TextStyle(fontSize: 20),
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               show = true;
  //                               setState(() {});
  //                             },
  //                             child: show
  //                                 ? Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: q["correctoption"] ==
  //                                                     q["option1"]
  //                                                 ? Colors.green
  //                                                 : Colors.red,
  //                                             width: 1.5),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option1"],
  //                                     ),
  //                                   )
  //                                 : Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: Colors.deepPurpleAccent),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option1"],
  //                                     ),
  //                                   ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                             height: 10,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               show = true;
  //                               setState(() {});
  //                             },
  //                             child: show
  //                                 ? Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: q["correctoption"] ==
  //                                                     q["option2"]
  //                                                 ? Colors.green
  //                                                 : Colors.red,
  //                                             width: 1.5),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option2"],
  //                                     ),
  //                                   )
  //                                 : Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: Colors.deepPurpleAccent),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option2"],
  //                                     ),
  //                                   ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                             height: 10,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               show = true;
  //                               setState(() {});
  //                             },
  //                             child: show
  //                                 ? Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: q["correctoption"] ==
  //                                                     q["option3"]
  //                                                 ? Colors.green
  //                                                 : Colors.red,
  //                                             width: 1.5),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option3"],
  //                                     ),
  //                                   )
  //                                 : Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: Colors.deepPurpleAccent),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option3"],
  //                                     ),
  //                                   ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                             height: 10,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               show = true;
  //                               setState(() {});
  //                             },
  //                             child: show
  //                                 ? Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: q["correctoption"] ==
  //                                                     q["option4"]
  //                                                 ? Colors.green
  //                                                 : Colors.red,
  //                                             width: 1.5),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option4"],
  //                                     ),
  //                                   )
  //                                 : Container(
  //                                     width: MediaQuery.of(context).size.width,
  //                                     padding: EdgeInsets.all(15),
  //                                     decoration: BoxDecoration(
  //                                         border: Border.all(
  //                                             color: Colors.deepPurpleAccent),
  //                                         borderRadius:
  //                                             BorderRadius.circular(15)),
  //                                     child: Text(
  //                                       q["option4"],
  //                                     ),
  //                                   ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                             height: 10,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                   quizD.add(quizrow);
  //                 }
  //               }
  //               return Expanded(
  //                 child: ListView(
  //                   children: quizD,
  //                 ),
  //               );
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  getontheload() async {
    QuizStream = await DatabaseServices().getquizquestion(widget.quizId);
    setState(() {});
  }

  @override
  void initState() {
    print("${widget.quizId}");
    getontheload();

    super.initState();
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
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        const SizedBox(
                          height: 30,
                        ),
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
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: gestureonoff
                              ? () {
                                  show = true;
                                  show1 = true;
                                  if (ds["correctoption"] == ds["option1"]) {
                                    correctanswer = correctanswer + 10;
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
                                      border: Border.all(
                                          color: ds["correctoption"] ==
                                                  ds["option1"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Text(
                                        ds["option1"], //show1 true asel teva icon show kar
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      show1
                                          ? ds["correctoption"] == ds["option1"]
                                              ? iconcorrect()
                                              : iconwrong()
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurple, width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    ds["option1"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: gestureonoff
                              ? () {
                                  show = true;
                                  show2 = true;
                                  if (ds["correctoption"] == ds["option2"]) {
                                    correctanswer = correctanswer + 10;
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
                                      border: Border.all(
                                          color: ds["correctoption"] ==
                                                  ds["option2"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Text(
                                        ds["option2"], //show1 true asel teva icon show kar
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      show2
                                          ? ds["correctoption"] == ds["option2"]
                                              ? iconcorrect()
                                              : iconwrong()
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurple, width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    ds["option2"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: gestureonoff
                              ? () {
                                  show = true;
                                  show3 = true;
                                  if (ds["correctoption"] == ds["option3"]) {
                                    correctanswer = correctanswer + 10;
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
                                      border: Border.all(
                                          color: ds["correctoption"] ==
                                                  ds["option3"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Text(
                                        ds["option3"], //show1 true asel teva icon show kar
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      show3
                                          ? ds["correctoption"] == ds["option3"]
                                              ? iconcorrect()
                                              : iconwrong()
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurple, width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    ds["option3"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: gestureonoff
                              ? () {
                                  show = true;
                                  show4 = true;
                                  if (ds["correctoption"] == ds["option4"]) {
                                    correctanswer = correctanswer + 10;
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
                                      border: Border.all(
                                          color: ds["correctoption"] ==
                                                  ds["option4"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Text(
                                        ds["option4"], //show1 true asel teva icon show kar
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      show4
                                          ? ds["correctoption"] == ds["option4"]
                                              ? iconcorrect()
                                              : iconwrong()
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurple, width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    ds["option4"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            show = false;
                            show1 = false;
                            show2 = false;
                            show3 = false;
                            show4 = false;
                            count = count + 1;
                            setState(() {
                              gestureonoff = true;
                            });
                            if (count >= snapshot.data.docs.length) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ResultPage(
                                            correctanswer: correctanswer,
                                            count: index + 1,
                                            myemail: widget.myemail.toString(),
                                            mypassword:
                                                widget.mypassword.toString(),
                                          ))));
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.bounceInOut);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[100],
                                border: Border.all(
                                    color: Colors.deepPurple, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Play Page",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: allQuiz(),
          )
        ],
      )),
    );
  }
}
