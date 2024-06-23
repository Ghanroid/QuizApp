import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_quiz/loginuipgfinal.dart';
import 'package:login_ui_quiz/timepass/tp_home.dart';

class Signtp extends StatefulWidget {
  const Signtp({super.key});

  @override
  State<Signtp> createState() => _SigntpState();
}

class _SigntpState extends State<Signtp> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool togglepassword = true;

  signup(String myemail, String mypassword) async {
    if (myemail == "" && mypassword == "") {
      return await showDialog(
          context: context,
          builder: (context) {
            // ignore: avoid_unnecessary_containers
            return Container(
              child: AlertDialog(
                title: const Text("Enter Required Fields"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              ),
            );
          });
    } else {
      // ignore: unused_local_variable

      try {
        UserCredential usercred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);

        FirebaseFirestore.instance
            .collection("Users")
            .doc(usercred.user!.email)
            .set({
          'username': usernameController.text,
          'email': emailController.text
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TpHomePage(
                    myemail: myemail, mypass: passwordController.text)));
      } on FirebaseAuthException catch (ex) {
        return await showDialog(
            context: context,
            builder: (context) {
              // ignore: avoid_unnecessary_containers
              return Container(
                child: AlertDialog(
                  // ignore: unnecessary_string_interpolations
                  title: Text("${ex.code.toString()}"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = const Color.fromARGB(255, 33, 33, 33);
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        image: DecorationImage(
          image: const AssetImage("assets/images/final_home.jpg"),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.quiz_rounded,
            size: 90,
            color: Colors.white,
          ),
          Text(
            "Q U I Z",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 250,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            _buildGreyText("Please login with your information"),
            const SizedBox(height: 30),
            _buildGreyText("User Name"),
            _buildInputFieldperson(usernameController, false),
            const SizedBox(height: 30),
            _buildGreyText("Email address"),
            _buildInputField(emailController, false),
            const SizedBox(height: 30),
            _buildGreyText("Password"),
            _buildInputField(passwordController, true),
            const SizedBox(height: 30),
            _buildLoginButton(),
            const SizedBox(height: 30),
            _buildRememberForgot(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      //style: const TextStyle(color: Colors.grey, fontSize: 16),

      style: TextStyle(
          color:
              // Color.fromARGB(255, 65, 65, 65),
              Colors.grey[900],
          fontSize: 16),
    );
  }

  Widget _buildInputField(TextEditingController controller, bool isPassword) {
    return isPassword
        ? TextField(
            controller: controller,
            obscureText: togglepassword,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    togglepassword = !togglepassword;
                  });
                },
                child: Icon(
                  togglepassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : TextField(
            controller: controller,
            decoration: const InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              suffixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            obscureText: false,
          );
  }

  Widget _buildInputFieldperson(
      TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        suffixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            _buildGreyText("I have an account!!"),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: Text(
            "LogIn ",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");

        signup(emailController.text.toString(),
            passwordController.text.toString());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "S I G N U P",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
      ),
    );
  }
}
