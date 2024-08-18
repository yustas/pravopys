import 'package:flutter/material.dart';
import 'package:mova/models/content.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/screens/pravopys.dart';

import '../models/article.dart';
import 'package:mova/styles/markdown.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList(
      {super.key, required this.articles, required this.content, required this.onScroll});

  final List<Article> articles;
  final Content content;
  final void Function(ScrollPosition) onScroll;

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {

  final ScrollController _scrollController = ScrollController();

  _scrollListener() {
    widget.onScroll(_scrollController.position);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> openContent(
      BuildContext context,
      String prefix,
    ) async {
      Content nextContent = await loadContentByPrefix(prefix: '$prefix.');
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                Pravopys(content: nextContent, prevContent: widget.content),
          ),
        ); // Navigator.push(context, route)
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          return MarkdownBody(
            data: widget.articles[index].body,
            onTapLink: (text, url, title) {
              openContent(context, text);
            },
            styleSheet: stylesheet,
          );
        },
      ),
    );
  }
}
