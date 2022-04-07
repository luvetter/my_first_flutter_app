import 'dart:async';

import 'package:faker/faker.dart';
import 'package:my_first_flutter_app/domain/index.dart';

abstract class TodoRepository {
  void createTodoList(String name);
  void createTodo({
    required String list,
    required String name,
    required String description,
  });
  List<Todo> findTodos(String todoList);
  Stream<List<Todo>> streamTodos(String todoList);
}

class InMemTodoRepository implements TodoRepository {
  final Map<String, TodoList> _todoLists = {};
  final Map<String, StreamController<List<Todo>>> _streams = {};

  @override
  void createTodoList(String name) {
    if (!_todoLists.containsKey(name)) {
      _todoLists[name] = TodoList(name: name, todos: []);
    }
  }

  @override
  void createTodo({
    required String list,
    required String name,
    required String description,
  }) {
    _todoLists[list]?.todos.add(Todo(
      uid: random.string(24),
      name: name,
      description: description,
    ));
    _streams[list]?.sink.add(_todoLists[list]!.todos);
  }

  @override
  List<Todo> findTodos(String todoList) {
    return _todoLists[todoList]?.todos ?? [];
  }

  @override
  Stream<List<Todo>> streamTodos(String todoList) {
    if (_todoLists.containsKey(todoList)) {
      _streams.putIfAbsent(todoList, () => StreamController.broadcast());
      return _streams[todoList]!.stream;
    } else {
      return Stream.value([]);
    }
  }
}
