import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/gameDBModel.dart'; // connects to this model.dart

class GamesDatabase
{
  static final GamesDatabase instance = GamesDatabase.init();

  static Database? _database;

  GamesDatabase.init();

  Future<Database> get database async
  {
    if (_database != null) return _database!;

    _database = await _initDB('games.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async
  {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async
  {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute(
        '''CREATE TABLE $followedGames
        (
            ${gameFields.id} &idType,
            ${gameFields.title} &textType,
            ${gameFields.developer} &textType,
            ${gameFields.publisher} &textType,
            ${gameFields.description} &textType,
            ${gameFields.ReleaseDate} &textType,
        )''');
  }

  Future<gameDBModel> create(gameDBModel game) async
  {
    final db = await instance.database;

    //final json = game.toJson();

    //final columns =
    //    '${gameFields.id},'
    //    '${gameFields.title},'
    //    '${gameFields.developer},'
    //    '${gameFields.publisher},'
    //    '${gameFields.description},'
    //    '${gameFields.ReleaseDate}';
    //final values =
    //    '${json[gameFields.id]},'
    //    '${json[gameFields.title]},'
    //    '${json[gameFields.developer]},'
    //    '${json[gameFields.publisher]},'
    //    '${json[gameFields.description]},'
    //    '${json[gameFields.ReleaseDate]},';

    //final id = await db
    //  .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(followedGames, game.toJson());
    return game.copy(id: id);
  }

  Future<gameDBModel> readgameDBModel(int id) async //get one game
    {
    final db = await instance.database;

    final maps = await db.query
      (
      followedGames,
      columns: gameFields.values,
      where: '${gameFields.id} = ?',
      whereArgs: [id], //args for line above
    );

    if (maps.isNotEmpty)
      {
        return gameDBModel.fromJson(maps.first);
      }
    else
      {
        throw Exception('ID $id not found');
      }
  }

  Future<List<gameDBModel>> readAllGames() async //get list of all games
  {
    final db = await instance.database;
    final orderBy = '${gameFields.title} ASC'; //ascending order by title
    final result = await db.query(followedGames, orderBy: orderBy);
    return result.map((json) => gameDBModel.fromJson(json)).toList();
  }

  Future<int> update(gameDBModel game) async //update DB entry
  {
    final db = await instance.database;

    return db.update(
      followedGames,
      game.toJson(),
      where: '${gameFields.id} = ?',
      whereArgs: [game.id]
    );
  }

  Future<int> delete(int id) async  //delete DB entry given ID
  {
    final db = await instance.database;

    return db.delete(
        followedGames,
        where: '${gameFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async //close DB
  {
    final db = await instance.database;
    db.close();
  }
}