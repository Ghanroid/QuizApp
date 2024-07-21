import 'package:flutter/material.dart';
import 'package:login_ui_quiz/services/database.dart';
import 'package:random_string/random_string.dart';

class AddCATQuestions extends StatefulWidget {
  final String quizId, cat;
  const AddCATQuestions({super.key, required this.quizId, required this.cat});

  @override
  State<AddCATQuestions> createState() => _AddCATQuestionsState();
}

class _AddCATQuestionsState extends State<AddCATQuestions> {
  final _formkey = GlobalKey<FormState>();
  late String option1,
      option2,
      option3,
      option4,
      question,
      questionId,
      correctoption;
  DatabaseServices databaseServices = DatabaseServices();
  bool _isloading = false;
  addQuestionOnline() async {
    if (_formkey.currentState!.validate()) {
      questionId = randomAlphaNumeric(16);
      Map<String, dynamic> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
        "correctoption": correctoption,
      };
      setState(() {
        _isloading = true;
      });

      await databaseServices
          .addCATQuetions(questionMap, widget.quizId, widget.cat)
          .then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          " Quiz Questions",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 1.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                  key: _formkey,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Question";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Question",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                question = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Option 1";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Option 1",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                option1 = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Option 2";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Option 2",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                option2 = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Option 3";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Option 3",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                option3 = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Option 4";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Option 4",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                option4 = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Correct Option";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  hintText: "Correct Option",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                correctoption = value;
                              },
                            ),
                            // const Spacer(),
                          ],
                        ),
//space between ny tar evenly tya sathi
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Timer(Duration(seconds: 2), () {
                                //   print(
                                //       "Yeah, this line is printed after 3 seconds");

                                // });
                                if (_formkey.currentState!.validate()) {
                                  addQuestionOnline();
                                  Navigator.pop(context);
                                } else {
                                  addQuestionOnline();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor: Colors.grey[900],
                                shape: const StadiumBorder(),
                                elevation: 20,
                                shadowColor: Theme.of(context).primaryColor,
                                // minimumSize: const Size.fromHeight(60),
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                addQuestionOnline();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor: Colors.grey[900],
                                shape: const StadiumBorder(),
                                elevation: 20,
                                shadowColor: Theme.of(context).primaryColor,
                                // minimumSize: const Size.fromWidth(10),
                              ),
                              child: const Text(
                                "Add Questions",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
