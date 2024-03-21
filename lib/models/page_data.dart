import 'package:mova/models/article.dart';
import 'package:mova/models/content.dart';

class PageData {
  const PageData({
    required this.content,
    required this.articles,
  });

  final List<Content> content;
  final List<Article> articles;
}
