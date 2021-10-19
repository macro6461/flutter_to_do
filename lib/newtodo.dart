import 'package:flutter/material.dart';
import './classes/todo.dart';

class NewToDo extends StatelessWidget {

  final Function _addTodo;
  final Function _clear;
  final ToDo? _todo;
  final TextEditingController titleController;
  final TextEditingController contentController;

  const NewToDo(this.titleController, this.contentController, this._addTodo, this._clear, this._todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleController,
                    autofocus: true,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Details',
                    ),
                    controller: contentController,
                    autofocus: true,
                  ),
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: titleController.text.isNotEmpty ? () => _addTodo() : null, 
                          child: Text((_todo != null && titleController.text.isNotEmpty) ? 'Edit To Do' : 'Add To Do'),
                          style: ButtonStyle(
                            backgroundColor: titleController.text.isNotEmpty ? MaterialStateProperty.all<Color>(Colors.deepPurple) : null,
                            overlayColor: MaterialStateProperty.all<Color>(Colors.purple), 
                          ),
                        ),
                        Visibility (
                          visible: titleController.text.isNotEmpty || contentController.text.isNotEmpty,
                          child: ElevatedButton(
                            onPressed: () => _clear(), 
                            child: const Text('Clear'),
                          )),
                  ])
                ],
              );
  }
}