import '../models/todo.dart';

List<Todo> todoItems = [
  Todo(
    title: 'Study English',
    createdAt: DateTime.now(),
  ),
  Todo(
    title: 'Study Flutter',
    createdAt: DateTime.now().add(const Duration(days: 1)),
  ),
  Todo(
    title: 'Study Clean Architecture',
    createdAt: DateTime.now().add(const Duration(days: 2)),
  ),
];
