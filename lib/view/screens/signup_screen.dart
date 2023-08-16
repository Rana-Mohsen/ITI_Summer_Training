
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab2/view/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/flutter_image.jpg",
                  width: 130,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "email"),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.contains('@') == false) {
                      return 'enter valid email';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      return 'password is too short';
                    }
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      bool user =await createUser(emailController.text, passwordController.text);
                      if (user) {
                      snackBarMessage(context, "Processing Data");

                      Navigator.pop(context);
                    } else {
                      snackBarMessage(context, "registeration failed");
                    }
                    }
                  },
                  child: Container(
                    child: Center(child: Text("Sign up")),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  void snackBarMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!= null) return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak_password") {
        snackBarMessage(context, "your password is weak");
      } else if (e.code == "email-already-in-use") {
        snackBarMessage(context, "email is already in use");
      }
    }
    return false;
  }
}
