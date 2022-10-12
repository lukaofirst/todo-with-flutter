// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'todo_list_item.dart';

class TodoList extends StatefulWidget {
  List<Todo> items;

  TodoList({required this.items});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void _toggleIsFinished(Todo item) {
    setState(() {
      var foundedItem =
          widget.items.firstWhere((todo) => todo.title == item.title);

      foundedItem.isFinished = !foundedItem.isFinished;
    });
  }

  void _dismissItem(Todo item) {
    setState(() {
      widget.items.removeWhere((todo) => todo.title == item.title);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item deleted successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      itemBuilder: (_, idx) => TodoListItem(
        key: Key(widget.items[idx].createdAt.toIso8601String()),
        item: widget.items[idx],
        toggleIsFinished: _toggleIsFinished,
        dismissItem: _dismissItem,
      ),
      itemCount: widget.items.length,
    );
  }
}
