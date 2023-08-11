import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.email});
  String email;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = [Screen1(), Screen2(), Screen3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "screen1"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "screen2"),
          BottomNavigationBarItem(icon: Icon(Icons.face_5), label: "screen3"),
        ],
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
