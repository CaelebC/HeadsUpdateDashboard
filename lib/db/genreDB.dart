import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hud/models/genreModel.dart';

class FollowedGenres
{
  static final FollowedGenres instance = FollowedGenres.init();
  static Database? _database;
  FollowedGenres.init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('genre.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    await db.execute(
      '''CREATE TABLE $followedGenres
      (
        name TEXT NOT NULL,
        backgroundImage TEXT
      )'''
    );
  }

  Future<Result> followGenre(Result genre) async{
    final db = await instance.database;
    final json = genre.toJson();

    final columns =
        '${GenreFields.name}, ${GenreFields.backgroundImage}';
    final values =
        [json[GenreFields.name], json[genre.backgroundImage]];
    final id = await db.rawInsert('INSERT INTO $followedGenres($columns) VALUES'
        '(?, ?)', values);
    return genre.copy();
  }

  Future<GenreOutput> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
      followedGenres,
      columns: GenreFields.values,
        where: '${GenreFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return GenreOutput.fromJson(maps.first);
    }
    else{
      throw Exception('Genre not found');
    }
  }

  Future<List<GenreOutput>> readAllFollowed() async{
    final db = await instance.database;
    final orderBy = '${GenreFields.name} DESC';
    final result = await db.query(followedGenres, orderBy: orderBy);
    return result.map((json)=>GenreOutput.fromJson(json)).toList();
  }

  Future<int> unfollow(String name) async{
    final db = await instance.database;
    return db.delete(
      followedGenres,
        where: '${GenreFields.name} = ?',
        whereArgs: [name]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}