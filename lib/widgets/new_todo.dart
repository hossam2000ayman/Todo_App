import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewTodo extends StatefulWidget {
  final Function(String) addTodo;

  NewTodo({required this.addTodo});

  @override
  State<StatefulWidget> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[200],
      ),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                labelText: "New Todo",
                prefixIcon: Icon(Icons.bookmark_add),
              ),
              maxLength: 20,
            ),
          ),
          TextButton(
              onPressed: () {
                widget.addTodo(_todoController.text);
                Navigator.of(context).pop();
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
