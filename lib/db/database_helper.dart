import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _db;

  DatabaseHelper._();

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'expenses.db'),
      version: 1,
      onCreate: (db, _) => db.execute(
        '''CREATE TABLE expenses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          amount REAL NOT NULL,
          category TEXT NOT NULL,
          date TEXT NOT NULL
        )''',
      ),
    );
  }

  Future<int> insert(Expense expense) async {
    final database = await db;
    return database.insert('expenses', expense.toMap()..remove('id'));
  }

  Future<List<Expense>> getAll() async {
    final database = await db;
    final maps = await database.query('expenses', orderBy: 'date DESC');
    return maps.map(Expense.fromMap).toList();
  }

  Future<int> update(Expense expense) async {
    final database = await db;
    return database.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await db;
    return database.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
