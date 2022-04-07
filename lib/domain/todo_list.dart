import 'package:my_first_flutter_app/domain/index.dart';

class TodoList {
  TodoList({
    required this.name,
    required this.todos,
  });

  final String name;
  final List<Todo> todos;
}
