import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:logging/logging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  isExists
      ? log.info("Opening existing database")
      : await copyDatabase(path.join("assets", "db", dbName), dbPath);

  return await sql.openDatabase(dbPath);
}

Future<void> deleteDatabase() async {
  var path = await getDatabasePath();
  log.info("Delete database: $path");
  sql.deleteDatabase(path);
}

Future<Database> initDb() async {
  var db = await openDatabase();
  var actualVersion = int.parse(dotenv.get('DB_VERSION', fallback: '0'));

  if (await db.getVersion() < actualVersion) {
    log.info("Upgrade DB file to version: $actualVersion");
    db.close();
    await deleteDatabase();
    db = await openDatabase();

    db.setVersion(actualVersion);
  }
  
  //db.rawQuery("SELECT icu_load_collation('uk-UA', 'Ukrainian')");

  return db;
}
