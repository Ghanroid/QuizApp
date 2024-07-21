import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/loginuipgfinal.dart';
import 'package:login_ui_quiz/screens/createCAT.dart';
//import '../createquiz.dart';
import 'playSet.dart';

class TpHomePage extends StatefulWidget {
  final String myemail, mypass;
  const TpHomePage({super.key, required this.myemail, required this.mypass});

  @override
  State<TpHomePage> createState() => _TpHomePageState();
}

class _TpHomePageState extends State<TpHomePage> {
  final currentuser = FirebaseAuth.instance.currentUser!;

  List<String>? docu1;
  Widget foradminfloating() {
    if (widget.myemail == "gh@gmail.com" && widget.mypass == "123456") {
      return FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateCAT()));
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

  //-------------------------------------------------------------
  bool adminORnot() {
    if (widget.myemail == "gh@gmail.com" && widget.mypass == "123456") {
      return true;
    }
    return false;
  }
  //--------------------------------------------------------

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
                  return Text(
                    userdata['username'],
                    style: TextStyle(
                        color: Colors.grey[300],
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    height: 220,
                    padding: const EdgeInsets.only(top: 20, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                          width: 50,
                          child: Icon(
                            Icons.person_rounded,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 150,
                            child: getname()),
                        SizedBox(
                          height: 103,
                          child: IconButton(
                              onPressed: () async {
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                });
                              },
                              icon: Icon(
                                Icons.logout,
                                size: 30,
                                color: Colors.grey[400],
                              )),
                        )
                      ],
                    ),
                  ),

                  //see more about box shadow!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: []),
                        margin: const EdgeInsets.only(
                            top: 120, left: 20, right: 20),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            "assets/images/homepgready.jpeg",
                            height: 250,
                            width: MediaQuery.of(context).size.width - 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "~*~Top Quiz Categories~*~",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0), // Removed top padding
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('AllCAT')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          return SingleChildScrollView(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width / 2,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 25.0,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaysetMY(
                                            myemail: widget.myemail,
                                            mypassword: widget.mypass,
                                            cat: data["name"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        elevation: 5.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                child: Image.network(
                                                  data["imgurl"],
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              // SizedBox(height: 8),
                                              adminORnot()
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        Text(
                                                          data["name"],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        // GestureDetector(
                                                        //     onTap: () {

                                                        //       FirebaseFirestore
                                                        //           .instance
                                                        //           .collection(
                                                        //               "AllCAT")
                                                        //           .doc(data[
                                                        //               "name"])
                                                        //           .delete();
                                                        //     },
                                                        //     child: Icon(
                                                        //         Icons.delete))
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "Confirmation"),
                                                                  content: Text(
                                                                      "Are you sure you want to delete this Category?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Close the dialog
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          "Cancel"),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Perform the deletion action here
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection("AllCAT")
                                                                            .doc(data["name"])
                                                                            .delete();

                                                                        // Close the dialog
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          "Delete"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Icon(
                                                              Icons.delete),
                                                        )
                                                      ],
                                                    )
                                                  : Text(
                                                      data["name"],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: foradminfloating());
  }
}

    //     Scaffold(
    //   appBar: AppBar(
    //     title: Text('Firestore Example'),
    //   ),
    //   body: StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('AllCAT').snapshots(),
    //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       }

    //       final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
    //       documents1 = documents;
    //       if (documents.isEmpty) {
    //         return Center(
    //           child: Text('No documents found'),
    //         );
    //       }

    //       return ListView.builder(
    //         itemCount: documents.length,
    //         itemBuilder: (context, index) {
    //           var document = documents[index];
    //           String docId = document.id; // Document ID

    //           // Display document ID
    //           return null;
    //
    //
    // ListTile(
    //   title: Text('Document ID: $docId'),
    //   // Add more widgets or customization as needed
    // );
    //         },
    //       );
    //     },
    //   ),
    // );
    //-------------------------------------------------------try---------------------
    // StreamBuilder<QuerySnapshot>(
    //             stream: FirebaseFirestore.instance
    //                 .collection('AllCAT')
    //                 .snapshots(),
    //             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return Center(
    //                   child: CircularProgressIndicator(),
    //                 );
    //               }

    //               if (snapshot.hasError) {
    //                 return Center(
    //                   child: Text('Error: ${snapshot.error}'),
    //                 );
    //               }

    //               final List<QueryDocumentSnapshot> documents =
    //                   snapshot.data!.docs;

    //               if (documents.isEmpty) {
    //                 return Center(
    //                   child: Text('No documents found'),
    //                 );
    //               }

    //               return ListView.builder(
    //                 itemCount: documents.length,
    //                 itemBuilder: (context, index) {
    //                   var document = documents[index];
    //                   String docId = document.id; // Document ID
    //                   docu1!.add(docId);

    //                   // Display document ID
    //                   return ListTile(
    //                     title: Text('Document ID: $docId'),
    //                     // Add more widgets or customization as needed
    //                   );
    //                 },
    //               );
    //             },
    //           ),

    //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;noob ;;;;'
    /*Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      PlaysetMY(
                                                          myemail:
                                                              widget.myemail,
                                                          mypassword:
                                                              widget.mypass,
                                                          cat: data["name"]))));
                                        },
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          elevation: 5.0,
                                          child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: Image.network(
                                                      data["imgurl"],
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Text(
                                                    data["name"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ), */
  