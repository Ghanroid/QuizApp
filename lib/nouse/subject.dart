import 'package:flutter/material.dart';

Widget subjectImg(
    String imgurl, String text, String cat, String email, String pass) {
  return GestureDetector(
    onTap: () {},
    child: Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5.0,
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  imgurl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "$text",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          )),
    ),
  );
}
