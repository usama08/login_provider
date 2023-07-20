import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/login_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginController>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        // controller.();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          // controller.clearData();
        },
        child: Scaffold(
          body: Container(
            color: const Color.fromARGB(255, 241, 225, 169),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.signusernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a username!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid number!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.signpasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print("submit");
                        controller.submit(context);
                      },
                      child: Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
