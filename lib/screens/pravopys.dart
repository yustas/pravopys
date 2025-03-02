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
import 'package:mova/utils/search.dart';

class Pravopys extends StatelessWidget {
  const Pravopys({super.key, required this.content, required this.prevContent});

  final Content content;
  final Content? prevContent;

  @override
  Widget build(BuildContext context) {
    final Future<PageData> pageData =
        loadPage(parentContentId: content.id);

    String getContentData(Content content) {
      return content.prefix.isNotEmpty
          ? "${content.prefix} ${content.data}"
          : content.data;
    }

    var isFirstScreen = prevContent == null;
    var header = getContentData(content);
    var appBarTitle = isFirstScreen ? '' : getContentData(prevContent!);
    var actions = [
      IconButton(
        icon: const Icon(Icons.search),
        tooltip: searchTitle,
        onPressed: () => search(context, ''),
      ),
      IconButton(
        icon: const Icon(Icons.home_rounded),
        tooltip: appTitle,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const Pravopys(
                content: homeContent,
                prevContent: null,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    ];

    if (isFirstScreen) {
      appBarTitle = '';
      actions = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: false,
        titleSpacing: 0,
        actions: actions,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<PageData>(
            future: pageData,
            builder: (BuildContext context, AsyncSnapshot<PageData> snapshot) {
              if (snapshot.hasData) {
                var links = snapshot.data!.content;
                var articles = snapshot.data!.articles;

                if (links.isNotEmpty) {
                  return Column(
                    children: [
                      Header(title: header, searchBar: isFirstScreen),
                      Expanded(
                        child: ContentList(
                            content: links, prevPage: content),
                      ),
                    ],
                  );
                } else {
                  return ArticlesList(
                      header: header,
                      articles: articles,
                      content: content,
                  );
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
