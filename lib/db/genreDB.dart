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
    final textType = 'TEXT NOT NULL';
    final idType = 'INTEGER NOT NULL';

    await db.execute(
      '''CREATE TABLE $followedGenres
      (
        ${GenreFields.id} $idType,
        ${GenreFields.name} $textType,
        ${GenreFields.games} $textType
      )'''
    );
  }

  Future<Result> followGenre(Result genre) async{
    final db = await instance.database;

    final id = await db.insert(followedGenres, genre.toJson());
    return genre.copy();
  }

  Future<Result> readFollowed(String name) async{
    final db = await instance.database;
    final maps = await db.query(
      followedGenres,
      columns: GenreFields.values,
        where: '${GenreFields.name} = ?',
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
    final orderBy = '${GenreFields.name} DESC';
    final result = await db.query(followedGenres, orderBy: orderBy);
    return result.map((json)=>Result.fromJson(json)).toList();
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