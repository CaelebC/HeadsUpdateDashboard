import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/publisherModel.dart';

class FollowedPublishers
{
  static final FollowedPublishers instance = FollowedPublishers.init();
  static Database? _database;
  FollowedPublishers.init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('publisher.db');
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
      '''CREATE TABLE $followedPublishers
      (
        ${PublisherFields.id} &idType,
        ${PublisherFields.name} &idType,
        ${PublisherFields.games} &textType
      )'''
    );
  }

  Future<Result> followPublisher(Result publisher) async{
    final db = await instance.database;

    final id = await db.insert(followedPublishers, publisher.toJson());
    return publisher.copy();
  }

  Future<Result> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
      followedPublishers,
      columns: PublisherFields.values,
        where: '${PublisherFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return Result.fromJson(maps.first);
    }
    else{
      throw Exception('Genre not found');
    }
  }

  Future<List<Result>> readAllFollowed() async{
    final db = await instance.database;
    final orderBy = '${PublisherFields.name} DESC';
    final result = await db.query(followedPublishers, orderBy: orderBy);
    return result.map((json)=>Result.fromJson(json)).toList();
  }

  Future<int> unfollow(String name) async{
    final db = await instance.database;
    return db.delete(
        followedPublishers,
        where: '${PublisherFields.name} = ?',
        whereArgs: [name]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}