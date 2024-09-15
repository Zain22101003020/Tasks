import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo_model.dart';

class DBHelper {
  static Future<Database> _database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isCompleted INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<int> insertTodo(Todo todo) async {
    final db = await _database();
    return await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Todo>> getTodos() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await _database();
    await db.update(
      'todos',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  static Future<void> deleteTodo(int id) async {
    final db = await _database();
    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
