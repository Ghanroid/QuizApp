import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/addquestions.dart';
import 'package:random_string/random_string.dart';

import 'database.dart';
import 'loginuipgfinal.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
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

      await databaseServices.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isloading = false;
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestions(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Quiz",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
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
                      decoration: const InputDecoration(
                        hintText: "Quiz Image Url",
                      ),
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
                      decoration: const InputDecoration(
                        hintText: "Quiz Title",
                      ),
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
                      decoration: const InputDecoration(
                        hintText: "Quiz Description",
                      ),
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
                        backgroundColor: Colors.deepPurple,
                        shape: const StadiumBorder(),
                        elevation: 20,
                        shadowColor: Theme.of(context).primaryColor,
                        minimumSize: const Size.fromHeight(60),
                      ),
                      child: const Text(
                        "Create Quiz",
                        style: TextStyle(color: Colors.white),
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
