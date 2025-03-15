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

  //text editing controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  //register method
  void registerUser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(),
      ),
    );
    //making sure passwords match
    if(passwordController.text != confirmPasswordController.text) {
      //pop loading circle
      Navigator.pop(context);

      //display error message
      displayMessageToUser("Passwords don't Match!", context);
    } else {
      //try creating the user
      try {
        //create the user
        UserCredential? userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        //pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);

        //displaying error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

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
              const SizedBox(height: 20),

              //sign up button
              MyButton(
                text: "Register",
                onTap: registerUser,
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
                    onTap: widget.onTap,
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
