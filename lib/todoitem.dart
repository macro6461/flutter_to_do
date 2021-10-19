import 'package:flutter/material.dart';
import './classes/todo.dart';

class ToDoItem extends StatelessWidget {

  final ToDo item;
  final Function _deleteToDo;
  final Function _editTodo;

  const ToDoItem(this.item, this._editTodo, this._deleteToDo, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
                  title: Text(item.title),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.content,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _editTodo(item),
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () => _deleteToDo(item),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
        ]
      )
    );
  }
}
