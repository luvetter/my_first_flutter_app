import 'package:my_first_flutter_app/domain/index.dart';

class TodoList {
  const TodoList({
    required this.name,
    this.todos = const [],
  });

  final String name;
  final List<Todo> todos;
}
