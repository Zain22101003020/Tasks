import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_notifier.dart';

class AddTodoWidget extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Add a new todo',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            final text = _controller.text;
            if (text.isNotEmpty) {
              ref.read(todoProvider.notifier).addTodo(text);
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
