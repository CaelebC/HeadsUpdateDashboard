import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/gameModel.dart';

class FollowedGames
{
  static final FollowedGames instance = FollowedGames._init();

  static Database? _database;

  FollowedGames._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('games.db');
    //print('running database');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //print('initializing database');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    print('database created');
    await db.execute('''
    CREATE TABLE $followedGames
      (
        name TEXT NOT NULL, 
        backgroundImage TEXT, 
        genres TEXT, 
        platforms TEXT, 
        stores TEXT
      )'''
    );
  }

  //Create Functions
  Future<Result> createResult(Result game) async {
    final db = await instance.database;
    final json = game.toJson();
    String allGenres = "";
    String allPlatforms = "";
    String allStores = "";

    //converting to string
    for(var i in game.genres) {
      allGenres = allGenres + i.name;
    }
    for(var i in game.platforms) {
      allPlatforms = allPlatforms + i.platform.name;
    }
    for(var i in game.stores!) {
      allStores = allStores + i.store.name;
    }

    //DOUBLE CHECK VALUES; NOT ENTIRELY CLEAR ON THAT YET
    final columns =
        '${GameFields.name}, ${GameFields.backgroundImage}, '
        '${GameFields.genres}, ${GameFields.platforms}, ${GameFields.stores}';
    final values =
        [json[GameFields.name], json[game.backgroundImage],
        allGenres, allPlatforms, allStores];
    //print(followedGames);
    //print(columns);
    //print(values);
    final id = await db.rawInsert('INSERT INTO $followedGames($columns) VALUES'
        '(?, ?, ?, ?, ?)', values);
    //print(id);
    //print('Game followed');
    return game.copy();
  }

  Future<GameOutput> readResult(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      followedGames,
      columns: GameFields.values,
      where: '${GameFields.name} = ?',
      whereArgs: [name],
    );
    print('Looking for game');
    if(maps.isNotEmpty){
        return GameOutput.fromJson(maps.first);
      }
    else{
        throw Exception('Title $name not found');
      }
  }

  Future<bool> checkForResult(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      followedGames,
      columns: GameFields.values,
      where: '${GameFields.name} = ?',
      whereArgs: [name],
    );
    if(maps.isNotEmpty){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }

  Future<List<GameOutput>> readAllResults() async {
    final db = await instance.database;
    final orderBy = '${GameFields.name} DESC';
    final result = await db.query(followedGames, orderBy: orderBy);
    return result.map((json)=> GameOutput.fromJson(json)).toList();
  }

  Future<int> delete(String name) async {
    final db = await instance.database;
    return db.delete(
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