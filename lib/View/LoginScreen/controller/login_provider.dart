import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signusernameController = TextEditingController();
  TextEditingController signpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void submit(BuildContext context) {
    final isValid = formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    formKey.currentState?.save();

    // Perform registration logic
    registerEmailPassword(context);
  }

  void submittologin(BuildContext context) {
    final isValid = formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    formKey.currentState?.save();
    // Perform registration logic
    signInEmailPassword(context);
  }

  Future<dynamic> registerEmailPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: signpasswordController.text.trim().toString(),
      );

      if (userCredential.user != null) {
        // Show registration success message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the home page
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/dashboard');
      }

      // ignore: unused_local_variable
      User? user = userCredential.user;
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.code}'),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> signInEmailPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: passwordController.text.trim().toString(),
      );

      if (userCredential.user != null) {
        // Show loading indicator
        // ignore: use_build_context_synchronously
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 2,
              ),
            );
          },
        );

        await Future.delayed(const Duration(seconds: 3));

        // Navigate to the dashboard screen
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/dashboard');
      }

      // ignore: unused_local_variable
      User? user = userCredential.user;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-in failed: ${e.code}'),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    } catch (e) {
      return false;
    }
  }

/////// ------------ reset password ------------------/////////////
  void resetPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Perform password reset logic
      // ignore: unused_local_variable
      String email = emailController.text.trim();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset'),
            content: const Text(
              'An email with instructions to reset your password has been sent.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to the login screen
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      sendPasswordResetEmail(context);
    }
  }

  //// ----------------- reset password email -----------------/////

  Future<dynamic> sendPasswordResetEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim().toString(),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the login screen
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email: ${e.code}'),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    signpasswordController.dispose();
    signusernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
