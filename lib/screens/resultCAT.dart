import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/screens/tp_home.dart';

class ResultCATPage extends StatefulWidget {
  final int correctanswer, count, incorrectanswer;
  final String myemail, mypassword;
  ResultCATPage(
      {required this.correctanswer,
      required this.incorrectanswer,
      required this.count,
      required this.myemail,
      required this.mypassword});

  @override
  State<ResultCATPage> createState() => _ResultCATPageState();
}

class _ResultCATPageState extends State<ResultCATPage> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  String nameusertrying = "";
  int notattempted = 0;
  int notattempt(int corr, int incorr, int tcount) {
    return tcount - (corr + incorr);
  }

  int yourscore(int corr, int tcount) {
    double sc = ((corr * 100) / tcount);
    return sc.toInt();
  }

  //-----------------------------------

  //-----------------------------------

  Widget getname() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: currentuser.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var userdata = snapshot.data!.docs[index];
                  nameusertrying = userdata["username"];
                  return Text(
                    "${userdata['username']} Your Result=${yourscore(widget.correctanswer, widget.count)}/100",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[850]),
                  child: Center(
                    child: CircleAvatar(
                      radius: 95,
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white.withOpacity(.4),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Score",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 20),
                                ),
                                Text(
                                  " ${yourscore(widget.correctanswer, widget.count)}%",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 25,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 4,
                            color: Colors.black54,
                            offset: Offset(0, 1)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[900]),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${(widget.count)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Text("Total Questions")
                                ],
                              ),
                              const SizedBox(
                                width: 115,
                              ),
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[900]),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${widget.incorrectanswer + widget.correctanswer}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Text("Attempted")
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${widget.correctanswer}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Text("Correct")
                                ],
                              ),
                              const SizedBox(
                                width: 70,
                              ),
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${widget.incorrectanswer}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Text("Incorrect")
                                ],
                              ),
                              const SizedBox(
                                width: 45,
                              ),
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${notattempt(widget.correctanswer, widget.incorrectanswer, widget.count)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Text("Not Attempted")
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TpHomePage(
                                      myemail: widget.myemail,
                                      mypass: widget.mypassword)));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 48, 48, 48),
                          radius: 35,
                          child: Center(
                            child: Icon(
                              Icons.home,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Text("Home Page")
                    ],
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 48, 48, 48),
                          radius: 35,
                          child: Center(
                            child: Icon(
                              Icons.refresh,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Text("Play Again")
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: getname(),
          )
        ],
      ),
    );
  }
}

/**Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getname(),
            Container(
              child: Text("${widget.correctanswer} Correct "),
            ),
            Text("${widget.incorrectanswer} Incorrect"),
            Text(
                "${notattempt(widget.correctanswer, widget.incorrectanswer, widget.count)}Not Attempted"),
            Text(
                "Your ${widget.correctanswer * 10} score out of${widget.count * 10}"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TpHomePage(
                            myemail: widget.myemail.toString(),
                            mypass: widget.mypassword.toString())));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Colors.grey,
                minimumSize: const Size.fromHeight(60),
              ),
              child: const Text(
                "HomePage",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ), */