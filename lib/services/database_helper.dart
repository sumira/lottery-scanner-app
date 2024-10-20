import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'tickets.db');
    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tickets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            date TEXT,
            draw_no TEXT,
            numbers TEXT,
            double_chance TEXT,
            file TEXT,
            type TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertTicket(Map<String, dynamic> ticket) async {
    final db = await database;
    return await db.insert('tickets', ticket);
  }

  Future<List<Map<String, dynamic>>> getTicketsByUsername(
      String username) async {
    final db = await database;
    return await db
        .query('tickets', where: 'username = ?', whereArgs: [username]);
  }

  Future<int> updateTicket(Map<String, dynamic> ticket) async {
    final db = await database;
    return await db.update(
      'tickets',
      ticket,
      where: 'id = ?',
      whereArgs: [ticket['id']],
    );
  }

  Future<int> deleteTicket(int id) async {
    final db = await database;
    return await db.delete(
      'tickets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAllTickets() async {
    final db = await database;
    return await db.query('tickets');
  }
}
