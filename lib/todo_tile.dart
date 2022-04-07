import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/domain/index.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            todo.description,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Theme.of(context).textTheme.caption?.color,
            ),
          ),
        ],
      ),
    );
  }
}
