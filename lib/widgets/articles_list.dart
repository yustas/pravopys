import 'package:flutter/material.dart';
import 'package:mova/models/content.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/screens/pravopys.dart';

import '../models/article.dart';
import 'package:mova/styles/markdown.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key, required this.articles, required this.content});
  final List<Article> articles;
  final Content content;

  @override
  Widget build(BuildContext context) {

    Future<void> openContent(
        BuildContext context,
        String prefix,
        ) async {
      Content nextContent = await loadContentByPrefix(prefix: '$prefix.');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Pravopys(content: nextContent, prevContent: content),
        ),
      ); // Navigator.push(context, route)
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return MarkdownBody(
            data: articles[index].body,
            onTapLink: (text, url, title){
              openContent(context, text);
            },
            styleSheet: stylesheet,
          );
        },
      ),
    );
  }
}
