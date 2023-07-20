import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginController>(context, listen: true);

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 241, 225, 169),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 55),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Email!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgetscreen');
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    print("submit");
                    controller.submittologin(context);
                    controller.usernameController.clear();
                    controller.passwordController.clear();
                  },
                  child: const Text('Login'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signupscren');
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
