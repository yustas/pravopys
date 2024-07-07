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
  const Pravopys({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  State<Pravopys> createState() => _PravopysState();
}

class _PravopysState extends State<Pravopys> {
  @override
  Widget build(BuildContext context) {
    final Future<PageData> pageData =
        loadPage(parentContentId: widget.content.id);

    var isFirstScreen = widget.content.data == APP_TITLE;
    var header = widget.content.prefix.isNotEmpty
        ? "${widget.content.prefix} ${widget.content.data}"
        : widget.content.data;
    var appBarTitle = header;

    if (isFirstScreen) {
      FlutterNativeSplash.remove();
      appBarTitle = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
                  return ContentList(content: content);
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
