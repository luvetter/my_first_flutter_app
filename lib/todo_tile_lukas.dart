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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          todo.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          todo.description,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
