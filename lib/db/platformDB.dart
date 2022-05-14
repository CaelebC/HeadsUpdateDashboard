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
    await db.execute(
      '''CREATE TABLE $followedPlatforms
      (
        name TEXT NOT NULL,
        backgroundImage TEXT
      )'''
    );
  }

  Future<Result> followPlatform(Result platform) async{
    final db = await instance.database;
    final json = platform.toJson();

    final columns =
        '${PlatformFields.name}, ${PlatformFields.backgroundImage}';
    final values =
    [json[PlatformFields.name], json[platform.backgroundImage]];
    final id = await db.rawInsert('INSERT INTO $followedPlatforms($columns) VALUES'
        '(?, ?)', values);
    return platform.copy();
  }

  Future<PlatformOutput> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
      followedPlatforms,
      columns: PlatformFields.values,
        where: '${PlatformFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return PlatformOutput.fromJson(maps.first);
    }
    else{
      throw Exception('Platform not found');
    }
  }

  Future<List<PlatformOutput>> readAllFollowed() async{
    final db  = await instance.database;
    final orderBy = '${PlatformFields.name} DESC';
    final result = await db.query(followedPlatforms, orderBy: orderBy);
    return result.map((json)=>PlatformOutput.fromJson(json)).toList();
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