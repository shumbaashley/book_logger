import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:book_logger/models/book.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  String bookTable = 'book_table';
  String id = 'id';
  String title = 'title';
  String author = 'author';
  String status = 'status';
  String dateAdded = 'status';

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'books.db';

    var booksDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return booksDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $bookTable($id INTEGER PRIMARY KEY AUTO INCREMENT, $title TEXT, $author TEXT, $status INTEGER, $dateAdded TEXT)');
  }

  // Get all book objects from db

  Future<List<Map<String, dynamic>>> getBookMapList() async {
    Database db = await this.database;

    // var result = await db.rawQuery('SELECT * FROM  $bookTable ORDER BY $status ASC')
    var result = await db.query(bookTable, orderBy: '$status ASC');
    return result;
  }
  // Insert book into db

  Future<int> insertBook(Book book) async {
    Database db = await this.database;
    var result = await db.insert(bookTable, book.toMap());
    return result;
  }

  // Get single book from db

  Future<int> updateBook(Book book) async {
    Database db = await this.database;
    var result = await db.update(bookTable, book.toMap(),
        where: '$id = ?', whereArgs: [book.id]);
    return result;
  }

  // Delete single book from db

  Future<int> deleteBook(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $bookTable WHERE $id = id');
    return result;
  }

  // Get count of books from db

  Future<int> getCount(int id) async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $bookTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
