import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/adminhome.dart';
import 'package:login_ui_quiz/home.dart';

class ResultPage extends StatefulWidget {
  final int correctanswer, count;
  final String myemail, mypassword;
  ResultPage(
      {required this.correctanswer,
      required this.count,
      required this.myemail,
      required this.mypassword});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.correctanswer} score  ${widget.count * 10}out of"),
            Text(
              "${currentUser.email} ",
              style: TextStyle(fontSize: 26),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.myemail == "gh@gmail.com" &&
                    widget.mypassword == "123456") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminHomePage(
                                myemail: widget.myemail.toString(),
                                mypassword: widget.mypassword.toString(),
                              )));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageQUiz(
                              myemail: widget.myemail.toString(),
                              mypassword: widget.mypassword.toString())));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Colors.deepPurple[100],
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text("HomePage"),
            ),
          ],
        ),
      ),
    );
  }
}
