import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/domain/repository.dart';

class CreateTodoPage extends StatelessWidget {
  const CreateTodoPage({
    Key? key,
    required this.repository,
    required this.todoList,
  }) : super(key: key);

  final TodoRepository repository;
  final String todoList;

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Beschreibung',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    repository.createTodo(
                      list: todoList,
                      name: nameController.text,
                      description: descriptionController.text,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('ANLEGEN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
