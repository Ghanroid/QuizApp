import 'package:flutter/material.dart';

import 'package:login_ui_quiz/nouse/addCATquestions.dart';
import 'package:random_string/random_string.dart';

import '../database.dart';

class CreateCATQuiz extends StatefulWidget {
  final String cat;
  const CreateCATQuiz({super.key, required this.cat});

  @override
  State<CreateCATQuiz> createState() => _CreateCATQuizState();
}

class _CreateCATQuizState extends State<CreateCATQuiz> {
  final _formkey = GlobalKey<FormState>();
  late String quizImg, quizTitle, quizDesc, quizId;
  bool _isloading = false;

  DatabaseServices databaseServices = DatabaseServices();
  createQuizOnline() async {
    if (_formkey.currentState!.validate()) {
      quizId = randomAlphaNumeric(16);
      Map<String, dynamic> quizMap = {
        "quizId": quizId,
        "quizImg": quizImg,
        "quizDesc": quizDesc,
        "quizTitle": quizTitle
      };
      setState(() {
        _isloading = true;
      });

      await databaseServices
          .addCATQuizData(quizMap, quizId, widget.cat)
          .then((value) {
        setState(() {
          _isloading = false;
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddCATQuestions(
                      quizId: quizId,
                      cat: widget.cat,
                    )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Quiz",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         FirebaseAuth.instance.signOut().then((value) {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const LoginPage()));
        //         });
        //       },
        //       icon: const Icon(
        //         Icons.logout,
        //         color: Colors.white,
        //       ))
        // ],
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Image Url";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          hintText: "Quiz Image Url",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: (value) {
                        quizImg = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Quiz Title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          // focusColor: Colors.black,

                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10)),
                          hintText: "Quiz Title",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: (value) {
                        quizTitle = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Quiz Description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5)),
                          hintText: "Quiz Description",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: (value) {
                        quizDesc = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        createQuizOnline();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        shape: const StadiumBorder(),
                        elevation: 20,
                        shadowColor: Theme.of(context).primaryColor,
                        minimumSize: const Size.fromHeight(60),
                      ),
                      child: const Text(
                        "Create Quiz",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
    );
  }
}
