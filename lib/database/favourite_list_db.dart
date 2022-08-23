import 'package:path/path.dart';
import 'package:pokedex/database/model/favourites.dart';
import 'package:sqflite/sqflite.dart';

class FavouriteListDb {
  static final FavouriteListDb instance = FavouriteListDb._init();
  static const String TABLE_NAME = 'favourite_list';

  static Database? _database;
  FavouriteListDb._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase('favourites.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  // db schema
  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
  CREATE TABLE $tableFavourites (
    ${FavouritesFieldNames.id} $idType,
    ${FavouritesFieldNames.nickname} $textType,
    ${FavouritesFieldNames.num} $textType,
    ${FavouritesFieldNames.name} $textType,
    ${FavouritesFieldNames.img} $textType,
  )
  ''');
  }

  // create
  Future<Favourite> create(Favourite favourite) async {
    final db = await instance.database;
    final id = await db.insert(tableFavourites, favourite.toJson());

    return favourite.copyWith(id: id);
  }

  // read
  Future<List<Favourite>> readFavourites() async {
    final db = await instance.database;
    final favourites = await db.query(tableFavourites,
        orderBy: '${FavouritesFieldNames.num} ASC');
    return favourites
        .map((favourite) => Favourite.fromJson(favourite))
        .toList();
  }

  // update
  Future<int> updateFavourites(Favourite favourite) async {
    final db = await instance.database;
    return await db.update(tableFavourites, favourite.toJson(),
        where: '${FavouritesFieldNames.id} = ?', whereArgs: [favourite.id]);
  }

  // delete
  Future<int> deleteFavorite(int id) async {
    final db = await instance.database;
    return await db.delete(tableFavourites,
        where: '${FavouritesFieldNames.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
