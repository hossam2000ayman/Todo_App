import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/counter.dart';
import 'package:todoapp/widgets/new_todo.dart';
import 'package:uuid/uuid.dart';
import 'package:todoapp/widgets/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> todos = [
    Todo(id: Uuid(), title: "Clean Room", completed: false),
    Todo(id: Uuid(), title: "Pet the Cat", completed: false),
    Todo(id: Uuid(), title: "Dance", completed: true)
  ];

  void _updateTodoCompletions(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTodo(addTodo: _addTodo);
        },
        isScrollControlled: true);
  }

  void _addTodo(String todo) {
    setState(() {
      todos.add(Todo(id: Uuid(), completed: false, title: todo));
    });
  }

  int _calcTotalCompletions() {
    var totalCompletions = 0;

    todos.forEach((todo) {
      if (todo.completed) {
        totalCompletions++;
      }
    });

    return totalCompletions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo_App',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.orange[100],
        centerTitle: true,
      ),
      backgroundColor: Colors.orange[200],
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Counter(
              
              numberOfTodos: todos.length,
              totalCompletions: _calcTotalCompletions(),
            ),
            TodoList(
                todos: todos, updateTodoCompletions: _updateTodoCompletions)
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoModal(context);
        },
        child: Icon(Icons.add, color: Colors.grey[900],size: 37,),
        backgroundColor: Colors.orange[100],
        hoverColor: Colors.orange[200],
        splashColor: Colors.orange[500],
      ),
    );
  }
}
