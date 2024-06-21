import 'package:sqflite/sqlite_api.dart';
import 'package:mova/utils/db.dart';
import 'package:mova/models/content.dart';
import 'package:mova/models/article.dart';
import 'package:mova/models/page_data.dart';

import '../i18n/ua.dart';

Future<List<Content>> loadContent({int parent = 0}) async {
  Database db = await initDb();

  List<Map> rows = await db.query(
    'content',
    columns: ['id', 'level', 'parent', 'data', 'prefix', 'pos'],
    where: 'parent = ?',
    whereArgs: [parent],
    orderBy: 'pos',
  );

  return rows.isNotEmpty
      ? rows
          .map((row) => Content(
                id: row['id'] as int,
                level: row['level'] as int,
                data: row['data'] as String,
                prefix: row['prefix'] as String,
                parent: row['parent'] as int,
                pos: row['pos'] as int,
              ))
          .toList()
      : List.empty();
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
  List<Content> content = await loadContent(parent: parentContentId);
  List<int> contentIds = content.map((c) => c.id).toList();

  List<Article> articles = contentIds.isEmpty
      ? await loadArticles(parentId: parentContentId)
      : List.empty();

  return PageData(content: content, articles: articles);
}

const homeContent = Content(
  id: 0,
  level: 0,
  data: APP_TITLE,
  parent: 0,
  pos: 0,
  prefix: '',
);
