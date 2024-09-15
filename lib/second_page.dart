import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_notifier.dart';

class SecondPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App - Second Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
          ),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return Card(
              child: ListTile(
                title: Text(todo.title),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) {
                    ref.read(todoProvider.notifier).toggleComplete(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
