import 'package:flutter_lab2/models/user_model.dart';
import 'package:dio/dio.dart';

class TodoService {
  var url = "https://jsonplaceholder.typicode.com/todos";
  List<TodoModel> todoList = [];
  Future<List<TodoModel>> getTodoService() async {
    final response = await Dio().get(url);

    var data = response.data;
    data.forEach((user) {
      todoList.add(TodoModel.fromJson(user));
    });
    return todoList;
  }
}
