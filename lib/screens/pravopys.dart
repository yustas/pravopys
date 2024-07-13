import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/models/page_data.dart';
import 'package:mova/models/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/widgets/header.dart';
import 'package:mova/widgets/content_list.dart';
import 'package:mova/widgets/articles_list.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Pravopys extends StatefulWidget {
  const Pravopys({super.key, required this.content, required this.prevContent});

  final Content content;
  final Content? prevContent;

  @override
  State<Pravopys> createState() => _PravopysState();
}

class _PravopysState extends State<Pravopys> {
  @override
  Widget build(BuildContext context) {
    final Future<PageData> pageData =
        loadPage(parentContentId: widget.content.id);

    String getContentData(Content content) {
      return content.prefix.isNotEmpty
          ? "${content.prefix} ${content.data}"
          : content.data;
    }

    var isFirstScreen = widget.prevContent == null;
    var header = getContentData(widget.content);
    var appBarTitle = isFirstScreen ? '' : getContentData(widget.prevContent!);
    var actions = [
      IconButton(
        icon: const Icon(Icons.search),
        tooltip: 'Пошук',
        onPressed: () {
          // handle the press
        },
      ),
      IconButton(
        icon: const Icon(Icons.home_rounded),
        tooltip: 'Головна',
        onPressed: () {
          // handle the press
        },
      ),
    ];

    if (isFirstScreen) {
      FlutterNativeSplash.remove();
      appBarTitle = '';
      actions = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: actions,
      ),
      body: Column(
        children: [
          Header(title: header, searchBar: isFirstScreen),
          Expanded(
              child: FutureBuilder<PageData>(
            future: pageData,
            builder: (BuildContext context, AsyncSnapshot<PageData> snapshot) {
              if (snapshot.hasData) {
                var content = snapshot.data!.content;
                var articles = snapshot.data!.articles;

                if (content.isNotEmpty) {
                  return ContentList(
                      content: content, prevPage: widget.content);
                } else {
                  return ArticlesList(articles: articles);
                }
              } else if (snapshot.hasError) {
                return Error(message: 'Error: ${snapshot.error}');
              } else {
                return const Loading();
              }
            },
          ))
        ],
      ),
    );
  }
}
