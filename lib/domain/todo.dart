
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  const Todo({
    required this.uid,
    // required this.assigned,
    required this.name,
    required this.description,
  });

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);

  final String uid;
  // final User? assigned;
  final String name;
  final String description;

  Map<String, Object?> toJson() => _$TodoToJson(this);
}
