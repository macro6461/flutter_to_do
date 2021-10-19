import 'package:flutter/material.dart';
import './todoitem.dart';
import './todolist.dart';
import 'classes/todo.dart';
import './newtodo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do Homie',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: "It's To Do's My Guy"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key, 
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String content = '';
  String title = '';
  int maxId = 0;
  ToDo? _todo;
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<ToDo> _todos = [];

  @override
  void initState() {
    super.initState();
    titleController.addListener(_handleTitleChange);
    contentController.addListener(_handleContentChange);
  }

  void _handleTitleChange() {
    setState(() {
      title = titleController.text;
    });
  }

  void _handleContentChange() {
    setState(() {
      content = contentController.text;
    });
  }

  void _addTodo(){

    final todo = ToDo ( 
      title: title,
      id: maxId,  
      isDone: false,
      content: content
    );

    if (_todo != null){
      setState(() {
        _todos[_todos.indexOf(_todo!)] = todo;
      });
    } else {
      setState(() {
        _todos.add(todo);
      });
    }

    setState(() {
      content = '';
      maxId = maxId++;
      title = '';
      _todo = null;
    });

    contentController.text = '';
    titleController.text = '';
    
  }

  void _editTodo(ToDo todoitem){
    setState(() {
      _todo = todoitem;
      content = todoitem.content;
      title = todoitem.title;
    });
    contentController.text = todoitem.content;
    titleController.text = todoitem.title;
    _renderShowModal();
  }

  void _deleteToDo(ToDo todoitem){
    setState(() {
      _todos = List.from(_todos)..removeAt(_todos.indexOf(todoitem));
    });
  }

  void _clear(){
    contentController.text = '';
    titleController.text = '';
    setState(() {
      content = '';
      title = '';
      _todo = null;
    });
  }

  _renderShowModal(){
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: titleController,
          builder: (context, _content, child) {
            return NewToDo(titleController, contentController, _addTodo, _clear, _todo);
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( 
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: ToDoList(_todos, _editTodo, _deleteToDo)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _renderShowModal,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}