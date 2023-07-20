import 'package:flutter/material.dart';

Widget myContainer(BuildContext context, text) {
  return Container(
    alignment: Alignment.center,
    width: 150,
    height: 80,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 247, 214, 98),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ),
  );
}
