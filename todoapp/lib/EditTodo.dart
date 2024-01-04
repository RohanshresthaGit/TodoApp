import 'package:flutter/material.dart';
import 'package:todoapp/model.dart';

class EditTodo extends StatefulWidget {
  VoidCallback saveTodo;
  Model todo;
  EditTodo({required this.saveTodo, required this.todo, super.key});

  @override
  State<EditTodo> createState() =>
      _EditTodoState(todo: todo, saveTodo: saveTodo);
}

class _EditTodoState extends State<EditTodo> {
  Model todo;
  VoidCallback saveTodo;

  _EditTodoState({required this.saveTodo, required this.todo});
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (todo != null) {
      controllerTitle.text = todo.title!;
      controllerDescription.text = todo.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Your Todo's"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21), color: Colors.white60),
          height: 500,
          width: 350,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    todo.title = value;
                  },
                  decoration: InputDecoration(
                      label: const Text("Enter the title"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                  controller: controllerTitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    todo.description = value;
                  },
                  decoration: InputDecoration(
                      label: const Text("Enter the description"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                  controller: controllerDescription,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(children: [
                          Icon(
                            Icons.cancel_outlined,
                          ),
                          SizedBox(width: 5),
                          Text("Cancel")
                        ])),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context, todo);
                          });
                        },
                        child: const Row(children: [
                          Icon(
                            Icons.save,
                          ),
                          SizedBox(width: 5),
                          Text("Save")
                        ])),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
