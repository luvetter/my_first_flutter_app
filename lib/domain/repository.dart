import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:my_first_flutter_app/domain/index.dart';

abstract class TodoRepository {
  void createTodoList(String name);

  Stream<List<String>> streamTodoLists();

  void createTodo({
    required String list,
    required String name,
    required String description,
  });

  void deleteTodo({
    required String list,
    required String uid,
  });

  List<Todo> findTodos(String todoList);

  Stream<List<Todo>> streamTodos(String todoList);
}

class InMemTodoRepository implements TodoRepository {
  final Map<String, TodoList> _todoLists = {};
  final Map<String, StreamController<List<Todo>>> _streams = {};
  final _listStream = StreamController<List<String>>.broadcast();

  InMemTodoRepository() {
    _listStream.onListen = () => _listStream.sink.add(_todoLists.keys.toList());
  }

  @override
  void createTodoList(String name) {
    if (!_todoLists.containsKey(name)) {
      _todoLists[name] = TodoList(uid: name, name: name, todos: []);
      _listStream.sink.add(_todoLists.keys.toList());
    }
  }

  @override
  Stream<List<String>> streamTodoLists() {
    return _listStream.stream;
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
  void deleteTodo({
    required String list,
    required String uid,
  }){
    _todoLists[list]?.todos.removeWhere((todo) => todo.uid == uid);
    _streams[list]?.sink.add(_todoLists[list]!.todos);
  }

  @override
  List<Todo> findTodos(String todoList) {
    return _todoLists[todoList]?.todos ?? [];
  }

  @override
  Stream<List<Todo>> streamTodos(String todoList) {
    if (_todoLists.containsKey(todoList)) {
      _streams.putIfAbsent(todoList, () {
        var streamController = StreamController<List<Todo>>.broadcast();
        streamController.onListen =
            () => streamController.sink.add(_todoLists[todoList]!.todos);
        return streamController;
      });
      return _streams[todoList]!.stream;
    } else {
      return Stream.value([]);
    }
  }
}

class FirestoreTodoRepository implements TodoRepository {
  @override
  void createTodo({required String list,
    required String name,
    required String description}) {
    FirebaseFirestore.instance
        .collection('todo-lists')
        .doc(list)
        .collection('todos')
        .add({
      'name': name,
      'description': description,
    });
  }

  @override
  void deleteTodo({
    required String list,
    required String uid,
  }){
    FirebaseFirestore.instance
        .collection('todo-lists')
        .doc(list)
        .collection('todos')
        .doc(uid).delete();
  }

  @override
  void createTodoList(String name) {
    FirebaseFirestore.instance
        .collection('todo-lists')
        .doc(name)
        .set({'name': name});
  }

  @override
  Stream<List<String>> streamTodoLists() {
    return FirebaseFirestore.instance.collection('todo-lists').snapshots().map(
            (snap) =>
            snap.docs.map((e) => e.data()['name'] as String? ?? e.id).toList());
  }

  @override
  List<Todo> findTodos(String todoList) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Todo>> streamTodos(String uid) {
    return FirebaseFirestore.instance
        .collection('todo-lists')
        .doc(uid)
        .collection('todos')
        .withConverter<Todo>(
      fromFirestore: (snapshot, options) =>
          Todo.fromJson(
            {
              'uid': snapshot.id,
            }
              ..addAll(snapshot.data()!),
          ),
      toFirestore: (todo, options) =>
      {todo.uid: todo.toJson().remove('uid')},
    )
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()).toList());
  }
}
