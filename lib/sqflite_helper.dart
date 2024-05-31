import 'package:path/path.dart';
import 'package:server_remote_control/classes.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper implements StorageHelper {
  static final SqfliteHelper _instance = SqfliteHelper._internal();
  static Database? _database;

  factory SqfliteHelper() {
    return _instance;
  }

  SqfliteHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE Server (address TEXT, port TEXT)',
        );
        db.execute(
          'CREATE TABLE Command (title TEXT, ServerAdd TEXT, ServerPort TEXT)',
        );
      },
    );
  }

  @override
  Future<void> insertServer(Server s) async {
    final db = await database;
    await db.insert(
      'Server',
      s.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> insertCommand(Command c) async {
    final db = await database;
    await db.insert(
      'Command',
      {
        'title': c.title,
        'ServerAdd': c.serverId.address,
        'ServerPort': c.serverId.port,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Server>> getServers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Server');

    return List.generate(maps.length, (i) {
      return Server(
        address: maps[i]['address'],
        port: maps[i]['port'],
      );
    });
  }

  @override
  Future<List<Command>> getCommands() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Command');

    return List.generate(maps.length, (i) {
      return Command(
        title: maps[i]['title'],
        serverId: Server(
          address: maps[i]['ServerAdd'],
          port: maps[i]['ServerPort'],
        ),
      );
    });
  }
}
