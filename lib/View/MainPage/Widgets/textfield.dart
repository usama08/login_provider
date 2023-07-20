import 'package:flutter/material.dart';

Widget textfield(BuildContext context, controllertext, labeltext, hinttext) {
  return TextField(
    controller: controllertext,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelText: labeltext,
      labelStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
      hintText: hinttext,
    ),
  );
}
