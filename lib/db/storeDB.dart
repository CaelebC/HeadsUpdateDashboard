import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/storeModel.dart';

class FollowedStores
{
  static final FollowedStores instance = FollowedStores.init();
  static Database? _database;
  FollowedStores.init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('store.db');
    return _database!;
  }

  Future <Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final textType = 'TEXT NOT NULL';
    final idType = 'INTEGER NOT NULL AUTOINCREMENT';

    await db.execute(
      '''CREATE TABLE $followedStores
      (
        name TEXT NOT NULL,
        backgroundImage TEXT
      )'''
    );
  }

  Future<Result> followStore(Result store) async{
    final db = await instance.database;

    final json = store.toJson();

    final columns =
        '${StoreFields.name}, ${StoreFields.backgroundImage}';
    final values =
    [json[StoreFields.name], json[store.backgroundImage]];
    final id = await db.rawInsert('INSERT INTO $followedStores($columns) VALUES'
        '(?, ?)', values);
    return store.copy();
  }

  Future<StoreOutput> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
        followedStores,
        columns: StoreFields.values,
        where: '${StoreFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return StoreOutput.fromJson(maps.first);
    }
    else{
      throw Exception('Genre not found');
    }
  }

  Future<List<StoreOutput>> readAllFollowed() async{
    final db = await instance.database;
    final orderBy = '${StoreFields.name} DESC';
    final result = await db.query(followedStores, orderBy: orderBy);
    return result.map((json)=>StoreOutput.fromJson(json)).toList();
  }

  Future<int> unfollow(String name) async{
    final db = await instance.database;
    return db.delete(
        followedStores,
        where: '${StoreFields.name} = ?',
        whereArgs: [name]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}