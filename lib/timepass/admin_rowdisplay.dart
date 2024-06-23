import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:login_ui_quiz/createquiz.dart';

import 'package:login_ui_quiz/loginuipgfinal.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final useremail = FirebaseAuth.instance.currentUser;
  //Text("user is ${useremail!.email.toString()}"), body madhe yenar display sathi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
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
      //Text("user is ${useremail!.email.toString()}"),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Quiz").snapshots(),
            builder: (context, snapshot) {
              List<Row> quizD = [];
              if (snapshot.hasData) {
                final quizdata = snapshot.data?.docs.reversed.toList();
                for (var q in quizdata!) {
                  final quizrow = Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(q["quizDesc"]),
                      Text(q["quizId"]),
                      Text(q["quizTitle"]),
                    ],
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

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          }),
    );
  }
}
