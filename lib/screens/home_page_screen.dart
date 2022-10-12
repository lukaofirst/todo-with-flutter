// ignore_for_file: use_key_in_widget_constructors, void_checks

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../utils/data.dart';
import '../widgets/todo_list.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _todoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String errorMessage = 'Please fill in a message';
  String errorMessage2 = 'a';
  bool enableBtn = false;
  List<Todo> items = [...todoItems];

  @override
  void initState() {
    super.initState();

    _todoController.addListener(() {
      if (_todoController.text.isEmpty) {
        setState(() {
          enableBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _addTodo() {
    final FormState form = _formKey.currentState!;

    if (form.validate()) {
      var newTodo = Todo(
        title: _todoController.text,
        createdAt: DateTime.now(),
      );

      setState(() {
        items.add(newTodo);
        _todoController.clear();
      });

      Navigator.of(context).pop();
    }
  }

  void _openModalBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (_) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add a to-do',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Title'),
                        errorStyle: TextStyle(fontSize: 14)),
                    controller: _todoController,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) => value!.isEmpty ? errorMessage : null,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: enableBtn ? _addTodo : null,
                      child: const Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo with Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
            onRefresh: () {
              setState(() {
                items = todoItems;
              });
              return Future.value(true);
            },
            child: TodoList(items: items)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModalBottomSheet,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
