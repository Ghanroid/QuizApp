///progress bar----------------------------------------------------------------------
/* Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              // LayoutBuilder provide us the available space for the conatiner
              // constraints.maxWidth needed for our animation
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  // from 0 to 1 it takes 60s
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${(controller.animation.value * 60).round()} sec"),
                      SvgPicture.asset("assets/icons/clock.svg"),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    )*/
    ///progress bar----------------------------------------------end------------------------
    ///
    ///
    /*StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('AllCAT')
                        .snapshots(),
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

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          // Customize your UI to display data
                          return
                              // ListTile(
                              //   title: Text(data['name']),
                              //   subtitle: Text(data['imgurl']),
                              // );

                              SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
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
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),*/






                  //------------------------------------first row---------------------------tphome 
                  /*         //first row ................................................
                // Padding(
                //   padding: const EdgeInsets.only(left: 0, right: 0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: ((context) => PlaysetMY(
                //                       myemail: widget.myemail,
                //                       mypassword: widget.mypass,
                //                       cat: "kids"))));
                //         },
                //         child: Material(
                //           borderRadius: BorderRadius.circular(20),
                //           elevation: 5.0,
                //           child: Container(
                //               padding: const EdgeInsets.all(15),
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(20)),
                //               child: Column(
                //                 children: [
                //                   ClipRRect(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(20)),
                //                     child: Image.asset(
                //                       "assets/images/final_kids.jpg",
                //                       width: 120,
                //                       height: 120,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                   const Text(
                //                     "K I D S",
                //                     style: TextStyle(
                //                         color: Colors.black,
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.w600),
                //                   )
                //                 ],
                //               )),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: ((context) => PlaysetMY(
                //                       myemail: widget.myemail,
                //                       mypassword: widget.mypass,
                //                       cat: "Coding"))));
                //         },
                //         child: Material(
                //           borderRadius: BorderRadius.circular(20),
                //           elevation: 5.0,
                //           child: Container(
                //               padding: const EdgeInsets.all(15),
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(20)),
                //               child: Column(
                //                 children: [
                //                   ClipRRect(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(20)),
                //                     child: Image.asset(
                //                       "assets/images/final_coding.jpg",
                //                       width: 120,
                //                       height: 120,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                   const Text(
                //                     "C O D I N G",
                //                     style: TextStyle(
                //                         color: Colors.black,
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.w600),
                //                   )
                //                 ],
                //               )),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
//                 // //second row...........................................................
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 0, right: 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => PlaysetMY(
//                                       myemail: widget.myemail,
//                                       mypassword: widget.mypass,
//                                       cat: "Math"))));
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20),
//                           elevation: 5.0,
//                           child: Container(
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                     child: Image.asset(
//                                       "assets/images/final_math3.jpg",
//                                       width: 120,
//                                       height: 120,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const Text(
//                                     "M A T H ",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => PlaysetMY(
//                                       myemail: widget.myemail,
//                                       mypassword: widget.mypass,
//                                       cat: "Science"))));
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20),
//                           elevation: 5.0,
//                           child: Container(
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                     child: Image.asset(
//                                       "assets/images/final_sci1.jpg",
//                                       width: 120,
//                                       height: 120,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const Text(
//                                     "S C I E N C E ",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 // //third row...........................................................
//                 const SizedBox(
//                   height: 20,
//                 ),
//  // for (int i = 0; i < docu1!.length; i++)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 0, right: 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => PlaysetMY(
//                                       myemail: widget.myemail,
//                                       mypassword: widget.mypass,
//                                       cat: "Quiz"))));
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20),
//                           elevation: 5.0,
//                           child: Container(
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                     child: Image.asset(
//                                       "assets/images/final_sci3.jpg",
//                                       width: 120,
//                                       height: 120,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const Text(
//                                     "R A N D O M",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => PlaysetMY(
//                                       myemail: widget.myemail,
//                                       mypassword: widget.mypass,
//                                       cat: "Quiz"))));
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20),
//                           elevation: 5.0,
//                           child: Container(
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                     child: Image.asset(
//                                       "assets/images/final_math1.jpg",
//                                       width: 120,
//                                       height: 120,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const Text(
//                                     "R A N D O M",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
           */