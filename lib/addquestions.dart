import 'package:flutter/material.dart';
import 'package:login_ui_quiz/database.dart';
import 'package:random_string/random_string.dart';

class AddQuestions extends StatefulWidget {
  final String quizId;
  const AddQuestions(this.quizId);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final _formkey = GlobalKey<FormState>();
  late String option1,
      option2,
      option3,
      option4,
      question,
      quizId,
      correctoption;
  DatabaseServices databaseServices = DatabaseServices();
  bool _isloading = false;
  addQuestionOnline() async {
    if (_formkey.currentState!.validate()) {
      quizId = randomAlphaNumeric(16);
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
          .addQuetions(questionMap, widget.quizId)
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          " Quiz Questions",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formkey,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Question";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Question",
                      ),
                      onChanged: (value) {
                        question = value;
                      },
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter option1";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "option1",
                      ),
                      onChanged: (value) {
                        option1 = value;
                      },
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter option2";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "option2",
                      ),
                      onChanged: (value) {
                        option2 = value;
                      },
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter option3";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "option3",
                      ),
                      onChanged: (value) {
                        option3 = value;
                      },
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter option4";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "option4",
                      ),
                      onChanged: (value) {
                        option4 = value;
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter correctoption";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "correct option",
                      ),
                      onChanged: (value) {
                        correctoption = value;
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addQuestionOnline();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            backgroundColor: Colors.deepPurple,
                            shape: const StadiumBorder(),
                            elevation: 20,
                            shadowColor: Theme.of(context).primaryColor,
                            // minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                            backgroundColor: Colors.deepPurple,
                            shape: const StadiumBorder(),
                            elevation: 20,
                            shadowColor: Theme.of(context).primaryColor,
                            // minimumSize: const Size.fromWidth(10),
                          ),
                          child: const Text(
                            "Add Questions",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                  ],
                ),
              )),
    );
  }
}
