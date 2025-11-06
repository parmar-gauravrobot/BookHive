import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/book.dart';

class DbService {
  static const _dbName = 'bookhive.db';
  static const _dbVersion = 1;
  static const tableBooks = 'books';

  static final DbService instance = DbService._internal();
  Database? _db;

  DbService._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, _dbName);
    return openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableBooks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            author TEXT NOT NULL,
            coverImagePath TEXT,
            status TEXT NOT NULL,
            progressPercent INTEGER NOT NULL,
            isFavorite INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Book>> getAllBooks() async {
    final db = await database;
    final rows = await db.query(tableBooks, orderBy: 'id DESC');
    return rows.map((e) => Book.fromMap(e)).toList();
  }

  Future<List<Book>> searchBooks(String query) async {
    final db = await database;
    final rows = await db.query(
      tableBooks,
      where: 'title LIKE ? OR author LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return rows.map((e) => Book.fromMap(e)).toList();
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    return db.insert(tableBooks, book.toMap());
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    if (book.id == null) return 0;
    return db.update(
      tableBooks,
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    return db.delete(tableBooks, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> getByStatus(String status) async {
    final db = await database;
    final rows = await db.query(tableBooks, where: 'status = ?', whereArgs: [status], orderBy: 'id DESC');
    return rows.map((e) => Book.fromMap(e)).toList();
  }

  Future<List<Book>> getFavorites() async {
    final db = await database;
    final rows = await db.query(tableBooks, where: 'isFavorite = 1', orderBy: 'id DESC');
    return rows.map((e) => Book.fromMap(e)).toList();
  }
}


