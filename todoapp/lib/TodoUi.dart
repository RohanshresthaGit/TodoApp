import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/AddTodo.dart';
import 'package:todoapp/EditTodo.dart';
import 'package:todoapp/model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    super.key,
    required String title,
  });

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late SharedPreferences prefs;
  List todos = [];
  setUpTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString("todo");
    List todoList = jsonDecode(stringTodo!);
    for (var todo in todoList) {
      setState(() {
        todos.add(Model().userModel(todo));
      });
    }
  }

  void saveTodo() {
    List items = todos.map((e) => e.toMap()).toList();
    prefs.setString("todo", jsonEncode(items));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setUpTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.transparent,
        title: const Text(
          "ToDo",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: todos.length == 0
          ? const Center(
              child: Text(
                "No Todo's",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    removeTodo(index);
                                    saveTodo();
                                  },
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(21),
                                  icon: Icons.delete,
                                  label: "Delete",
                                )
                              ]),
                          child: InkWell(
                            onTap: () async {
                              Model t = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTodo(
                                            saveTodo: saveTodo,
                                            todo: todos[index],
                                          )));
                              if (t != null) {
                                todos[index] = t;
                              }
                              saveTodo();
                              setState(() {});
                            },
                            child: Card(
                                elevation: 3,
                                color: Colors.white60,
                                child: TodoTIle(todos[index], index)),
                          ),
                        ),
                      );
                    }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Model t = await showDialog(
              context: context,
              builder: (context) => AddTodo(todos: todos, saveTodo: saveTodo));
          if (t != null) {
            todos.add(t);
          }
          saveTodo();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget TodoTIle(Model todos, index) {
    return SizedBox(
      height: 75,
      width: 400,
      child: ListTile(
        leading: Checkbox(
          value: todos.status,
          onChanged: (newIsChecked) {
            todos.status = newIsChecked!;
            setState(() {});
          },
          activeColor: Colors.black,
        ),
        title: Text(
          todos.title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              decoration: todos.status!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        subtitle: Text(todos.description!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: todos.status!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: Colors.black,
            )),
      ),
    );
  }

  removeTodo(index) {
    todos.removeAt(index);
    setState(() {});
  }
}
