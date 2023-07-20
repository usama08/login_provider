import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApis extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String apiUrl =
      "https://login-signup.p.rapidapi.com/public/v1/login.php";
  final String apiKey = "394e9338b73a9f061b1968ceaa050a";

  Future<Map<String, dynamic>> loginUser() async {
    Map<String, String> headers = {
      "X-RapidAPI-Host": "login-signup.p.rapidapi.com",
    };

    Map<String, String> requestBody = {
      "api_key": apiKey,
      "email": emailController.text, // Use .text instead of .toString()
      "password": passwordController.text, // Use .text instead of .toString()
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON response
        Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      // Handle specific exceptions (e.g., SocketException, TimeoutException)
      throw Exception('Failed to connect to the server.');
    }
  }
}
