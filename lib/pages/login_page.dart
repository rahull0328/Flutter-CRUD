import 'package:crud/components/my_button.dart';
import 'package:crud/components/my_textfield.dart';
import 'package:crud/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async{
    //show loading screen
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );

    //user login process
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    }

    //display any errors
    on FirebaseAuthException catch (e){
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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
                "NoteNest",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

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

              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //sign in button
              MyButton(
                  text: "Login",
                  onTap: login,
              ),
              const SizedBox(height: 25,),

              //don't have an account register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register Here...",
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
