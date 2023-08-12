import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_lab2/models/user_model.dart';
import 'package:flutter_lab2/service/todo_service.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<TodoModel> todo = [];
  bool isLoding = true;
  getTodo() async {
    todo = await TodoService().getTodoService();
    setState(() {});
    isLoding = false;
  }

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return isLoding == true?
    Center(child: CircularProgressIndicator(),)
    :ListView.builder(
        itemCount: todo.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: Text("${index + 1}"),
              title: Text(todo[index].title ?? "--"),
              trailing: Text(todo[index].completed.toString()));
        });
  }
}
