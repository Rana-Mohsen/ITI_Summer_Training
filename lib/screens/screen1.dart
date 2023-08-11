import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String email =" ";
  getCachedEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email =  prefs.getString('email') ?? "--";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCachedEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("screen1 \n $email"),
    );
  }
}
