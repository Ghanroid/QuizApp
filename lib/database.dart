import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

//for category
  Future<void> addCATQuizData(
      Map<String, dynamic> quizData, String quizId, String cat) async {
    await FirebaseFirestore.instance
        .collection(cat)
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuetions(
      Map<String, dynamic> questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      print(e.toString());
    });
  }

//for category
  Future<void> addCATQuetions(
      Map<String, dynamic> questionData, String quizId, String cat) async {
    await FirebaseFirestore.instance
        .collection(cat)
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  // getquestionsformquiz(String quizId) async {
  //   return await FirebaseFirestore.instance
  //       .collection("Quiz")
  //       .doc(quizId)
  //       .collection("QNA")
  //       .snapshots();
  // }

  Future<Stream<QuerySnapshot>> getquizquestion(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getCATquizquestion(
      String quizId, String cat) async {
    return await FirebaseFirestore.instance
        .collection(cat)
        .doc(quizId)
        .collection("QNA")
        .snapshots();
  }
}
