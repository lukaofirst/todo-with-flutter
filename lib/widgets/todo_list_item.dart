import 'package:flutter/material.dart';
import 'package:todo_with_flutter/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Function dismissItem;
  final Function toggleIsFinished;
  final Todo item;

  const TodoListItem({
    super.key,
    required this.item,
    required this.toggleIsFinished,
    required this.dismissItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            )
          ],
        ),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => dismissItem(item),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: item.isFinished
              ? Icon(
                  Icons.circle,
                  color: Theme.of(context).primaryColor,
                )
              : const Icon(
                  Icons.circle_outlined,
                ),
          title: Text(item.title),
          onTap: () => toggleIsFinished(item),
        ),
      ),
    );
  }
}
