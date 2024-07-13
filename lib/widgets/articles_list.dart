import 'package:flutter/material.dart';

import '../models/article.dart';
import 'package:mova/styles/markdown.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return MarkdownBody(
            data: articles[index].data,
            styleSheet: stylesheet,
          );
        },
      ),
    );
  }
}
