import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/gameModel.dart';

class FollowedGames
{
  static final FollowedGames instance = FollowedGames.init();
  static Database? _database;
  FollowedGames.init();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('games.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final idType = 'INTEGER NOT NULL AUTOINCREMENT';

    await db.execute(
      '''CREATE TABLE $followedGames
      (
        ${GameFields.name} &textType,
        ${GameFields.backgroundImage} &textType,
        ${GameFields.genres} &textType
        ${GameFields.platforms} &textType,
        ${GameFields.stores} &textType,
      )'''
    );
    await db.execute(
      '''CREATE TABLE $gameGenres
      (
        ${GenreFields.id} &idType,
        ${GenreFields.name} &textType,
      )
      '''
    );
    await db.execute(
      '''CREATE TABLE $gamePlatforms
      (
        ${PlatformFields.id} &idType,
        ${PlatformFields.name} &textType
      )'''
    );
    await db.execute(
      '''CREATE TABLE $gameStores
      (
      ${StoreFields.id} &idType,
      ${StoreFields.name} &textType
      )'''
    );
  }

  Future<Result> createResult(Result game) async {
    final db = await instance.database;

    final id = await db.insert(followedGames, game.toJson());
    return game.copy();
  }

  Future<Result> readResult(String name) async {
    final db = await instance.database;
    final maps = await db.query
      (
      followedGames,
      columns: GameFields.values,
        where: '${GameFields.name} = ?',
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

  Future<List<Result>> readAllResults() async {
    final db = await instance.database;
    final orderBy = '${GameFields.name} DESC';
    final result = await db.query(followedGames, orderBy: orderBy);
    return result.map((json)=> Result.fromJson(json)).toList();
  }

  Future<int> delete(String name) async {
    final db = await instance.database;
    return db.delete
      (
      followedGames,
      where: '${GameFields.name} = ?',
      whereArgs: [name]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}