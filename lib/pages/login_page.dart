import 'package:flutter/material.dart';

void main () {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 20),
            //app name
            Text(
              "CRUD APP",
              style: TextStyle(fontSize: 20),
            ),
          ],
          //email textField
          //password textField
          //forgot password
          //sign in button
          //don't have an account register here
        ),
      ),
    );
  }
}
