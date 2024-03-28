import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/todo_model.dart';

class DatabaseHelper {
  late Database _database;
  bool _isDatabaseInitialized = false;

  Future<void> initializeDatabase() async {
    if (!_isDatabaseInitialized) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'todos_database.db'),
        onCreate: (db, version) {
          _createTables(db);
        },
        version: 1,
      );
      _isDatabaseInitialized = true;
    }
  }

  void _createTables(Database db) {
    db.execute(
      'CREATE TABLE todositems(id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT)',
    );

    db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, password TEXT)',
    );
  }

  Future<void> insertTodo(Todo todo) async {
    await initializeDatabase();
    final localDB = await _database;
    await localDB.insert(
      'todositems',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> getAllTodos() async {
    await initializeDatabase();
    final localDB = await _database;
    final List<Map<String, dynamic>> maps = await localDB.query('todositems');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await initializeDatabase();
    final localDB = await _database;
    await localDB.update(
      'todositems',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    await initializeDatabase();
    final localDB = await _database;
    await localDB.delete(
      'todositems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertUsers(String email, String password) async {
    await initializeDatabase();
    final localDB = await _database;

    await localDB.insert(
      'users',
      {'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    await initializeDatabase();
    final localDB = await _database;
    List<Map<String, dynamic>> users = await localDB.query(
      'users',
      where: 'email = ? And password =?',
      whereArgs: [email, password],
      limit: 1,
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
}
