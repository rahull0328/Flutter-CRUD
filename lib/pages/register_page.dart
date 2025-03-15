import 'package:crud/components/my_button.dart';
import 'package:crud/components/my_textfield.dart';
import 'package:crud/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Register method
  void registerUser() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Ensure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // Pop loading circle
      Navigator.pop(context);

      // Display error message
      displayMessageToUser("Passwords don't match!", context);
    } else {
      try {
        // Create the user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Pop loading circle
        Navigator.pop(context);

        // Display error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 15),

              // App name
              const Text(
                "NotesNest",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),

              // Username textField
              MyTextfield(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),

              // Email textField
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password textField
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Confirm password textField
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 15),

              // Register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(height: 10),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
