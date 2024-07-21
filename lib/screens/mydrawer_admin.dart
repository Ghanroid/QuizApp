import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String useremail;
  MyDrawer({super.key, required this.useremail});
  final currentuser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      child: Column(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var userdata = snapshot.data!.docs[index];
                      return SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            userdata['username'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            userdata['email'],
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ]),
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
            })
      ]),
    );
  }
}
/* */

/*StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentuser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data!.data() as Map<String, dynamic>;
          

            return ;
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error ${snapshot.error}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }) */



// Drawer(
//               backgroundColor: Colors.deepPurple[300],
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(children: [
//                     DrawerHeader(
//                         child: Icon(
//                       Icons.person,
//                       color: Colors.white,
//                       size: 60,
//                     )),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.person_outline,
//                           color: Colors.white,
//                         ),
//                         title: Text(
//                           "U S E R N A M E",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400, fontSize: 20),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.email_outlined,
//                           color: Colors.white,
//                         ),
//                         title: Text(
//                           "E M A I L",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400, fontSize: 20),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   ]),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 12, bottom: 50),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.logout_outlined,
//                         color: Colors.white,
//                       ),
//                       onTap: () {
//                         FirebaseAuth.instance.signOut().then((value) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const LoginPage()));
//                         });
//                       },
//                       title: Text(
//                         "L O G O U T",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )