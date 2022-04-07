import 'package:flutter/material.dart';

class TodoListSelector extends StatelessWidget {
  const TodoListSelector({
    Key? key,
    required this.lists,
    this.currentList,
    this.onChanged,
  }) : super(key: key);

  final List<String> lists;
  final String? currentList;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        items: lists
            .map((list) => DropdownMenuItem(
                  value: list,
                  child: Text(
                    list,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ))
            .toList(),
        value: currentList,
        onChanged: onChanged,
      ),
    );
  }
}
