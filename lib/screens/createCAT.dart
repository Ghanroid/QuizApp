import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Quiz nava cha ahe tyat khup sare sets ahet
class CreateCAT extends StatefulWidget {
  const CreateCAT({super.key});

  @override
  State<CreateCAT> createState() => _CreateCATState();
}

class _CreateCATState extends State<CreateCAT> {
  TextEditingController catNameController = TextEditingController();
  TextEditingController catImgController = TextEditingController();
  List? documents1;
  final _formkeyCAT = GlobalKey<FormState>();
  String? imgCAT, nameCAT;
  getdata() {
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('AllCAT').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final List documents = snapshot.data!.docs;
        documents1 = documents;
        return SizedBox();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Create Category",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[850],
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
              key: _formkeyCAT,
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
                          hintText: "Category Image Url",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: (value) {
                        imgCAT = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Category Name";
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
                          hintText: "Category Name",
                          hintStyle: TextStyle(color: Colors.black)),
                      onChanged: (value) {
                        nameCAT = value;
                      },
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkeyCAT.currentState!.validate()) {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          try {
                            // Add data to the first collection
                            await firestore
                                .collection('AllCAT')
                                .doc(nameCAT)
                                .set({"name": nameCAT, "imgurl": imgCAT});
                            Navigator.pop(context);
                            print('Data added to collections successfully.');
                          } catch (e) {
                            // Error occurred
                            print('Error adding data: $e');
                          }
                        }
                        //Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        shape: const StadiumBorder(),
                        elevation: 20,
                        shadowColor: Theme.of(context).primaryColor,
                        minimumSize: const Size.fromHeight(60),
                      ),
                      child: const Text(
                        "Create Quiz Category",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
        ));
  }
}
/* */

//=--------------------imp
/*Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: catImgController,
              decoration: InputDecoration(
                labelText: 'Enter the ImageUrl',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: catNameController,
              decoration: InputDecoration(
                labelText: 'Enter Category Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("AllCAT")
                    .doc(catNameController.text);

                FirebaseFirestore.instance
                    .collection(catNameController.text)
                    .snapshots();
                print(catNameController);
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                try {
                  // Add data to the first collection
                  await firestore
                      .collection('AllCAT')
                      .doc(catNameController.text)
                      .set({
                    "name": catNameController.text,
                    "imgurl": catImgController.text
                  });

                  // Add data to the second collection

                  // await firestore.collection('${catNameController.text}');

                  // Data added successfully
                  print('Data added to collections successfully.');
                } catch (e) {
                  // Error occurred
                  print('Error adding data: $e');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ), */
