import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GamesDatabaseHelper {
  static final _dbName = 'games.db';
  static final _dbVersion = 1;

  GamesDatabaseHelper._privateConstructor();

  static final GamesDatabaseHelper instance = GamesDatabaseHelper
      ._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  '''


  Future _onCreate(Database db, int ver) {
    db.query(

    );
  }
}


  '''
}