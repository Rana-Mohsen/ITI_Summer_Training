import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab2/view/screens/home_screen.dart';
import 'package:flutter_lab2/view/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      bool user = await createUser(
                          emailController.text, passwordController.text);

                      if (user) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('email', emailController.text);
                        snackBarMessage(context, "successfuly loged in");

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(email: emailController.text)));
                      } else {
                        snackBarMessage(context, "failed to log in");
                      }
                    }
                    ;
                  },
                  child: Container(
                    child: Center(child: Text("Login")),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Text(
                  "Forgot password? TAP ME",
                  style: TextStyle(color: Colors.black54),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SignupScreen()));
                  },
                  child: Text(
                    "No Account? Sign Up",
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(500, 40)),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 215, 215, 215))),
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
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong_password") {
        snackBarMessage(context, "wrong password");
      } else if (e.code == "invalid-email") {
        snackBarMessage(context, "invalid email");
      } else if (e.code == "user-not-found") {
        snackBarMessage(context, "user does not exist");
      }
    }
    return false;
  }
}
