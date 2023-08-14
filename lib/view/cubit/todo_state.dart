part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {}

class TodoError extends TodoState {}
