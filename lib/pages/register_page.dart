import 'package:crud/components/my_button.dart';
import 'package:crud/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  //text editing controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  //register method
  void register() {

  }

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              //app name
              const Text(
                "NotesNest",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

              //username textField
              MyTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController
              ),
              const SizedBox(height: 10),

              //email textField
              MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController
              ),
              const SizedBox(height: 10),

              //password textField
              MyTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController
              ),
              const SizedBox(height: 10),

              //confirm password textField
              MyTextfield(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController
              ),
              const SizedBox(height: 10),

              //sign up button
              MyButton(
                text: "Register",
                onTap: register,
              ),
              const SizedBox(height: 25,),

              //Already have an account register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account ?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      " Login Here...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
