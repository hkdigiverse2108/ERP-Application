import 'package:ai_setu/core/constants/images.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  Images.splashBg,
                  height: 200,
                  width: double.infinity,
                ),
                Center(
                  child: Text(
                    "AI Setu",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // Sign In
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign in to your account",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Sign In")),
          ],
        ),
      ),
    );
  }
}
