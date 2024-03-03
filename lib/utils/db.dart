import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const dbName = 'mova.db';

Future<Database> openDatabase() async {
  final databasesPath = await syspath.getLibraryDirectory();
  final dbPath = path.join(databasesPath.path, dbName);

  var isExists = await sql.databaseExists(dbPath);

  if (true) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(path.dirname(dbPath)).create(recursive: true);
    } catch (_) {}


    // Copy from asset
    ByteData data = await rootBundle.load(path.join("assets", "db", dbName));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(dbPath).writeAsBytes(bytes, flush: true);

  } else {
    print("Opening existing database");
  }

  return await sql.openDatabase(
      path.join(databasesPath.path, dbName),
      // version: 1,
      readOnly: true,
      // onCreate: (Database db, int version) {
      //   print("DB was created (");
      // }
      // onCreate: (Database db, int version) async {
      //   await db.execute('CREATE TABLE cnt(value INTEGER)');
  );
}

Future<String> helloWorld() async {
  Database db = await openDatabase();

  final data = await db.query('content');
  db.close();

  return data.isNotEmpty ? data.first['data'] as String : 'void';
}
