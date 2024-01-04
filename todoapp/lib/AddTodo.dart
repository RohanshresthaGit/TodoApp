import 'package:flutter/material.dart';
import 'package:todoapp/model.dart';

class AddTodo extends StatefulWidget {
  List todos;
  VoidCallback saveTodo;
  AddTodo({super.key, required this.saveTodo, required this.todos});

  @override
  State<AddTodo> createState() => _AddTodoState(todos, saveTodo);
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List todos;
  VoidCallback saveTodo;
  _AddTodoState(this.todos, this.saveTodo);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text("Enter the Title")),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text("Enter the Description")),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const SizedBox(
                      width: 75,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        Model t = Model(
                            title: titleController.text,
                            description: descriptionController.text,
                            status: false);
                        Navigator.pop(context, t);
                      });
                    },
                    child: const SizedBox(
                      width: 60,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Save",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
