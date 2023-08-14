import 'package:bloc/bloc.dart';
import 'package:flutter_lab2/models/user_model.dart';
import 'package:flutter_lab2/service/todo_service.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    getTodo();
  }

  List<TodoModel> todo = [];

  getTodo() async {
    try {
      emit(TodoLoading());
      todo = await TodoService().getTodoService();
      emit(TodoSuccess());
    } catch (e) {
      emit(TodoError());
    }
  }
}
