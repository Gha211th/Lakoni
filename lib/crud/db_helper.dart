import 'package:my_app/crud/db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, date TEXT, desc TEXT, is_done INTEGER)',
        );
      },
      onUpgrade: (db, version, newVersion) async {
        await db.execute(
          'ALTER TABLE todos ADD COLUMN is_done INTEGER DEFAULT O',
        );
      },
    );
  }

  // CRUD BASIC

  // FITUR CREATE (C)
  Future<void> create(Map<String, dynamic> row) async {
    final db = await instance.database;
    await db.insert('todos', row);
  }

  // FITUR READ (R)
  Future<List<Todo>> read() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> mapping = await db.query('todos');

    return List.generate(mapping.length, (i) => Todo.fromMap(mapping[i]));
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query('todos', orderBy: 'id DESC');
  }

  // FITUR UPDATE (U)
  Future<void> update(Todo todo) async {
    final db = await instance.database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // FITUR DELETE (D)
  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateStatus(int id, int status) async {
    final db = await instance.database;
    await db.update(
      'todos',
      {'is_done': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
