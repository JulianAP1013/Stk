import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> get databse async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL)''');
    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT,
        stock INTEGER NOT NULL,
        precio REAL NOT NULL,
        categoria TEXT NOT NULL,
        umbral_stock_bajo INTEGER NOT NULL,
        usuarioId INTEGER NOT NULL,
        FOREIGN KEY (usuarioId) REFERENCES usuarios (id) ON DELETE CASCADE)''');
    await db.execute('''
      CREATE TABLE movimientos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productoId INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        cantidad INTEGER NOT NULL,
        fecha TEXT NOT NULL,
        observacion TEXT,
        usuarioId INTEGER NOT NULL,
        FOREIGN KEY (productoId) REFERENCES productos (id) ON DELETE CASCADE,
        FOREIGN KEY (usuarioId) REFERENCES usuarios (id) ON DELETE CASCADE)''');
  }

  void borrarBaseDeDatos() async {
    final path = join(await getDatabasesPath(), 'app.db');
    await deleteDatabase(path);
    print('Base de datos eliminada');
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Para manejar migraciones futuras
  }
}
