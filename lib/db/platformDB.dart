import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/platformModel.dart';

class FollowedPlatforms
{
  static final FollowedPlatforms instance = FollowedPlatforms.init();
  static Database? _database;
  FollowedPlatforms.init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('platforms.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final textType = 'TEXT NOT NULL';
    final idType = 'INTEGER NOT NULL AUTOINCREMENT';

    await db.execute(
      '''CREATE TABLE $followedPlatforms
      (
      ${PlatformFields.id} &idType,
      ${PlatformFields.name} &textType,
      ${PlatformFields.games} &textType
      )'''
    );
  }

  Future<Result> followPlatform(Result platform) async{
    final db = await instance.database;

    final id = await db.insert(followedPlatforms, platform.toJson());
    return platform.copy();
  }

  Future<Result> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
      followedPlatforms,
      columns: PlatformFields.values,
        where: '${PlatformFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return Result.fromJson(maps.first);
    }
    else{
      throw Exception('Platform not found');
    }
  }

  Future<List<Result>> readAllFollowed() async{
    final db  = await instance.database;
    final orderBy = '${PlatformFields.name} DESC';
    final result = await db.query(followedPlatforms, orderBy: orderBy);
    return result.map((json)=>Result.fromJson(json)).toList();
  }

  Future<int> unfollow(String name) async{
    final db = await instance.database;
    return db.delete(
      followedPlatforms,
        where: '${PlatformFields.name} = ?',
        whereArgs:  [name]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}