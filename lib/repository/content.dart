import 'package:sqflite/sqlite_api.dart';
import 'package:mova/utils/db.dart';
import 'package:mova/models/content.dart';
import 'package:mova/models/article.dart';
import 'package:mova/models/page_data.dart';

import '../i18n/ua.dart';
import '../models/search_data.dart';

Iterable<int> uniqueList(Iterable<int> list) {
  return list.toSet().toList();
}

Map<String, String> converter = {
  'а': 'a',
  'б': 'b',
  'в': 'v',
  'г': 'h',
  'ґ': 'g',
  'д': 'd',
  'е': 'e',
  'є': 'ie',
  'ж': 'zh',
  'з': 'z',
  'и': 'y',
  'і': 'i',
  'ї': 'yi',
  'й': 'y',
  'к': 'k',
  'л': 'l',
  'м': 'm',
  'н': 'n',
  'о': 'o',
  'п': 'p',
  'р': 'r',
  'с': 's',
  'т': 't',
  'у': 'u',
  'ф': 'f',
  'х': 'h',
  'ц': 'ts',
  'ч': 'ch',
  'ш': 'sh',
  'щ': 'shch',
  'ь': 'j',
  'ъ': 'j',
  'ю': 'iu',
  'я': 'ia',
  'А': 'A',
  'Б': 'B',
  'В': 'V',
  'Г': 'H',
  'Ґ': 'G',
  'Д': 'D',
  'Е': 'E',
  'Є': 'IE',
  'Ж': 'ZH',
  'З': 'Z',
  'И': 'Y',
  'І': 'I',
  'Ї': 'YI',
  'Й': 'Y',
  'К': 'K',
  'Л': 'L',
  'М': 'M',
  'Н': 'N',
  'О': 'O',
  'П': 'P',
  'Р': 'R',
  'С': 'S',
  'Т': 'T',
  'У': 'U',
  'Ф': 'F',
  'Х': 'H',
  'Ц': 'TS',
  'Ч': 'CH',
  'Ш': 'SH',
  'Щ': 'SHCH',
  'Ь': 'J',
  'Ъ': 'J',
  'Ю': 'IU',
  'Я': 'IA',
};

Content contentRow(Map row) {
  return Content(
    id: row['id'] as int,
    level: row['level'] as int,
    data: row['data'] as String,
    prefix: row['prefix'] as String,
    parent: row['parent'] as int,
    pos: row['pos'] as int,
  );
}

SearchData searchRow(Map row, List<Content> content) {
  return SearchData(
    id: row['content_id'] as int,
    level: row['content_level'] as int,
    parent: row['content_parent'] as int,
    pos: row['content_pos'] as int,
    prefix: row['content_prefix'] as String,
    data: row['content_data'] as String,
    path: content.firstWhere((c) => c.id == row['content_parent']).name,
  );
}

Future<List<Content>> loadContentByParent({int parent = 0}) async {
  Database db = await initDb();

  List<Map> rows = await db.query(
    'content',
    columns: ['id', 'level', 'parent', 'data', 'prefix', 'pos'],
    where: 'parent = ?',
    whereArgs: [parent],
  );

  return rows.isNotEmpty
      ? rows.map((row) => contentRow(row)).toList()
      : List.empty();
}

Future<List<Content>> loadContentById(Iterable<int> ids) async {
  Database db = await initDb();
  Iterable<String> placeholders = ids.map((id) => '?');

  List<Map> rows = await db.query(
    'content',
    columns: ['id', 'level', 'parent', 'data', 'prefix', 'pos'],
    where: 'id IN (${placeholders.join(',')})',
    whereArgs: [...ids],
  );

  return rows.isNotEmpty
      ? rows.map((row) => contentRow(row)).toList()
      : List.empty();
}

Future<Content> loadContentByPrefix({String prefix = ''}) async {
  Database db = await initDb();

  List<Map> rows = await db.query(
    'content',
    columns: ['id', 'level', 'parent', 'data', 'prefix', 'pos'],
    where: 'prefix = ?',
    whereArgs: [prefix],
    orderBy: 'pos',
    limit: 1,
  );

  return rows.isNotEmpty ? contentRow(rows[0]) : homeContent;
}

Future<List<Article>> loadArticles({int parentId = 0}) async {
  Database db = await initDb();

  List<Map> rows = await db.query(
    'articles',
    columns: ['id', 'data', 'parent_id', 'pos'],
    where: 'parent_id = ?',
    whereArgs: [parentId],
    orderBy: 'pos',
  );

  return rows.isNotEmpty
      ? rows
          .map((row) => Article(
                id: row['id'] as int,
                data: row['data'] as String,
                parentId: row['parent_id'] as int,
                pos: row['pos'] as int,
              ))
          .toList()
      : List.empty();
}

Future<PageData> loadPage({int parentContentId = 0}) async {
  List<Content> content = await loadContentByParent(parent: parentContentId);
  List<int> contentIds = content.map((c) => c.id).toList();

  List<Article> articles = contentIds.isEmpty
      ? await loadArticles(parentId: parentContentId)
      : List.empty();

  return PageData(content: content, articles: articles);
}

Future<List<SearchData>> findContent({String needle = ''}) async {
  var db = await initDb();
  if (needle.isEmpty) {
    return List.empty();
  }

  String search = '';
  String? letter = '';
  for (var i = 0; i < needle.length; i++) {
    letter = converter[needle[i]] ?? needle[i];
    search = search + letter;
  }

  String where = 'search_data LIKE ?';
  List whereArgs = [search];

  List<Map> rowsExactly = await db.query(
    'search',
    columns: [
      'content_id',
      'content_level',
      'content_parent',
      'content_data',
      'content_prefix',
      'content_pos'
    ],
    where: where,
    whereArgs: whereArgs,
    groupBy: 'content_id',

  );

  Iterable<int> ids = rowsExactly.map((row) => row['content_id'] as int);
  Iterable<String> placeholders = ids.map((id) => '?');

  where =
      'search_data LIKE ? and content_id NOT IN (${placeholders.join(',')})';
  whereArgs = ['$search%', ...ids];

  //await db.rawQuery('PRAGMA case_sensitive_like = true');

  List<Map> rowsStarFrom = await db.query(
    'search',
    columns: [
      'content_id',
      'content_level',
      'content_parent',
      'content_data',
      'content_prefix',
      'content_pos'
    ],
    where: where,
    whereArgs: whereArgs,
    groupBy: 'content_id',
  );

  List<Map> rows = rowsExactly + rowsStarFrom;
  Iterable<int> contentIds = rows.isNotEmpty
      ? rows.map((row) => row['content_parent'] as int)
      : [];

  List<Content> content = contentIds.isNotEmpty
      ? await loadContentById(contentIds)
      : List.empty();

  return rows.isNotEmpty
      ? rows.map((row) => searchRow(row, content)).toList()
      : List<SearchData>.empty();
}

const homeContent = Content(
  id: 0,
  level: 0,
  data: appTitle,
  parent: 0,
  pos: 0,
  prefix: '',
);

const searchContent = SearchData(
  id: 0,
  level: 0,
  data: searchTitle,
  parent: 0,
  pos: 0,
  prefix: '',
  path: ""
);
