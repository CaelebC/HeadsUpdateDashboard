import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/gameModel.dart';

class FollowedGames
{
  static final FollowedGames instance = FollowedGames.init();
  static Database? _database;
  FollowedGames.init();

  Future<Database> get database async
  {
    if(_database != null) return _database!;
    _database = await _initDB('games.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async
  {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async //
  {
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    //need Type for lists, unsure
    await db.execute(//ff is SQL statements
      '''CREATE TABLE $followedGames
      (
        ${gameFields.slug} &textType,
        ${gameFields.name} &textType,
        ${gameFields.platforms} &textType,      //change to list type
        ${gameFields.stores} &textType,         //change to list type
        ${gameFields.released} &textType,
        ${gameFields.tba} &boolType,
        ${gameFields.backgroundImage} &textType,
        ${gameFields.rating} &doubleType,
        ${gameFields.parentPlatforms} &textType, //change to list type
        ${gameFields.genres} &textType,          //change to list type
      )'''
    );
  }

  Future<Result> createResult(Result game) async
  {
    final db = await instance.database;

    final id = await db.insert(followedGames, game.toJson());
    return game.copy();
  }

  Future<Result> readResult(String name) async
  {
    final db = await instance.database;
    final maps = await db.query
      (
      followedGames,
      columns: gameFields.values,
        where: '${gameFields.name} = ?',
        whereArgs: [name],
    );

    if(maps.isNotEmpty)
      {
        return Result.fromJson(maps.first);
      }
    else
      {
        throw Exception('Title not found');
      }
  }

  Future<List<Result>> readAllResults() async
  {
    final db = await instance.database;
    final orderBy = '${gameFields.name} DESC';
    final result = await db.query(followedGames, orderBy: orderBy);
    return result.map((json)=> Result.fromJson(json)).toList();
  }

  Future<int> delete(String name) async
  {
    final db = await instance.database;
    return db.delete
      (
      followedGames,
      where: '${gameFields.name} = ?',
      whereArgs: [name]
    );
  }

  Future close() async
  {
    final db = await instance.database;
    db.close();
  }
}