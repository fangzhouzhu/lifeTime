import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/anniversary.dart';

/// 数据库服务
class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anniversaries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE anniversaries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        description TEXT,
        category TEXT NOT NULL,
        iconName TEXT,
        color INTEGER,
        isLunar INTEGER NOT NULL DEFAULT 0,
        reminder INTEGER NOT NULL DEFAULT 1
      )
    ''');
  }

  /// 创建纪念日
  Future<Anniversary> createAnniversary(Anniversary anniversary) async {
    final db = await database;
    final id = await db.insert('anniversaries', anniversary.toMap());
    return anniversary.copyWith(id: id);
  }

  /// 读取所有纪念日
  Future<List<Anniversary>> readAllAnniversaries() async {
    final db = await database;
    final result = await db.query('anniversaries', orderBy: 'date ASC');
    return result.map((map) => Anniversary.fromMap(map)).toList();
  }

  /// 读取单个纪念日
  Future<Anniversary?> readAnniversary(int id) async {
    final db = await database;
    final maps = await db.query(
      'anniversaries',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Anniversary.fromMap(maps.first);
    } else {
      return null;
    }
  }

  /// 更新纪念日
  Future<int> updateAnniversary(Anniversary anniversary) async {
    final db = await database;
    return db.update(
      'anniversaries',
      anniversary.toMap(),
      where: 'id = ?',
      whereArgs: [anniversary.id],
    );
  }

  /// 删除纪念日
  Future<int> deleteAnniversary(int id) async {
    final db = await database;
    return await db.delete(
      'anniversaries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 按分类读取
  Future<List<Anniversary>> readAnniversariesByCategory(String category) async {
    final db = await database;
    final result = await db.query(
      'anniversaries',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date ASC',
    );
    return result.map((map) => Anniversary.fromMap(map)).toList();
  }

  /// 关闭数据库
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
