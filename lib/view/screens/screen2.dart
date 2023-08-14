import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab2/models/user_model.dart';
import 'package:flutter_lab2/service/todo_service.dart';
import 'package:flutter_lab2/view/cubit/todo_cubit.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is TodoError){
              return Center(
              child: Text("Error"),
            );
          }
          return ListView.builder(
            itemCount: (context).watch<TodoCubit>().todo.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text((context).watch<TodoCubit>().todo[index].title ?? "--"),
                  trailing: Text((context).watch<TodoCubit>().todo[index].completed.toString()));
            });
        },
      ),
    );
  }
}
