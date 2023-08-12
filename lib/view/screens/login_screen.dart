import 'package:flutter/material.dart';
import 'package:flutter_lab2/view/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      return 'password is too short';
                    }
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('email', emailController.text);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(email: emailController.text)));
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
                  onPressed: () {},
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
}
