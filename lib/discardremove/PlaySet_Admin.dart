import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:login_ui_quiz/loginuipgfinal.dart';
import 'package:login_ui_quiz/nouse/playCATqq.dart';

import '../createquiz.dart';
import '../nouse/mydrawer_admin.dart';

class PlaysetAdmin extends StatefulWidget {
  final String myemail, mypassword, cat;
  const PlaysetAdmin(
      {super.key,
      required this.myemail,
      required this.mypassword,
      required this.cat});

  @override
  State<PlaysetAdmin> createState() => _PlaysetAdminState();
}

class _PlaysetAdminState extends State<PlaysetAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.cat}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        //automaticallyImplyLeading: false,
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
      //Text("user is ${userdetails!.email.toString()}"),
      drawer: MyDrawer(
        useremail: widget.myemail.toString(),
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
                                builder: ((context) =>
                                    //  PlayQuiz(
                                    //       quizId: q["quizId"],
                                    //       myemail: widget.myemail.toString(),
                                    //       mypassword: widget.mypassword.toString(),
                                    //     )
                                    PlayCAT(
                                        quizId: q["quizId"],
                                        myemail: widget.myemail,
                                        mypassword: widget.mypassword,
                                        cat: widget.cat))));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 150,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                q["quizImg"],
                                width: MediaQuery.of(context).size.width - 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  q["quizTitle"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                // Text(q["quizId"]),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                Text(
                                  q["quizDesc"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
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
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateQuiz()));
          }),
    );
  }
}
