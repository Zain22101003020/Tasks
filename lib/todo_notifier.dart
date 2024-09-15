import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'db_helper.dart';
import 'todo_model.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await DBHelper.getTodos();
    state = todos;
  }

  Future<void> addTodo(String title) async {
    final todo = Todo(
      id: null,
      title: title,
      isCompleted: false,
    );
    final id = await DBHelper.insertTodo(todo);
    state = [...state, todo.copyWith(id: id)];
  }

  void toggleComplete(int index) {
    final todo = state[index];
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    DBHelper.updateTodo(updatedTodo);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedTodo else state[i],
    ];
  }

  void removeTodoById(int id) {
    DBHelper.deleteTodo(id);
    state = state.where((todo) => todo.id != id).toList();
  }
}
