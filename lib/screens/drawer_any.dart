import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerAny extends StatelessWidget {
  DrawerAny({super.key});
  final currentuser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      child: Column(children: [
        StreamBuilder(
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
