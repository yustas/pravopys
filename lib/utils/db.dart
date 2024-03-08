import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:logging/logging.dart';
import 'package:mova/models/content.dart';

const String dbName = 'mova.db';
final log = Logger('DB');

Future<String> getDatabasePath() async {
  final databasesPath = await syspath.getLibraryDirectory();
  return path.join(databasesPath.path, dbName);
}

Future<void> copyDatabase(String from, String to) async {
  // Should happen only the first time you launch your application
  log.info("Creating new copy from asset");

  // Make sure the parent directory exists
  try {
    await Directory(path.dirname(to)).create(recursive: true);
  } catch (_) {}

  // Copy from asset
  ByteData data = await rootBundle.load(from);
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // Write and flush the bytes written
  await File(to).writeAsBytes(bytes, flush: true);
}

Future<Database> openDatabase() async {
  final dbPath = await getDatabasePath();
  var isExists = await sql.databaseExists(dbPath);

  true
      ? await copyDatabase(path.join("assets", "db", dbName), dbPath)
      : log.info("Opening existing database");

  return await sql.openDatabase(
    dbPath,
    // version: 1,
    readOnly: true,
    // onCreate: (Database db, int version) {
    //   print("DB was created (");
    // }
    // onCreate: (Database db, int version) async {
    //   await db.execute('CREATE TABLE cnt(value INTEGER)');
  );
}

Future<List<Content>> loadContent() async {
  Database db = await openDatabase();

  List<Map> rows = await db.query('content',
      columns: ['id', 'level', 'parent', 'data', 'version'],
      where: 'parent = ?',
      whereArgs: [0]);

  return rows.isNotEmpty
      ? rows
          .map((row) => Content(
                id: row['id'] as int,
                level: row['level'] as int,
                data: row['data'] as String,
                parent: row['parent'] as int,
                // version: row['version'] as int,
              ))
          .toList()
      : List.empty();
}
