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

  // Get all books from db
  // Insert book into db
  // Get single book from db
  // Delete single book from db
  // Get books from db
}
