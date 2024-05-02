import 'package:mytodolist/models/tache.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath(); // chemin vers notre bd
    const dbname = "tache.db"; // nom de la bd
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tache(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isImportant INTEGER,
        isCompleted INTEGER,
        description TEXT,
        echeance TEXT,
        streetnumber INTEGER,
        street TEXT,
        city TEXT,
        codePostal INTEGER
      )

    ''');
  }

  Future<void> insertTache(Tache tache) async {
    final db = await database;
    db.insert('tache', tache.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTache(Tache tache) async {
    final db = await database;
    db.delete('tache', where: 'id == ?', whereArgs: [tache.id]);
  }

  Future<void> updateTache(Tache tache) async {
    final db = await database;
    db.update('tache', tache.toMap(), where: 'id == ?', whereArgs: [tache.id]);
  }

  Future<Tache> getTacheById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('tache', where: "id = ?", whereArgs: [id]);
    List<Tache> list = List.generate(
        items.length,
        (index) => Tache(
            id: items[index]['id'],
            title: items[index]['title'],
            isImportant: items[index]['isImportant'] == 1 ? true : false,
            isCompleted: items[index]['isCompleted'] == 1 ? true : false,
            description: items[index]['description'],
            street: items[index]['street'],
            streetnumber: items[index]['streetnumber'],
            city: items[index]['city'],
            echeance: items[index]['echeance'], //items[index]['echeance'],
            codePostal: items[index]['codePostal']));
    return list.first;
  }

  Future<List<Tache>> getTache() async {
    final db = await database;

    List<Map<String, dynamic>> items =
        await db.query('tache', orderBy: 'id DESC');
    return List.generate(
        items.length,
        (index) => Tache(
            id: items[index]['id'],
            title: items[index]['title'],
            isImportant: items[index]['isImportant'] == 1 ? true : false,
            isCompleted: items[index]['isCompleted'] == 1 ? true : false,
            description: items[index]['description'],
            street: items[index]['street'],
            streetnumber: items[index]['streetnumber'],
            city: items[index]['city'],
            echeance: items[index]['echeance'], //items[index]['echeance'],
            codePostal: items[index]['codePostal']));
  }
}
