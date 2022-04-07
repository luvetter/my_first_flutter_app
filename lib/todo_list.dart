import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_first_flutter_app/domain/repository.dart';
import 'package:my_first_flutter_app/todo_tile.dart';

import 'domain/index.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    Key? key,
    required this.repository,
    required this.todoList,
  }) : super(key: key);

  final TodoRepository repository;
  final String todoList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: repository.streamTodos(todoList),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!
                .map((todo) => Dismissible(
                      key: ValueKey(todo.uid),
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) =>
                          repository.deleteTodo(list: todoList, uid: todo.uid),
                      child: TodoTile(todo: todo),
                    ))
                .toList(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
